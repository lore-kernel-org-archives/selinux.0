Subject: Re: bzip support in libsemanage and out of memory (userspace
 ticket 7)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, cpebenito@tresys.com,
        Manoj Srivastava <srivasta@golden-gryphon.com>
In-Reply-To: <201001251905.o0PJ5m4V030845@vivaldi39.register.it>
References: <201001251905.o0PJ5m4V030845@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 14:14:10 -0500
Message-Id: <1264446850.4297.237.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-01-25 at 20:05 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> thanks for your message. The situation is now clear. A bug in glibc which is at version 2.7 on my Debian Lenny system.
> 
> The patch sounds great. Should I go ahead with testing it and then report ?

Yes, that would be helpful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
