Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VNFggA010409
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 19:15:42 -0400 (EDT)
Received: from gateway.thesellers.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VN9hC0018145
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 23:09:43 GMT
Received: from [192.168.1.18] (unknown [192.168.1.18])
	by gateway.thesellers.net (Postfix) with ESMTP id 62E902EC046
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 18:29:02 -0400 (EDT)
Mime-Version: 1.0 (Apple Message framework v730)
In-Reply-To: <20050531212112.GF11815@lkcl.net>
References: <200505311412.j4VECK5F030983@gotham.columbia.tresys.com> <1117551440.15167.25.camel@dhcp83-8.boston.redhat.com> <20050531212112.GF11815@lkcl.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <79483BF9-8FE1-46B8-BD6C-20C98BD6F7A8@thesellers.net>
From: Chad Sellers <chad@thesellers.net>
Subject: Re: file_type_auto_trans is not sufficient
Date: Tue, 31 May 2005 19:09:43 -0400
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On May 31, 2005, at 5:21 PM, Luke Kenneth Casson Leighton wrote:


> On Tue, May 31, 2005 at 10:57:20AM -0400, Ivan Gyurdiev wrote:
>
>
>>
>>
>>
>>> The other option, of course, is to change the applications to use/ 
>>> create many
>>> more directories, each with a separate type to allow the  
>>> file_type_auto_trans
>>> rules to work. Your orbit example might mean that there is a /tmp/ 
>>> orbit
>>> directory where all orbit files are created.
>>>
>>>
>>
>> The problem is not multiple source domains - that can be addressed
>> through macros. The problem is that those domains use the same  
>> directory
>> (Usually /tmp, or /home), for their own purposes, and they need  
>> the same
>> transition (same directory and target class (dir/file)).
>>
>> Because you can have only one transition, this creates a problem.
>>
>>
>
>  ...
>
>  thinking "sideways" again - as i am wont to do.
>
>  how about... a "sideways" solution to this - at the kernel level?
>
>  a "silent" redirection / remount, on a per-application basis?
>
>  no, i'm not joking.
>
>  an option to "mount" which allows a specific APPLICATION (or group of
>  applications) to have any files/directories it creates/accesses in a
>  subdirectory ACTUALLY occur ELSEWHERE.
>
>  e.g.:
>
>  mount -o redirectexe=/usr/bin/mozilla-firefox /tmp /tmp/mozilla
>  mount -o redirectexe=/usr/bin/gnomeshite,/usr/bin/gnomemoreshite / 
> tmp /tmp/gconf
>
>  hm, that could get out-of-hand - the number of programs involved
>  that would need redirection..
>
>  *thinks* ... some other mechanism for "grouping" executables...
>
>  you could even hang it off of an selinux context (!) or selinux  
> domain
>  (!) such that a set of executables, possibly those executed by
>  certain users, would result in filesystem redirection - but not  
> others.
>
>  at your own discretion.
>
>  then, you _could_ specify /tmp/gconf equals "a different file  
> context".
>
>

Something like this already exists in userspace, though it's not  
entirely transparent.  The polyinsantiation library I posted a couple  
of weeks ago allows applications to bind mount (in a private  
namespace) member directories according to policy (type member  
rules).  This is mostly thought of as useful for user separation, but  
it can separate any types.  So, add a short wrapper program to call  
security_setupns() (from my patch) around mozilla and appropriate  
policy, and mozilla can have a private /tmp.  (note:  the wrapper  
would need to link any important files out of the original /tmp, such  
as X11 sockfiles).

That said, this doesn't solve Ivan's problem.  You still have a  
single application (gconfd in his example) creating /tmp/gconfd and / 
tmp/orbit, with only one type transition rule allowed.  You can't  
mount /tmp/gconfd over /tmp for portions of execution, and then /tmp/ 
orbit over /tmp for other parts of execution.

Chad



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
