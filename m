Subject: Re: changes in ~2.6.13 break postfix policy?
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
In-Reply-To: <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
	 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
	 <20051104183551.GC2837@legolas.drinsama.de>
	 <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
	 <1131148407.1355.21.camel@wintermute.xmldesign.de>
	 <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 08 Nov 2005 20:31:11 +0100
Message-Id: <1131478271.17745.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> Hmmm...can you supply any more info to help reproduce the bug?

I've upgraded a box of mine running a self-compiled 2.6.14-rc3 to
debians 2.6.14 - and the error has appeared on it, too.
So it's not caused by the policy, but either by some .config thing or a
patch in the debian kernel. I doubt that there has happened anything
relevant between rc3 and final...
I'm going to build a 2.6.14 from vanilla sources with the .config of my
installed debian kernel to narrow down.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                 Friends are those who reach out for                 //\
                   your hand but touch your heart.                   V_/_
   Wo befreundete Wege zusammenlaufen, da sieht die ganze Welt für
         eine Stunde wie eine Heimat aus. --- Herrmann Hesse



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
