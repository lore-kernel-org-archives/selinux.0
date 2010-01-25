Subject: Re: bzip support in libsemanage and out of memory (userspace
 ticket 7)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: jbrindle@tresys.com, cpebenito@tresys.com, selinux@tycho.nsa.gov,
        refpolicy@oss1.tresys.com
In-Reply-To: <201001251615.o0PGFlV2021048@vivaldi13.register.it>
References: <201001251615.o0PGFlV2021048@vivaldi13.register.it>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 11:31:38 -0500
Message-Id: <1264437098.4297.180.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-01-25 at 17:15 +0100, Guido Trentalancia wrote:
> Dear Stephen,
> 
> I have attached the build.conf and modules.conf files that have been used to build the policy.
> 
> Please note the "out of memory" error mentioned in the subject was generated with older versions of semodule (before upgrading to the versions mentioned in my original message).
> 
> I do apologise for dropping out the list in the previous message...

With that build.conf, refpolicy build fails with:
make: *** No rule to make target `/seusers', needed by `tmp/seusers'.  Stop.

This was with make 3.81 on Fedora 12.  Chris?

Anyway, at this point I'd have to suggest that you supply your actual .pp file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
