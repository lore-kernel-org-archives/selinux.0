Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JeOrT002472
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:40:25 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JeNv0029261
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:40:23 GMT
Subject: Re: Proposed Hardware File Context file.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <413741A3.3070305@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <41371628.2020408@redhat.com>
	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
	 <200409022338.20644.russell@coker.com.au>
	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
	 <413741A3.3070305@redhat.com>
Content-Type: text/plain
Message-Id: <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 15:38:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 11:52, Daniel J Walsh wrote:
> Collin and I were discussing a way to label hardware devices correctly.
> 
> One proposal would be to come up with a new file_contexts file based off 
> of path and hardware type.
> 
> So we could have a file with
> 
> /dev/h
> 
> /u?dev/[shmx]d[^/]*    -b    system_u:object_r:fixed_disk_device_t
> /u?dev/[shmx]d[^/]*    -b    system_u:object_r:removable_disk_device_t cdrom
> 
> Then either add a param to matchpathcon or a new function that would 
> pass in the hardware type
> and get the correct context.
> 
> Then tools like udev could use this to create the device with the 
> correct context.
> 
> ideas??

This is separate from the main file_contexts configuration used by
setfiles, restorecon, and rpm?  If so, what prevents the device from
being relabeled back to the wrong type by them?  If not, how do they
determine the hardware type to pass in?  

It also isn't clear that you care about the pathname regex or file type
if you know that you are dealing with a particular hardware type (and
unit); you can just map those directly to a context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
