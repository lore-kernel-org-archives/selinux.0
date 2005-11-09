Message-ID: <43727C4D.1070100@redhat.com>
Date: Wed, 09 Nov 2005 17:46:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
   selinux@tycho.nsa.gov, SELinux-dev@tresys.com
Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode> <Pine.LNX.4.63.0510271520390.24160@excalibur.intercode> <1130443338.18805.364.camel@moss-spartans.epoch.ncsc.mil> <200511091630.53757.csellers@tresys.com>
In-Reply-To: <200511091630.53757.csellers@tresys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On Thursday 27 October 2005 16:02, Stephen Smalley wrote:
>   
>> On Thu, 2005-10-27 at 15:23 -0400, James Morris wrote:
>>     
>>> On Thu, 27 Oct 2005, Stephen Smalley wrote:
>>>       
>>>> Thoughts?
>>>>         
>>> It may be helpful to have type aliases, but are they truly necessary?
>>>
>>> Seems like a lot of potential problems arise from them, including
>>> confusing SELinux developers.
>>>
>>> Perhaps type aliasing would be better implemented as a higher level
>>> policy construct?
>>>       
>> There seem to be three uses of the aliases:
>> 1) compatibility across policy changes, e.g. when a type is removed or
>> renamed, an alias can be defined so that any existing processes or
>> objects with the type aren't rendered unlabeled upon the policy reload,
>> 2) on-disk compatibility between policies, so that a filesystem
>> initially labeled for targeted policy is still fairly useable for
>> bootstrapping a strict policy system even though the latter has
>> finer-grained types,
>> 3) sharing among policies, both at a source level (macros, .te
>> files, .fc files) and for binary policy modules, so that policy modules
>> (source or binary) can refer to types that may then be coalesced or kept
>> separate as appropriate for a given base policy.
>>
>> #3 could be done entirely via a higher level construct, but we don't
>> have such a higher level construct yet and are relying on the ability to
>> share among policies in this manner.  #2 may not be critical.  #1 seems
>> to require that the kernel retain a notion of the aliases.
>>
>> If #2 is not critical, then changing matchpathcon_init in the proposed
>> manner may be sufficient (whether using sepol or selinuxfs as the
>> backend).  With that change, upgraded systems that have existing uses of
>> alias names in on-disk xattrs won't cause spurious complaints by
>> setfiles/restorecon, and a clean install should yield a system with no
>> alias names stored in the on-disk xattrs since rpm will get canonical
>> names.  We could instrument the setfilecon functions in libselinux to
>> also canonicalize the context prior to calling setxattr.  On second
>> thought, it seems overkill to do it on context translations, as this is
>> only an issue for file contexts and is already covered for getxattr, so
>> we are primarily concerned with matchpathcon and setfilecon.
>>     
>
> Did this ever get resolved?  I see that this patch has made it into the 
> rawhide kernel.  This means that when installing a new policy rpm, my screen 
> is flooded with fixfiles relabeling lib_t to shlib_t, due to shlib_t being a 
> typealias of lib_t in targeted.  Are we worried about this right now, or are 
> these messages ok?
>
>   
We are supposed to be patching restorecon/chcon/setfiles to make these 
go away or at most warn.  These tools should be asking the kernel for 
the correct context for a file  IE shlib_t -> lib_t in targeted policy 
and then says it is ok.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
