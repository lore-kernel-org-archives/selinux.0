Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HMZ228031183
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 18:35:03 -0400
Received: from web36612.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6HMZ0XA029838
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 22:35:00 GMT
Message-ID: <20060717223444.4837.qmail@web36612.mail.mud.yahoo.com>
Date: Mon, 17 Jul 2006 15:34:44 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/6] netfilter integration
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1153168349.10090.45.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- "Christopher J. PeBenito" <cpebenito@tresys.com>
wrote:

> This patchset adds support for netfilter secmark
> rules in all policy
> packages.  Each line of the file has a priority
> (1-9) at the beginning
> of the line, and the remainder is treated as the
> rule.  Sorting is by
> priority (1-9), and is stable within a module.  The
> current design is
> for the resultant netfilter_contexts file be
> suitable for use with
> iptables-restore.

How confident are you that 9 priorities
will be sufficient? I can easily imaging
dependency scenarios that would exceed
this limitation. I would also expect that
explict ordering within a priority is 
going to be requested as soon as this
goes into production.

Speaking of dependencies, wouldn't a
mechanism to declare dependencies a'la
make be more precise? Just a thought.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
