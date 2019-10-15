"""
>> ProfanityBot
> Python 3.7.4

The main file for this discord.py bot.

Running the bot:
    First time usage:
        If you haven't already, install virtualenv:
            $ pip install virtualenv
        Activate the environment:
            Bash:
                source env/Scripts/activate
        Install requirements:
            $ python pip install -r requirements.txt
    Starting the bot:
        $ py -3 bot.py

Todo:
    * None. All it done, all is good.
"""


import datetime
import json
import numpy as np

from discord.ext import commands
import discord
from profanity_check import predict


class MainCog(commands.Cog):

    def __init__(self, bot):
        self.bot = bot

    @commands.Cog.listener()
    async def on_ready(self):
        """Alerts launcher that the bot has logged in and is ready for use

        Returns:
            A message of credentials (no token involved)

        Raises:
            Possible error messages if connection and/or token fails

        """
        info = [
            f'[{datetime.datetime.now()}]'
            f'Logged in as: {self.bot.user}',
            f'Bot ID: {self.bot.user.id}',
            f'Ping: {self.bot.latency}'
        ]  # Can add information later
        print('\n'.join(f'> {i}' for i in info))

    @commands.Cog.listener()
    async def on_message(self, message):
        prediction = predict([message.content])
        if np.mean(prediction) >= 0.8:
            embed = discord.Embed(title=f'Bad words/phrases detected.',
                                  timestamp=datetime.datetime.now(),
                                  colour=0xFF0000)
            lst = [
                f'Message content by {message.author.mention}:',
                f'||{message.content}||',
                f'Certainty: {np.mean(prediction) * 100}%'
            ]
            embed.description = '\n'.join(str(y) for y in lst)
            await message.channel.send(embed=embed)
            await message.delete()

    @commands.command()
    async def exit(self, ctx):
        """Makes the bot logout"""
        print('Logging out...')
        await ctx.bot.logout()


if __name__ == "__main__":
    with open('config/config.json', 'r') as f:
        token = json.load(f)
    bot = commands.Bot(command_prefix=commands.when_mentioned_or(';;'))
    bot.owner_ids = set(token['owners'])
    bot.add_cog(MainCog(bot))
    bot.run(token['discord'], bot=True, reconnect=True)
