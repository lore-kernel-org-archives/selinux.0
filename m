Message-ID: <41F917F6.8060602@redhat.com>
Date: Thu, 27 Jan 2005 11:33:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Updated policy
References: <41F6A47E.9010407@redhat.com> <1106842924.28623.151.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106842924.28623.151.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-01-25 at 14:56, Daniel J Walsh wrote:
>  
>
>>Many changes to allow policy to support telnetd, rlogind and rshd.
>>    
>>
>
>I merged these bits into sourceforge CVS.
>
>  
>
>>allow mount_t binfmt_misc_fs_t:dir mounton;
>>Required to run wine.
>>    
>>
I got this one from Ivan Gyurdiev, I have never run wine.

>
>Waiting on clarification of whether and why this is needed, given that
>the mount point should be sysctl_t and only the mounted directory should
>have this type.  Multiple mounts?
>
>  
>
>>Changes to allow setfiles/restorecon to read default_context_t 
>>(customizable files)
>>    
>>
>
>I merged these bits into sourceforge CVS.
>
>  
>
>>Fixes for postgresql.te
>>    
>>
>
>Ditto.
>
>  
>
>>Elimination of gpg execmod change.  The gpg rpm was fixed in rawhide.
>>    
>>
>
>Ditto.
>
>  
>
>>Fixes for targeted crond to run as unconfined and still have transitions 
>>work.
>>    
>>
>
>Waiting on clarification of whether we truly want separate domains at
>all for such programs in the targeted policy, and whether it should be
>in system_crond_t or crond_t.
>
>Also merged most of the miscellaneous bits of the patch, excepting
>execmem permission for mozilla and the usual tunables and distros
>customizations.
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
