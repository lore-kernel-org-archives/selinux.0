Message-ID: <462DF6A6.4010101@redhat.com>
Date: Tue, 24 Apr 2007 08:23:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ken YANG <spng.yang@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: can not boot with strict policy
References: <462CA1F0.2000400@gmail.com>	 <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>	 <Line.LNX.4.64.0704231341100.3793@d.namei> <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil> <462CF79C.5080804@redhat.com> <462DBBC8.9060300@gmail.com>
In-Reply-To: <462DBBC8.9060300@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ken YANG wrote:
> Daniel J Walsh wrote:
>> Stephen Smalley wrote:
>>> On Mon, 2007-04-23 at 13:42 -0400, James Morris wrote:
>>>  
>>>> On Mon, 23 Apr 2007, Stephen Smalley wrote:
>>>>
>>>>   
>>>>> /lib/libsepol.so.1 should be labeled with shlib_t, not lib_t.  Under
>>>>> targeted policy, they are aliases for one another.  Under strict, 
>>>>> they
>>>>> are separate types.
>>>>>
>>>>> Boot with "enforcing=0 single" to come up permissive into single-user
>>>>> mode, then run /sbin/fixfiles relabel -F to forcible relabel 
>>>>> everything,
>>>>> then reboot.
>>>>>       
>>>> I wonder if we could automate this, so that the autorelabel is also 
>>>> run on boot if you switch between different types of policy.
>>>>     
>>>
>>> rc.sysinit does have autorelabel support, but that won't help in this
>>> case, because here everything (including /sbin/init) will fail to run
>>> due to the inability to execute shared libs.  It would have to happen
>>> from early userspace or /sbin/init before loading policy and switching
>>> to enforcing mode.
>
> in such situation, we will have "kernel panic" each time when changing
> from "targeted" to "strict", aren't we?
>
> there muse be some methods to solve this problems.
>
When converting from targeted to strict, your first boot has to be done 
in permissive mode, to let the relabel occur.  After the relabel, you 
can go to enforcing mode.  Some people have put out examples of how to 
do this in a kick start.  This  is the way the MLS kickstart works.
>>>
>>>   
>> So the real question, is there much value with the division between 
>> lib_t and shlib_t.
>> When dealing with strict policy, shared libraries were always getting 
>> mislabeled as lib_t, and causing problems, for little security 
>> advantage.
>> As we remove the differences between strict and targeted, I don't 
>> intend to get rid of lib_t == shlib_t.
>
>
> i find most files labeled with "lib_t" are ".a" or symbolic link to
> ".so"
>
> what difference between lib_t and shlib_t? what is the purpose of
> "lib_t" type?
>
>>
lib_t is the default label for all files in /lib (/usr/lib, var/lib, 
...) directories that are not shared libraries


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
