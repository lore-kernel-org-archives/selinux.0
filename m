Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8G8tjog019923
 for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2014 04:55:46 -0400
Received: from epcpsbgx3.samsung.com
 (u163.gpu120.samsung.co.kr [203.254.230.163])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBZ00CAVKRULSD0@mailout4.samsung.com> for
 selinux@tycho.nsa.gov; Tue, 16 Sep 2014 17:55:06 +0900 (KST)
Date: Tue, 16 Sep 2014 08:55:04 +0000 (GMT)
From: Shivnandan Kumar <shivnandan.k@samsung.com>
Subject: [PATCH] Security: List corruption occured during file system
 automation test
To: Shivnandan Kumar <shivnandan.k@samsung.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "james.l.morris@oracle.com" <james.l.morris@oracle.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252
MIME-version: 1.0
Message-id: <31742801.543561410857702467.JavaMail.weblogic@epml25>
Cc: Ashish Kalra <ashish.kalra@samsung.com>,
 Rajat Suri <rajat.suri@samsung.com>,
 Mohammad Irfan Ansari <mohammad.a2@samsung.com>, "cpgs ." <cpgs@samsung.com>
Reply-To: shivnandan.k@samsung.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



Hi  Stephen Smalley,

Reproduction path :- 
We do random  file system operation ( e.g. - Saving, Open, Play, Delete ) of files and during this some time we  abruptly power off the device.

Thanks,
Shivnandan

------- Original Message -------
Sender : Stephen Smalley<sds@tycho.nsa.gov>
Date : Aug 26, 2014 23:46 (GMT+09:00)
Title : Re: [PATCH] Security: List corruption occured during file system automation test

Do you have a reproducer test case to trigger the bug?

On 08/21/2014 06:29 AM, Shivnandan Kumar wrote:
> Dear Eric Paris,
> 
> Sorry for the late reply.
> Yes I have back trace and I am attaching it.
> 
> First time the issue is reproduced then I have added some debug statement in the 
> file kernel/security/selinux/hooks.c to narrow down the problem  and then we 
> reproduce the issue again.
> I am attaching  complete back trace as well as my additional debug patch for 
> your reference.
> 
> Thanks,
> 
> Shivnandan
> 
> ------- *Original Message* -------
> 
> *Sender* : Eric Paris
> 
> *Date* : Aug 14, 2014 05:27 (GMT+09:00)
> 
> *Title* : Re: [PATCH] Security: List corruption occured during file system 
> automation test
> 
> Do you have a backtrace?
> 
> On Wed, Aug 13, 2014 at 8:30 AM, Al Viro wrote:
>  > On Wed, Aug 13, 2014 at 05:04:13PM +0530, shivnandan.k@samsung.com wrote:
>  >> From: Shivnandan Kumar
>  >>
>  >> List element was freed by  inode_free_security and then it uses rcu
>  >> element to point inode_free_rcu, since it inside a union so it
>  >> shares memory, sb_finish_set_opts now also try to free list element,
>  >
>  > How in hell does it find that element?
> 
> Thanks and Regards,
> 
> Shivnandan Kumar
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 





Thanks and Regards,
Shivnandan Kumar
