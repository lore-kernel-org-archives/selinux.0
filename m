Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6I0IPuc032446
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 20:18:25 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6I0IOXA012377
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 00:18:24 GMT
Message-ID: <44BC28BB.1080701@tresys.com>
Date: Mon, 17 Jul 2006 20:18:03 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/6] netfilter integration
References: <20060717223444.4837.qmail@web36612.mail.mud.yahoo.com>
In-Reply-To: <20060717223444.4837.qmail@web36612.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> 
> --- "Christopher J. PeBenito" <cpebenito@tresys.com>
> wrote:
> 
>> This patchset adds support for netfilter secmark
>> rules in all policy
>> packages.  Each line of the file has a priority
>> (1-9) at the beginning
>> of the line, and the remainder is treated as the
>> rule.  Sorting is by
>> priority (1-9), and is stable within a module.  The
>> current design is
>> for the resultant netfilter_contexts file be
>> suitable for use with
>> iptables-restore.
> 
> How confident are you that 9 priorities
> will be sufficient? I can easily imaging
> dependency scenarios that would exceed
> this limitation. I would also expect that
> explict ordering within a priority is 
> going to be requested as soon as this
> goes into production.
> 
in reality probably 3 priorities would be sufficient. Specific port, 
port range and fallback. Its very doubtful that anything else would be 
necessary, especially in modules where the priority is much more 
important than in base. A module will very rarely have something more 
specific than ports, and since ports are non-overlapping it doesn't 
matter what order they are in (within a single priority)

> Speaking of dependencies, wouldn't a
> mechanism to declare dependencies a'la
> make be more precise? Just a thought.
> 
> 
eh? Policy modules already declare symbol dependencies explicitly (eg., 
which types, roles, etc this module uses)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
