Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i725Z8rT009997
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 01:35:08 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i725Z6KV002492
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 05:35:07 GMT
Subject: Re: user-directory _is_ home directory
From: Erich Schubert <erich@debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801202740.GG20103@lkcl.net>
References: <20040801143236.GA15949@lkcl.net>
	 <1091388560.7861.7.camel@wintermute.xmldesign.de>
	 <20040801202740.GG20103@lkcl.net>
Content-Type: text/plain
Date: Sun, 01 Aug 2004 22:30:25 +0200
Message-Id: <1091392225.7861.28.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>  so, if i create a /MyDocuments and symlink it to
>  /home/theoneandonlyuser, then that STILL leaves them with
>  /home/theoneandonlyuser in the kde devices's list.

Instead of raping the FHS, why don't you just patch Konqueror/KDE
to not display the devices list at all?
Or use some "path to name" mapping and display a nicer name instead?

For the stupid user, KDE is a bad choice. It is way to overloaded.
I'd suggest using Gnome, which was designed with usability in mind.

Have a look at the following screenshot (from the gnome web site)

http://fgo-temp.acc.umu.se/pub/GNOME/teams/marketing/en/2004/two-six-
screenshots/html/large/Kenneth_1.png

Gnome displays these "contents" of "computer" without doing such ugly
hacks as you suggest. When i plugin my flash drive, hotplug, hal and
gnome-volume-manager work together and a new icon appears there.
I bet it is not too hard to hide the "Filesystem" icon altogether.
(probably just adding a strcmp at the right place, but maybe there is an
option for that already...)

So there is no need in breaking with Linux standards just for supporting
stupid users. Giving them an appropriate UI is enough.
(In fact you will want to keep them out of anything but /media
and /home/user altogether probably)

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
                Wege entstehen, wenn wir sie gehen.                 V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
