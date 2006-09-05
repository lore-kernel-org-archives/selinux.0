Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85Kvd6k018747
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 16:57:39 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k85KvHxN005860
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 20:57:17 GMT
Message-ID: <44FDE4C1.1000709@redhat.com>
Date: Tue, 05 Sep 2006 16:57:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest updates
References: <44F7358E.4010101@redhat.com>	 <1157125888.3199.157.camel@sgc.columbia.tresys.com>	 <44F88DD4.6020804@redhat.com> <1157382946.3199.211.camel@sgc>
In-Reply-To: <1157382946.3199.211.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2006-09-01 at 15:45 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Thu, 2006-08-31 at 15:16 -0400, Daniel J Walsh wrote:
>>>       
>>>> Fixing some labels to march what actually ends up on disk  see /boot/grub
>>>>         
>>> These say /boot/grup; I assume this is a typo.  Also they should be in
>>> the files module.
>>>       
>
> on further review, why does /boot/grub/* need to be boot_runtime_t?
> GRUB shouldn't be writing these files.
>
>   
I think the problem is that grubby is also labeled bootloader_exec_t, 
this should become a different
context say bootloader_helper_exec_t and then we can tighten bootloader_t.
>>>> Please change /opt java line to match what IBM ships
>>>>     
>>>>         
>>> I'm concerned this is too broad.  Can we get additional, more specific
>>> regexes?
>>>
>>>   
>>>       
>> I went looking for this, and I believe it was placed in a IBM directory, 
>> but can not find it right now.
>> Also not sure where BEA places there java.
>>     
>
> I'm still going to have to drop this.  The more complex regexs we have,
> the more likely there will be fc sorting problems.
>
>   
>>>> Lots of domains need term_dontaudit_use_unallocated_ttys for startup 
>>>> from a tty.
>>>>     
>>>>         
>>> Can you clarify this?  I don't know what you mean by "startup from a
>>> tty".
>>>
>>>   
>>>       
>> Log in to console terminals
>>
>> ctrl-alt-f1
>>
>> restart daemons, generated lots of avc messages when daemons try to talk 
>> to tty_device_t. 
>>
>> you will see this same pattern on almost all daemons.
>>     
>
> Ok, so this is a direct_run_init+targeted issue.  Now it makes sense to
> put it back into init_daemon_domain().  I'll take care of that.
>
>   
These lines are all over policy.

 ifdef(`targeted_policy',`
        term_dontaudit_use_generic_ptys(amavis_t)
       term_dontaudit_use_unallocated_ttys(amavis_t)
 ')

>>>> NetworkManager wants to ptrace itself
>>>>         
>>> I can't reproduce this on my notebook.  Can you look more into this?  It
>>> seems highly irregular.
>>>   
>>>       
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=204161
>>     
>
> I installed gdb to reproduce this, and I got the ptrace denial but
> didn't get a sys_ptrace denial.
>
>   
I did once, but I will remove it until I get it again.
>>> udev transition to dhcpc
>>>   
>>>       
>> It does when networks are plugged in, I believe.
>>     
>
> Thats odd, because that sounds like networkmanager's job.
>
>   
I was thinking this came from netplugd but that seems to be labeled 
hotplug_exec_t. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
