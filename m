Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JmvrT002593
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:48:57 -0400 (EDT)
Message-ID: <41377927.3080703@redhat.com>
Date: Thu, 02 Sep 2004 15:48:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed Hardware File Context file.
References: <200408241818.40064.russell@coker.com.au>	 <41371628.2020408@redhat.com>	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>	 <200409022338.20644.russell@coker.com.au>	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>	 <413741A3.3070305@redhat.com> <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-09-02 at 11:52, Daniel J Walsh wrote:
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
>>/u?dev/[shmx]d[^/]*    -b    system_u:object_r:removable_disk_device_t cdrom
>>
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
>This is separate from the main file_contexts configuration used by
>setfiles, restorecon, and rpm?  If so, what prevents the device from
>being relabeled back to the wrong type by them?  If not, how do they
>determine the hardware type to pass in?  
>  
>
Yes we talked about that but did not have a good answer.  I am not sure 
that it would need to be a separate file from the file_contexts file,
if it was the same then the tools would need to be modified to handle 
it.  IE use the one without the fourth parameter.
The other thought would be to use a separate file that would map device 
type to policy
cat hardware_contexts

cdrom system_u:object_r:removable_disk_device_t 

disk system_u:object_r:fixed_disk_device_t

...

But this would still fail the restorecon, rpm and setfiles.

One idea would be to not include /dev in the setfiles stuff.  ( I guess it wouldn't now that it is a tmpfs file system)

>It also isn't clear that you care about the pathname regex or file type
>if you know that you are dealing with a particular hardware type (and
>unit); you can just map those directly to a context.
>
>  
>
We still need a mapping in policy and a libselinux function to give us 
that mapping.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
