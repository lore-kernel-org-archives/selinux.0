Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i39FQxRb025530
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 11:27:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i39FOxUZ005610
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 15:24:59 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i39FOxmT005605
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 15:24:59 GMT
Message-ID: <4076C05A.6010104@redhat.com>
Date: Fri, 09 Apr 2004 11:25:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: John Reuning <john@metalab.unc.edu>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fedora Core 2 Test 2
References: <1081459652.24857.33.camel@hawaii.efficax.net>	 <32926.192.168.1.3.1081469476.squirrel@www> <1081481682.11877.26.camel@camelot>
In-Reply-To: <1081481682.11877.26.camel@camelot>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

John Reuning wrote:

>I'll offer my limited experience with fc2t2.  I've done two installs,
>both onto clean systems with reformatted partitions.  There was an
>option to disable selinux in the installer click-through choices.
>
>The first install resulted in an almost unusable system.  I think
>something hiccuped because the fs labeling was messed up.  For example,
>I couldn't create user accounts as root because the root user didn't
>have access to write /etc/shadow or /etc/passwd.  A manual relabeling of
>the file systems fixed the problem.  After that, everything was fine.
>
>The second install was smooth.  No labeling or policy problems yet. 
>Although, I haven't used the system except as a headless test server.
>
>I haven't tried upgrading a fc1 system to fc2t2.  Maybe that's a source
>of trouble?
>
>Thanks,
>
>-John R.
>
>  
>
First off there is a Mailing list for discussing Fedora SELinux issues.

http://www.redhat.com/mailman/listinfo/fedora-selinux-list
As well as fedora-test-list and fedora-devel-list (Discussions are going 
on all three lists).

1.  Upgrading to Fedora Core 2/SELinux requires a relabel of the file 
system, so people
who have done this have gotten into trouble.
2.  We have had tons of fixes to policy over the past few weeks that 
have cleaned up a lot of
problems.  So if you install FC2, make sure you update to the latest 
policy off of rawhide.
3.  Overall the number of bugs being reported has dropped dramatically, 
either we have fixed
a lot of the problems or people have figured out how to turn off SELinux 
(Probably a combination
of both.)
4.  Red Hat will be announcing our strategy for SELinux support in 
FC2/Test3  and Final shortly.

>>>1: I was a little surprised to find that SELinux was installed by
>>>default and that there didn't seem to be a way to avoid it. This said,
>>>the kernel did come up properly and the system booted.
>>>[snip]
>>>      
>>>
>
>  
>
The installer has three options currently Enforcing (Default), 
Permissive, Disabled.
There is also a FAQ explaining how to use SELinux within FC2.
http://people.redhat.com/kwade/fedora-docs/selinux-faq-en/

Comments welcome.

>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
