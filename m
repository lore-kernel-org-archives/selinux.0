Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JpJrT002641
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:51:19 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JoT3w008998
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:50:29 GMT
Message-ID: <413779AB.3020102@redhat.com>
Date: Thu, 02 Sep 2004 15:51:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Proposed Hardware File Context file.
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil> <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com> <20040902195422.GJ5745@lkcl.net>
In-Reply-To: <20040902195422.GJ5745@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>On Thu, Sep 02, 2004 at 11:52:03AM -0400, Daniel J Walsh wrote:
>  
>
>>Collin and I were discussing a way to label hardware devices correctly.
>>
>>One proposal would be to come up with a new file_contexts file based off 
>>of path and hardware type.
>>
>>So we could have a file with
>>
>>/dev/h
>>
>>/u?dev/[shmx]d[^/]*    -b    system_u:object_r:fixed_disk_device_t
>>    
>>
>
>you mean:
>
>  /u?dev/[shmx]d[^/]*    -b    system_u:object_r:fixed_disk_device_t disk
>
>or do you mean _not_ having the extra word on the end to indicate
>the default, should the type not be matched [by a udev script]?
>
>  
>
>>/u?dev/[shmx]d[^/]*    -b    system_u:object_r:removable_disk_device_t cdrom
>>    
>>
>
>  
>
Yes I was thinking no hardware type would be default.

>>Then either add a param to matchpathcon or a new function that would 
>>pass in the hardware type
>>and get the correct context.
>>
>>Then tools like udev could use this to create the device with the 
>>correct context.
>>
>>ideas??
>>    
>>
>
> interesting.
>
> in some respects, it's almost like you don't need the /u?dev/[...]...
> bit: if it's a cdrom, you know it's removable_disk_device_t, end
> of story.
>
>  
>
Yes covered in another email.

> hm.
>
> except.... what about restricting access to removable_disk_device_t,
> or is that covered by user_rw_noexattrfile?
>
> l.
>
> 
>  
>
Yes this is just getting the file type correct.  Policy would be handled 
in the traditional way.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
