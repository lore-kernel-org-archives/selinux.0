Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06569
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 10:40:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA06723
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 14:38:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA06717 for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 14:38:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>, "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: Re: audit bug in fd handling
Date: Wed, 10 Jul 2002 16:40:11 +0200
References: <007501c22814$f5949e90$0a01a8c0@ed>
In-Reply-To: <007501c22814$f5949e90$0a01a8c0@ed>
MIME-Version: 1.0
Message-Id: <20020710144012.524CB2F71@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 10 Jul 2002 15:23, Ed Street wrote:
> Perhaps this is why mail is the #1 exploited service.  So what's the
> solution?

I'm not sure what you mean by this.  The bug I found was just a case of 
excessive logging and does no harm (apart from possibly encouraging 
inexperienced SE Linux administrators to grant excessive permissions).

The issue of an application granting write access to the file is annoying, 
however it is apparently operating on an open file handle pointing to a 
deleted file, after deleting the file you can't re-open it in read-only mode.

In this case fcron could either open the file twice before deleting it (once 
for read and once for write), or it could pipe the data to /usr/bin/mail 
(either directly from the cron job, or it could spool it in RAM).

What should it do?  I am happy to write a patch for fcron and get it 
submitted through the Debian bug tracking system if a consensus of opinion is 
reached here on the right way of doing it.

> => -----Original Message-----
> => From: owner-selinux@tycho.nsa.gov
> [mailto:owner-selinux@tycho.nsa.gov] On
> => Behalf Of Russell Coker
> => Sent: Wednesday, July 10, 2002 3:46 AM
> => To: SE Linux
> => Subject: audit bug in fd handling
> =>
> => It seems that when a file handle open read/write is inherited by a
> domain
> => that is permitted read access only, an error about write access will
> be
> => logged - even if there is a dontaudit rule!
> =>
> => Here's the dmesg log:
> => avc:  denied  { write } for  pid=4731 exe=/usr/sbin/sendmail
> => path=/spool/fcron/fcrjob-Ldo3Uf (deleted) dev=03:08 ino=27923
> => scontext=system_u:system_r:system_mail_t
> => tcontext=system_u:object_r:system_crond_tmp_t tclass=file
> =>
> => Here's a grep from policy.conf:
> => dontaudit system_mail_t system_crond_tmp_t:file write;
> =>
> =>
> => Incidentally I'm changing the way mail sending operates.  Having
> daemons
> => send
> => mail as sysadm_mail_t is ugly, and having them send mail as
> user_mail_t
> => is
> => wrong.  I've created a new system_mail_t for this.
> =>
> => --
> => I do not get viruses because I do not use MS software.
> => If you use Outlook then please do not put my email address in your
> => address-book so that WHEN you get a virus it won't use my address in
> the
> => >From field.
> =>
> => --
> => You have received this message because you are subscribed to the
> selinux
> => list.
> => If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov
> => with
> => the words "unsubscribe selinux" without quotes as the message.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
