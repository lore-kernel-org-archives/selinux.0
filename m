Message-ID: <430C8EB8.80906@redhat.com>
Date: Wed, 24 Aug 2005 11:14:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with MCS/Targeted policy update.
References: <430C776B.4060309@redhat.com> <1124893226.11553.32.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124893226.11553.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-08-24 at 09:34 -0400, Daniel J Walsh wrote:
>  
>
>>I would like to be able to upgrade rawhide with a new targeted policy 
>>containing MCS.   I see a couple of problems when I do this.
>>
>>The number one problem, it that it still requires an relable.  Even 
>>though the latest kernel defaults everything to level of "sid file"
>>getfilecon or the kernel is is still reading the file context off disks 
>>without the "s0" so the kernel is reporting hundreds of invalid 
>>contexts, need to figure a way to fix this or we will need a relabel.  
>>(Relabeling when upgrading from FC4-FC5 will not be pretty).
>>    
>>
>
>What is the exact error message?  Given the change made by James, the
>kernel shouldn't be getting any error from
>security_context_to_sid_default and thus shouldn't be logging a warning
>about the contexts.  What kernel are you running?
>
>  
>
Must have been a older kernel.   Just tried it again with 
2.6.12-1.1505_FC5 and it seems to work. 
chcon is broken though, ls and other commands are not getting the :s0 
since it is not there, so there might be other problems,

>>Certain applications like chcon, might need to change to use _raw 
>>functions, _raw function/options would be nice to add to certain 
>>coreutils, at least for debugging purposes.
>>    
>>
>
>You certainly don't want them to use the raw functions by default, but
>having it as an option might be useful.
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
