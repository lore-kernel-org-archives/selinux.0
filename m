Message-ID: <4501C8EA.7020105@us.ibm.com>
Date: Fri, 08 Sep 2006 14:47:54 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, lspp-list <redhat-lspp@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Re: MLS Policy (rawhide)
References: <4500906A.3000502@us.ibm.com> <4501B1B1.4020103@redhat.com>	 <4501C466.7060309@us.ibm.com> <1157744430.31695.210.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157744430.31695.210.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-09-08 at 14:28 -0500, Michael C Thompson wrote:
>> Daniel J Walsh wrote:
>>> Michael C Thompson wrote:
>>>> Hey all,
>>>>
>>>> It seems that ssh is unable to add entries to known_hosts for the root 
>>>> user as sysadm_t. Is this a known issue? And if so, who can add 
>>>> entries to /root/.ssh/known_hosts ?
>>>>
>>>> Thanks,
>>>> Mike
>>>>
>>> This works for me.  How is the file labeled?
>> # ls -alZ /root/.ssh
>> drwx------  root root root:object_r:user_home_ssh_t:SystemLow .
>> drwxr-x---  root root 
>> root:object_r:sysadm_home_dir_t:SystemLow-SystemHigh ..
>> -rw-------  root root root:object_r:bin_t:SystemLow    id_rsa
>> -rw-r--r--  root root root:object_r:bin_t:SystemLow    id_rsa.pub
>> -rw-r--r--  root root root:object_r:user_home_ssh_t:SystemLow known_hosts
> 
> /sbin/restorecon -R /root/.ssh

I have relabeled this system numerous times with touch /.autorelabel... 
why wasn't this picked up?

Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
