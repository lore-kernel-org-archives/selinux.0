Subject: Re: How can modular policy ever have worked? [patch]
From: Erich Schubert <erich@debian.org>
To: sds@tycho.nsa.gov
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 20 Mar 2006 16:16:26 +0100
Message-Id: <1142867787.6145.18.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,
> > Committing changes:
> > /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> Any "security:" messages from the kernel in /var/log/messages upon the
> attempted policy load?

No. A strace shows that load_policy is writing data to the load
interface,
which results in this invalid argument error:
open("/selinux/load", O_RDWR|O_LARGEFILE) = 4
write(4, "\214\377|\371\10\0\0\0SE Linux\24\0\0\0\1\0\0\0\10\0\0"...,
592395) = -1 EINVAL (Invalid argument)

Any progress on the optional{} in base.pp issues?
I have the impression that type attributes are broken; for example
almost all (I can't say for sure, apol doesn't work for me; is there any
other "policy decompiler"?) the restorecon_t relabelto rules are
missing, which are defined for file_type.
So I have the impression that when linking the base policy with
optionals, these attributes are messed up.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  There is no branch of mathematics, however abstract, which may not  //\
 some day be applied to phenomena of the real world. --- Lobatchevsky V_/_
       Nichts l‰ﬂt die Erde so ger‰umig erscheinen, als wenn man
           Freunde in der Ferne hat. --- Henry David Thoreau



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
