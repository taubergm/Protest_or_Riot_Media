import pandas as pd 

media_polarity = {
        "247sports.com": "NA",
        "ABC News": -1,
        "AirforceTimes": "NA",
        "Alternet": -2,
        "American Free Press": "NA",
        "American Spectator": "NA",
        "amp.freep.com": "NA",
        "AOL News": "NA",
        "aol.sportingnews.com": "NA",
        "Arkansas Democrat-Gazette": -2,
        "ArmyTimes": "NA",
        "arstechnica.com": "NA",
        "Atlanta Journal-Constitution": -1,
        "Atlantic": -1,
        "augustachronicle.com": "NA",
        "AZCentral": 0,
        "Baltimore Sun": "NA",
        "Benzinga": "NA",
        "berkshireeagle.com": "NA",
        "Billboard": "NA",
        "Blaze": 2,
        "Bleacher Report": "NA",
        "blogs.barrons.com": "NA",
        "blogs.indystar.com": 0,
        "Bloomberg": -1,
        "Breitbart": 2,
        "Business Insider": 0,
        "BusinessWeek.com": "NA",
        "Bustle": -1,
        "Buzzfeed": -2,
        "CBS News": -1,
        "cbssports.com": -1,
        "Central Maine News": "NA",
        "cherokeephoenix.org": "NA",
        "Chicago Tribune": 0,
        "Christian Science Monitor": 0,
        "cincinnati.com": "NA",
        "cleveland.com": "NA",
        "CNBC": "NA",
        "CNET": 0,
        "CNN": -2,
        "CNN U.S. Edition": -2,
        "CNS News": 2,
        "colorlines.com": "NA",
        "Columbus Dispatch": "NA",
        "Conversation": "NA",
        "creators.com": "NA",
        "CSPAN": "NA",
        "Daily Beast": -2,
        "Daily Caller": 2,
        "Daily Dot": -1,
        "Daily Kos": -2,
        "Daily Signal": 2,
        "Daily Source": "NA",
        "Dallas Morning News": 0,
    "Deadspin": "NA",
    "E! Online": "NA", 
    "eater.com": "NA",
    "El Nuevo Dia": "NA",
        "elitedaily.com": "NA",
    "engadget": "NA",
    "Entertainment Weekly": "NA",
    "ESPN": "NA",
    "eurweb": "NA",
    "FactCheck": 0,
    "Fansided": "NA",
    "fark.com": "NA",
    "fayobserver.com": "NA",
    "FiveThirtyEight": 0,
    "Forbes": 0,
    "Fortune": 0,
    "Fox News": 2,
    "Fox Sports": "NA",
    "Fusion": "NA",
    "Gawker": "NA",
    "gazettenet.com": "NA",
    "Gizmodo": -1,
    "globalpost.com": "NA",
    "gq.com": -1,
    "Grist": -1,
    "Guardian": -1,
    "Guardian US": -1,
    "Harper's Magazine": "NA",
    "Hartford Courant": "NA",
    "hollywoodlife.com": "NA",
    "HonululuAdvertiser": "NA",
    "Hot Air": 1,
    "houstonchronicle": 0,
    "Hoy Chicago": "NA",
    "Huffington Post - United States": -2,
    "Huffington Post Black Voices": -2,
    "HuffPost": -2,
    "HuffPost Latino Voices": -2,
    "IBTimes": 0,
    "ign.com": "NA",
    "ihavenet.com": "NA",
    "Indian Country Today": "NA",
    "Indiewire": "NA",
    "Inquirer": "NA",
    "Inquisitr": "NA",
    "Intercept": -2,
    "Investors": "NA",
    "Jezebel": -2,
    "LA Times": -1,
    "livescience.com": 0,
    "marinetimes.com": "NA",
    "Marketwatch": 0,
    "Mashable!": "NA",
    "media.oregonlive.com": "NA",
    "Miami Herald": -1,
    "Mic": "NA",
    "Milwaukee Journal Sentinel": "NA",
    "MintPress News": "NA",
    "mlive.com": "NA",
    "Mongabay": "NA",
    "monstersandcritics": "NA",
    "Mother Jones": -2,
    "mysanantonio.com": "NA",
    "National Catholic Register": "NA",
    "National Memo": "NA",
    "National Review": 2,
    "NavyTimes": "NA",
    "NBC Breaking News": -1,
    "ncronline.org": "NA",
    "New York Post": 1,
    "New York Times": -1,
    "New Yorker": -2,
    "newsblaze.com": "NA",
    "NewsBusters": 2,
    "Newsday": "NA",
    "Newsmax": 1,
    "newsone.com": -2,
    "Newsweek": 0,
    "newsy": 0,
    "nhgazette.com": "NA",
    "nj.com": "NA",
    "norwichbulletin.com": "NA",
    "NPR": -1,
    "Oan": 2,
    "observer.com": 0,
    "Omaha World-Herald": "NA",
    "opednews.com": "NA",
    "OpenSecrets": 0,
    "opposingviews.com": "NA",
    "Orange County Register": 1,
    "Orlando Sentinel": "NA",
    "Parade": "NA",
    "patriot post": "NA",
    "PBS NewsHour": 0,
    "PEOPLE.com": "NA",
    "pilotonline.com": "NA",
    "pitchfork.com": "NA",
    "Pittsburgh Post-Gazette": 1,
    "PJ Media": 2,
    "Politico": -1,
    "polygon.com": "NA",
    "popmatters": "NA",
    "Post and Courier": "NA",
    "Press-Republican": "NA",
    "ProPublica": -1,
    "providencejournal.com": "NA",
    "Quartz": 0,
    "Raw Story": -2,
    "Re/code": "NA",
    "RealClearPolitics": 0,
    "Reason.com": 1,
    "Red Herring": "NA",
    "RedState": 2,
    "Refinery29": -2,
    "Reuters": 0,
    "Roll Call": 0,
    "Rolling Stone": -2,
    "rttnews": "NA",
    "rutlandherald.com": "NA",
    "Salon": -2,
    "San Diego Union Tribune": -1,
    "San Jose Mercury News": "NA",
    "Saturday Evening Post": "NA",
    "SB Nation": "NA",
    "Schwartzreport": "NA",
    "Scientific American": -1,
    "Seattle Times": "NA",
    "sentinelsource.com": "NA",
    "SF Chronicle": -1,
    "Slate.com": -2,
    "South Florida Sun-Sentinel": "NA",
    "St. Louis Post-Dispatch": "NA",
    "St.Paul Pioneer-Press": "NA",
    "Star Tribune": "NA",
    "Stars and Stripes" :"NA",
    "Stateline - News about state government and politics from The Pew Center on the States": "NA",
    "Superglue: MSNBC": -2,
    "Taegan Goddard's Political Wire": "NA",
    "Talk Media News": "NA", 
    "Talking Points Memo": "NA",
    "Tampa Bay Times": "NA",
    "TechCrunch": "NA",
    "techradar.com": "NA",
    "The Boston Globe": -1,
    "The Buffalo News": "NA",
    "The Insider": "NA",
    "The Nation": -2,
    "The New Replublic": -2,
    "The Onion": -1,
    "The Street": "NA",
    "The Week": 0,
    "The Wrap": "NA",
    "TheRealNews.com": "NA",
    "theroot.com": -1,
    "thrillist.com": "NA",
    "Time": -1,
    "TMZ": "NA",
    "townhall.com": 2,
    "Truthout": -1,
    "UPI": "NA",
    "uproxx.com": "NA",
    "Upworthy": "NA",
    "US News & World Report": -1,
    "US Weekly": "NA",
    "USA Today": 0,
    "Vanity Fair": -1,
    "variety.com": 0,
    "Verge": -1,
    "VICE": -2,
    "Vox": -2,
    "Wall Street Journal": 1,
    "Washington Post": -1,
    "wired": 0,
    "x17online.com": "NA",
    "yardbarker": "NA",
    "zdnet": "NA",
}

def f(row):
    if row['media_name'] in media_polarity.keys():
        return media_polarity[row['media_name']]
    else:
        return "NA"

protest_data = pd.read_csv("./csvs/protest-all-story-urls-20210117023531.csv")
protest_data["polarity"] = protest_data.apply(f, axis=1)

riot_data = pd.read_csv("./csvs/riot-all-story-urls-20210112170353.csv")
riot_data["polarity"] = riot_data.apply(f, axis=1)

looting_data = pd.read_csv("./csvs/looting-all-story-urls-20210117022027.csv")
looting_data["polarity"] = looting_data.apply(f, axis=1)

mob_data = pd.read_csv("./csvs/mob-all-story-urls-20210117021905.csv")
mob_data["polarity"] = mob_data.apply(f, axis=1)

unrest_data = pd.read_csv("./csvs/unrest-all-story-urls-20210119031600.csv")
unrest_data["polarity"] = unrest_data.apply(f, axis=1)

floyd_data = pd.read_csv("./csvs/floyd-all-story-urls-20210119045459.csv")
floyd_data["polarity"] = floyd_data.apply(f, axis=1)

dc_data = pd.read_csv("./csvs/capitol-hill-all-story-urls-20210119055556.csv")
dc_data["polarity"] = dc_data.apply(f, axis=1)

capitol_riot = pd.read_csv("./csvs/capitol-and-riot-all-story-urls-20210119224550.csv")
capitol_riot["polarity"] = capitol_riot.apply(f, axis=1)

capitol_protest = pd.read_csv("./csvs/capitol-and-protest-all-story-urls-20210119224852.csv")
capitol_protest["polarity"] = capitol_riot.apply(f, axis=1)

blm_data = pd.read_csv("./csvs/blm-all-story-urls-20210117023329.csv")
blm_data["polarity"] = blm_data.apply(f, axis=1)

insurrection_data = pd.read_csv("./csvs/insurrection-all-story-urls-20210121061737.csv")
insurrection_data["polarity"] = insurrection_data.apply(f, axis=1)

police_data = pd.read_csv("./csvs/police-all-story-urls-20210121061536.csv")
police_data["polarity"] = police_data.apply(f, axis=1)

pb_data = pd.read_csv("./csvs/proud-boys-all-story-urls-20210123001646.csv")
pb_data["polarity"] = pb_data.apply(f, axis=1)

antifa_data = pd.read_csv("./csvs/antifa-all-story-urls-20210123001624.csv")
antifa_data["polarity"] = antifa_data.apply(f, axis=1)

yemen_data = pd.read_csv("./csvs/yemen-all-story-urls-20210128185003.csv")
yemen_data["polarity"] = yemen_data.apply(f, axis=1)

syria_data = pd.read_csv("./csvs/syria-all-story-urls-20210128185433.csv")
syria_data["polarity"] = syria_data.apply(f, axis=1)

racism_data = pd.read_csv("./csvs/racism-all-story-urls-20210129211326.csv")
racism_data["polarity"] = racism_data.apply(f, axis=1)


protest_data.to_csv("./csvs/protest_2020.csv")
riot_data.to_csv("./csvs/riot_2020.csv")
looting_data.to_csv("./csvs/looting_2020.csv")
mob_data.to_csv("./csvs/mob_2020.csv")
unrest_data.to_csv("./csvs/unrest_2020.csv")
floyd_data.to_csv("./csvs/floyd_2020.csv")
dc_data.to_csv("./csvs/dc_2020.csv")
blm_data.to_csv("./csvs/blm_2020.csv")
capitol_riot.to_csv("./csvs/capitol_riot_2020.csv")
capitol_protest.to_csv("./csvs/capitol_protest_2020.csv")
insurrection_data.to_csv("./csvs/insurrection_2020.csv")
police_data.to_csv("./csvs/police_2020.csv")
pb_data.to_csv("./csvs/pb_2020.csv")
antifa_data.to_csv("./csvs/antifa_2020.csv")
yemen_data.to_csv("./csvs/yemen_2020.csv")
syria_data.to_csv("./csvs/syria_2020.csv")
racism_data.to_csv("./csvs/racism_2020.csv")



