Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16627
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 08:24:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA26519
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 12:22:38 GMT
Received: from web40204.mail.yahoo.com (web40204.mail.yahoo.com [66.218.78.65])
        by jazzband.ncsc.mil  with SMTP id MAA26515 for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 12:22:37 GMT
Message-ID: <20020626122402.14675.qmail@web40204.mail.yahoo.com>
Date: Wed, 26 Jun 2002 05:24:02 -0700 (PDT)
From: Michael Nyika <nyix@yahoo.com>
Subject: Re: Configuration issues on a new installation
To: Brad Chapman <jabiru_croc@yahoo.com>,
        SELinux Mailinglist <selinux@tycho.nsa.gov>
In-Reply-To: <20020626004319.69515.qmail@web40010.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good-day, 
I have found that i found the same avc denied messages
on my 2.4.18 SElinux kernel. I manually edited the
specific te files, just by looking at the messages
from dmesg. i eliminated all but two. They are realted
to the kernel_t domain and have to do with write
permissions mainly.


--- Brad Chapman <jabiru_croc@yahoo.com> wrote:
> Everyone,
> 
>      I have just started using SELinux on my 2.4.18
> system. I found an enormous
> number of avc: denied messages in my dmesg and
> attempted to remove them. So far
> I have tweaked the devfs_contexts and the
> policy.conf files (using
> scripts/newrules.pl for policy.conf) since most of
> the errors were related to
> device files and system call commands. I have also
> installed the SELinux devfsd
> extension and added the config entries to my
> devfsd.conf, to no apparent avail.
> 
>      What is the fastest way to eliminate most (if
> not preferably all) of these
> messages and put me closer to activating enforcing
> mode?
> 
> Thanks,
> 
> Brad Chapman
> 
> =====
> Brad Chapman
> 
> Permanent e-mails: kakadu_croc@yahoo.com
> 		   jabiru_croc@yahoo.com
> 		   tanami_croc@devel.lbsd.net
> 
> __________________________________________________
> Do You Yahoo!?
> LAUNCH - Your Yahoo! Music Experience
> http://launch.yahoo.com
> 
> --
> You have received this message because you are
> subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message.


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
