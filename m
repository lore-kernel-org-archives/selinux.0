Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FIK7Wt027472
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:20:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FIK6mR017095
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:20:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FIK6jp017092 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:20:06 GMT
Subject: Re: enforce mode problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3F8D2B57.2080807@ipen.br>
References: <3F8D2B57.2080807@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1066242001.7399.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 14:20:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 07:11, Carlos Anísio Monteiro wrote:
> Hi.
> 
> When I switch to enforce mode (echo 1 > /selinux/enforce), a lot of 
> messages "avc" running in the console and the computer "freeze".
> I am not succeeding in to resolve this avc messages. I note that this 
> avc messages, mostly,  are associate to the system_u:system_r:kernel_t 
> context trying access another context.
> 
> Please, anyone could me help.

You need to address the avc messages before switching into enforcing
mode.  From the sound of it, you still haven't labeled your
filesystems.  Did you run 'make relabel' to completion?  What does ls -Z
/sbin/init show?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
