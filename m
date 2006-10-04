Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94BjNbb010869
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 07:45:23 -0400
Received: from aplesnation.dom1.jhuapl.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94BiCo0019473
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 11:44:13 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: init unconfined in RHEL4?
Date: Wed, 4 Oct 2006 07:45:24 -0400
Message-ID: <7B95239DDD54E54B9BFA23847142B1EE12CB6D@aplesnation.dom1.jhuapl.edu>
From: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Russell Coker" <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan and Russell,
      Yeah, it was my fault, I had labeled with the refpolicy but it
turned out I was using the RHEL4 targeted policy on boot (I hadn't set
/etc/selinux/config).  It's up and running and things are in the proper
domains.  I know refpolicy's unsupported on RHEL4, the idea is to move
this system to RHEL5 when it's available.  For now on RHEL4 I have to
login and get X started before I turn the policy on, which is yucky, but
it'll do until RHEL5.

Thanks,
Justin 

-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
Sent: Tuesday, October 03, 2006 5:02 PM
To: Osborn, Justin D.
Cc: selinux@tycho.nsa.gov
Subject: Re: init unconfined in RHEL4?

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
