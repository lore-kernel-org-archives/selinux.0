Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PJB6CE024496
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:11:06 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PJAPaU026008
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 19:10:30 GMT
Message-ID: <451829B6.7050606@redhat.com>
Date: Mon, 25 Sep 2006 15:10:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <45116881.3060406@redhat.com>	 <1158945196.3920.131.camel@sgc.columbia.tresys.com>	 <451447EA.70905@redhat.com> <1159210299.3920.218.camel@sgc>
In-Reply-To: <1159210299.3920.218.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2006-09-22 at 16:30 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
>>>   
>>>       
>>>> http://people.redhat.com/dwalsh/SELinux/policy.diff
>>>>
>>>> Changed to allow 1024 categories.
>>>>         
>>> Not adding this yet.  Waiting for concensus on how high we should go.
>>>   
>>>       
>> Ok, any way we could make this a constant defined in the Makefile?
>>
>> TOTAL_CATS=1024, MAX_CAT=c1023
>>     
>
> This was suggested to me by others; it seems like a reasonable
> compromise.  I'll probably make build options for the number of MLS and
> MCS categories, and the number of MLS sensitivities.
>
>   
>>>> Add a files_manage_non_secure_dirs for autofs
>>>>         
>>> This seems suspect.
>>>   
>>>       
>> Autofs creates a file/directory in every directory it mounts over.
>>     
>
> But why does it do this?
>
>   
Taken off list to get an answer from autofs package maintainer, will 
post answer.
> Also, the other change sounds suspect since it can't do any rawip send
> or receive:
>
>   
>> automount uses rawip_socket  
>>     
>
>   
>>>> Stop using bluetooth_helper_t
>>>>         
>>> Why?
>>>
>>>       
>> Two many bugs and it is confining userspace with X-Windows.
>>     
>
> I assume you're referring to targeted, in which case, the transition
> should be removed from unconfined_t, not the label from the file.
>
>   
Yes although I think it will not work well in strict, but we can remove 
the transition.
>>>> oddjob policy should be added
>>>>         
>
> /usr/lib/oddjobd    gen_context(system_u:object_r:oddjob_var_lib_t,s0)
>
> Is this right?  Not /var/lib/oddjobd since its oddjob_var_lib_t?
>   
Yes this should be eliminated.  Not needed. 
>   
>>> * What is the /opt/fortitude stuff in apache?
>>>   
>>>       
>> It is a new Red Hat product for government use, I believe. 
>>     
>
> I'm not sure this should upstreamed in that case.
>
>   
Fine.
>> readahead needs mls_read_up priv, donaudit looking at nvram
>>     
>
> The second part seems weird since there already is:
>
> dev_getattr_all_chr_files(readahead_t)
>
>   
Your right this would be fixes by mls_read_up.
>> fsdaemon_exec_t needs to run at SystemHigh to be able to look at fixed disks
>>     
>
> Holding off on this one until the range_transitions work in modules,
> which should hopefully be very soon.  Also, why not just do mls_read_up
> instead?
>
>   
I will try that.
>> /dev/rawctl is labeled as a fixed_disk_device_t even though it is a 
>> chr_file.  Not sure if this is correct.
>>     
>
> According to drivers/char/raw.c:
>
>  * Front-end raw character devices.  These can be bound to any block
>  * devices to provide genuine Unix raw character device semantics.
>  *
>  * We reserve minor number 0 for a control interface.  ioctl()s on this
>  * device are used to bind the other minor numbers to block devices.
>
> So it sounds like we need two types, one for the control device and one
> for raw1, etc.
>
>   
>> nscd needs to be accessable from sysadm_r.
>>     
>
> I think there may be another way to fix this.  I looked back at the
> direct_sysadm_daemon stuff, and I realized that there are two parts to
> this.  The first is the role transition to allow sysadm_t to restart
> services without using run_init.  The second allows sysadm_t to start up
> daemons by directly executing them.  Right now they're both controlled
> by the DIRECT_INITRC build option.
>
> So the question is, do we still want the second part?  If so, it should
> be separated into its own build option or tunable.
>
> I understand that usermod restarts nscd; its too bad it can't just
> signal nscd to clear its cache rather than doing something broken like
> this.
>
>   
This is a similar problem to rpm.  Where sysadm_r is required access to 
all domains that could be run in a rpm scriptlet.  Currently I require 
mls people to run rpm with run_init to get it to work correctly.
>> need a userdom_use_unpriv_users_ttys so sysadm_t can write to all users 
>> terminals when system is going down.
>>     
>
> Moved this change down.
>
>   
>> auditadm and secadm need to be able to messages to syslog
>>     
>
> * moved firstboot_rw_t alias to files.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
