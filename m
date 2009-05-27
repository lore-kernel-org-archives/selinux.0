Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4RBTncB003865
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 07:29:49 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4RBSvJS011928
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 11:29:23 GMT
Message-ID: <4A1D23C8.6010300@redhat.com>
Date: Wed, 27 May 2009 07:28:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ioannis Aslanidis <iaslanidis@flumotion.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Problem with SELinux and glusterfs when trying to allow memprotect/mmap_zero
References: <4A1D10AE.7020009@flumotion.com>
In-Reply-To: <4A1D10AE.7020009@flumotion.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/27/2009 06:06 AM, Ioannis Aslanidis wrote:
> Hello,
>
> I am trying to allow the following audit message through, but it says
> that there is a violation. Can anyone explain what exactly is going on?
>
> Thank you,
>
> Ioannis
>
> # cat messages.audit
> May 27 01:51:13 streamer012 kernel: audit(1243381873.876:60): avc:
> denied  { mmap_zero } for  pid=3155 comm="glusterfs2"
> scontext=system_u:system_r:mount_t:s0
> tcontext=system_u:system_r:mount_t:s0 tclass=memprotect
>
>
> # cat selinuxglusterfs.te
>
> module selinuxglusterfs 1.0;
>
> require {
> 	type mount_t;
> 	class memprotect mmap_zero;
> }
>
> #============= mount_t ==============
> allow mount_t self:memprotect mmap_zero;
>
Add
domain_mmap_low_type(mount_t)
Will make this problem go away.  But I don't beleieve glusetfs should be 
causing the mount command to need to mmap_zero.  Seems like a kernerl 
problem.
>
> #  semodule -i selinuxglusterfs.pp
> libsepol.check_assertion_helper: assertion on line 0 violated by allow
> mount_t mount_t:memprotect { mmap_zero };
> libsepol.check_assertions: 1 assertion violations occured
> libsemanage.semanage_expand_sandbox: Expand module failed
> semodule:  Failed!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
