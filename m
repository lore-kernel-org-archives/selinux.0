Date: Fri, 4 Nov 2005 19:35:51 +0100
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
Subject: Re: changes in ~2.6.13 break postfix policy?
Message-ID: <20051104183551.GC2837@legolas.drinsama.de>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de> <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> between 2.6.12 and 2.6.13 AFAIK.   Do you see the behavior with a 2.6.12
> kernel as well?

I can't tell for sure where I see it. Actually I just noticed that I
don't see it on the main mailserver, which is running 2.6.13 currently.
So it must be related to something else on the systems... :-(
But that might be due to that system running in enforcing mode.

Postfix is that of debian stable. Init is that of debian unstable.

On the system where I can observe the problem for sure, I upgraded from
a self-compiled 2.6.8 to 2.6.13 (as of debian experimental) then to 2.6.14
(as of debian unstable). The problem appeared after 2.6.8

Regards,
Erich
-- 
     erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
     Go away or i'll replace you with a very small shell script.      //\
 Jemanden zu lieben heißt glücklich zu sein, ihn glücklich zu sehen.  V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
