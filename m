Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0VB3UTD009833
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 06:03:32 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0VB3Vva021781
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 11:03:32 GMT
Message-ID: <4D4696F9.90303@itechfrontiers.com>
Date: Mon, 31 Jan 2011 06:03:21 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Tiny version of SE-PostgreSQL got merged
References: <4D466F3B.6090906@ak.jp.nec.com>
In-Reply-To: <4D466F3B.6090906@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

It's a great job,  but I got a licensing issue: (Due to my job I have to 
scrutinize Legal implications of source codes first)

SE-Postgresql uses libselinux,

libselinux tends to be in Public domain, serving as an interface for 
selinux modules in kernel (which is GPL)

the problem is in libselinux/src/avc.c

http://userspace.selinuxproject.org/trac/browser/libselinux/src/avc.c

the author: Eamon Walsh
with the National Computer Security Center (the NSA)
indicated this file is "Derived" from kernel AVC (which is GPL v 2.1)
_____________________________________________________________
/*
  * Implementation of the userspace access vector cache (AVC).
  *
  * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
  *
  * Derived from the kernel AVC implementation by
  * Stephen Smalley <sds@epoch.ncsc.mil> and
  * James Morris <jmorris@redhat.com>.
  */
_____________________________________________________________

The term "Derived" has legal implication, any derivative works of GPL 
code should be GPL   (the kernel avc is licensed under GPL v 2.1)

To me that file is much like a re-implementation of AVC for libselinux, 
it is obvious for interfacing userspace with kernel module you need to 
follow the structures of what you actually interface with (in this case 
it could be interpreted as original work)

Although due to Legal requirements I have to consider author claims as 
well, and the Author clearly indicated it is a derivative work,

If we consider the author claim then libselinux falls into GPL license 
category anything dynamically or statically linked to it should be 
released under GPL license then,  That would make se-postgresql license 
inappropriate  which is using postgresql license (actually is a BSD-like 
license and is less restrictive license than GPL).



Please shed some light on this issue,

Thanks


Best Regards,

Patrick K.






On 1/31/2011 3:13 AM, KaiGai Kohei wrote:
> A few days ago, a tiny initial version of SE-PostgreSQL got merged
> in the v9.1 development cycle at this commit: http://bit.ly/gF2QPQ
>
> Although it omits various features which I planned at first, it
> seems to me an ambitious first step.
> PostgreSQL has shifted to provide a set of facilities to implement
> label based mandatory access control, such as security label support
> on database objects or security hooks being available for plug-in
> modules.
>
> The current version of SE-PostgreSQL is implemented as a plugin
> module that utilizes these hooks (but only a limited places are
> covered), then it asks SELinux in kernel whether the required
> access shall be allowed, or not.
>
> In the next development, I'd like to expand its access control coverage
> using more fine grained security hooks. Right now, DDL permissions are
> restrictions. Also, row-level security is in-progress feature.
>
> I have much things to do for the v9.2 or v9.3, however, I'd like to
> appreciate people who have given me many feedbacks since 2006
>
> Thanks,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
