Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93L1v9K026172
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:01:57 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93L1NGw012857
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:01:23 GMT
Message-ID: <4522CFC7.7040801@redhat.com>
Date: Tue, 03 Oct 2006 17:01:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: init unconfined in RHEL4?
References: <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu> <7B95239DDD54E54B9BFA23847142B1EE10A29E@aplesnation.dom1.jhuapl.edu>
In-Reply-To: <7B95239DDD54E54B9BFA23847142B1EE10A29E@aplesnation.dom1.jhuapl.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Osborn, Justin D. wrote:
>
> I'm working on a RHEL4 system with the Reference Policy and init is 
> running in unconfined_t.  This leads to most other processes on the 
> system running in unconfined_t.  Has anyone seen similar errors?
>
In RHEL4 only 15 Targets are confined,  Everything else runs in an 
unconfined domain.
>
> This is the Ref. Policy version released in March, I got the latest 
> svn version but it doesn't work with the libsepol and checkpolicy 
> RHEL4 RPMs on the Tresys site.
>
> I'm also having a strange error where I get denied messages saying 
> something was trying to access a file with context unlabeled_t when 
> `ls -Z` shows the file is clearly labeled something else.
>
ls -Z is reading the label on the file.  While the other domains are 
getting it from the kernel.  Probably the type of the file is no longer 
defined in policy, so the kernel says it is unlabled_t.  You should 
execute  restorecon on it to clean it up.

>
> Has anyone seen similar things on RHEL4?
>
> Thanks,
> Justin
>
> P.S. I managed to get my template working, many thanks to Dave Caplan.
>
> -----Original Message-----
> From: Osborn, Justin D.
> Sent: Mon 9/25/2006 10:09 AM
> To: selinux@tycho.nsa.gov
> Subject: Errors with runcon - RHEL4/refpolicy
>
> Hi everybody,
>       I'm working on a project to do containment of VMware VMs using 
> SELinux policy.  Our system is set up on RHEL4 and I have the 
> Reference Policy installed. 
>
>       We're trying to reuse the VMware policy that was originally 
> distributed with the Reference Policy.  Specifically there is a 
> per-user-domain template that we modified for our use and instantiate 
> from another te file.  The policy compiles and our VMs are properly 
> labeled after relabeling.
>
>      The problem is that when I try to kick off a VM using runcon, I 
> get the non-descript "unable to setup security context" error.  The 
> command I'm running is: runcon root:system_r:ziplock_vm1_vmware_t 
> vmware-cmd start /VMs/foo.vmx.  My bash shell is running as 
> root:system_r:unconfined_t.  I added my types to system_r and verified 
> with apol.
>
>      So my questions are:
>      a) Why was the VMware policy renoved from the Reference Policy?
>      b) What am I missing with the runcon error?  Is there somewhere I 
> can look for a more descriptive error message?
>
> Thanks,
> Justin
> JHU/APL
>
>
>
>
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
