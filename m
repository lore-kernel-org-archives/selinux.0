Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82K8trT002840
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 16:08:55 -0400 (EDT)
Message-ID: <41377DD5.8010500@redhat.com>
Date: Thu, 02 Sep 2004 16:08:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed Hardware File Context file.
References: <200408241818.40064.russell@coker.com.au>	 <41371628.2020408@redhat.com>	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>	 <200409022338.20644.russell@coker.com.au>	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>	 <413741A3.3070305@redhat.com>	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>	 <41377927.3080703@redhat.com> <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-09-02 at 15:48, Daniel J Walsh wrote:
>  
>
>>The other thought would be to use a separate file that would map device 
>>type to policy
>>cat hardware_contexts
>>
>>cdrom system_u:object_r:removable_disk_device_t 
>>
>>disk system_u:object_r:fixed_disk_device_t
>>    
>>
>
>I think I like this better.  But let them also specify unit number or
>similar so that multiple devices of the same type can be mapped to
>different contexts, please.
>
>  
>
Ok so the original context as specified in the file context file with 
hardware type.   IE
PATH  MODETYPE CONTEXT HARDWARE
/dev/hd.* -b  system_u:object_r:removable_disk_device_t     cdrom
/dev/hd.* -b  system_u:object_r:fixed_disk_device_t              disk

>>But this would still fail the restorecon, rpm and setfiles.
>>
>>One idea would be to not include /dev in the setfiles stuff.  ( I guess it wouldn't now that it is a tmpfs file system)
>>    
>>
>
>True, relabel won't include tmpfs mounts.   Not sure about rpm and /dev
>nodes, e.g. is dev package obsoleted by udev, and are there other /dev
>nodes that are part of other packages?
>
>  
>
>>We still need a mapping in policy and a libselinux function to give us 
>>that mapping.
>>    
>>
>
>True.  But much simpler than matchpathcon.
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
