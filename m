Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2Em0Rb014622
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 09:48:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2ElKp5001653
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:47:20 GMT
Received: from localhost.localdomain (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
	by jazzswing.ncsc.mil  with ESMTP id hB2ElJt0001648
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:47:19 GMT
Subject: Re: What causes this??
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: Russell Coker <russell@coker.com.au>
Cc: nagray@bruzenak.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200312021549.34383.russell@coker.com.au>
References: <1070340338.12612.2.camel@hawaii>
	 <200312021549.34383.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070376464.13070.127.camel@hawaii>
Mime-Version: 1.0
Date: Tue, 02 Dec 2003 08:47:44 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 22:49, Russell Coker wrote:
> On Tue, 2 Dec 2003 15:45, Nick <nagray@bruzenak.com> wrote:
> > I just rebuilt a system and when I try to change roles I get this
> >
> >
> > [root@hawaii SELinux]# newrole -r sysadm_r
> > cannot find your entry in the passwd file.
> > [root@hawaii SELinux]#
> 
> Please give us the output of the command "id".  Chances are you are not 
> running in a correct context.

id -c 
system_u:system_r:sysadm_t


> Also please tell us whether you are using the old SE Linux or the new SE 
> Linux, 

This is using the kernel at 

http://www.nsa.gov/selinux/archives/linux-2.4-2003100110.tgz

and utilities

http://www.nsa.gov/selinux/archives/selinux-usr-2003100110.tgz

> and whether you are in enforcing or permissive mode.

permissive

>   If enforcing 
> then show us any AVC messages that occur in the kernel message log at the 
> time you run "newrole".

Dec  2 07:44:35 hawaii kernel: security_compute_sid:  invalid context
system_u:system_r:newrole_t for scontext=system_u:system_r:sysadm_t
tcontext=system_u:object_r:newrole_exec_t tclass=process

The strange part is that I have rebuilt this system about 10 times now
while working out the instructions and have never seen this behavior.

This is stock RH9.0  built as per the instructions at 

https://www.efficax.net/SELinux/build.php

-- 
Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
