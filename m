Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JhLrT002546
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:43:21 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JhJv0029367
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:43:20 GMT
Date: Thu, 2 Sep 2004 20:54:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Proposed Hardware File Context file.
Message-ID: <20040902195422.GJ5745@lkcl.net>
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil> <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <413741A3.3070305@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 11:52:03AM -0400, Daniel J Walsh wrote:
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

you mean:

  /u?dev/[shmx]d[^/]*    -b    system_u:object_r:fixed_disk_device_t disk

or do you mean _not_ having the extra word on the end to indicate
the default, should the type not be matched [by a udev script]?

> /u?dev/[shmx]d[^/]*    -b    system_u:object_r:removable_disk_device_t cdrom

> Then either add a param to matchpathcon or a new function that would 
> pass in the hardware type
> and get the correct context.
> 
> Then tools like udev could use this to create the device with the 
> correct context.
> 
> ideas??

 interesting.

 in some respects, it's almost like you don't need the /u?dev/[...]...
 bit: if it's a cdrom, you know it's removable_disk_device_t, end
 of story.

 hm.

 except.... what about restricting access to removable_disk_device_t,
 or is that covered by user_rw_noexattrfile?

 l.

 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
