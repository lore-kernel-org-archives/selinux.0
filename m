Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7L29Vq6011633
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 22:09:31 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7L29TUA013667
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 02:09:29 GMT
In-Reply-To: <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil>
References: <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com> <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: weird mprotect error
Date: Mon, 20 Aug 2007 21:09:20 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 17, 2007, at 2:47 PM, Stephen Smalley wrote:

> On Fri, 2007-08-17 at 11:05 -0400, Christopher J. PeBenito wrote:
>> I was working on a RHEL 5.1 beta machine with MLS policy, and I  
>> get a weird mprotect EACCES error in enforcing.  I have the  
>> folowing hello-world program:
>> ...
>> init_ranged_daemon_domain(mlstest_t,mlstest_exec_t,s4:c0.c253)
>> ...
>> #mls_fd_use_all_levels(mlstest_t)
>>
>> Without the one mls rule, I get a denial, as expected, since  
>> mlstest_t's level is not equal to initrc_t's:
>>
> mprotect/mmap checks are against the "open file" object aka struct  
> file,
> and thus include a fd use check (if the open file was originally  
> created
> by a task in another label).  So you could very well get such a denial
> from mprotect on a mapping of ld.so.

Any recommendations on how to start an unprivileged non SystemLow  
daemon? This seems broken.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
