Message-ID: <4276643E.5000904@redhat.com>
Date: Mon, 02 May 2005 13:32:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: How should we handle automount.
References: <427640CB.80702@redhat.com> <1115053924.1712.40.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1115053924.1712.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-05-02 at 11:01 -0400, Daniel J Walsh wrote:
>  
>
>>Needs to be able to create/remove mounton arbitrary directories in 
>>arbitrary locations?
>>    
>>
>
>Allowing it to do so on arbitrary directories doesn't seem desirable,
>any more than allowing mount to mount on arbitrary directories.  Can we
>identify a reasonable set of mount point directories that might be used
>by automount?
>  
>
Automount Maintainer response:
Unfortunately, no.  The users of automount create a varied array of 
directory hierarchies.

>  
>
>>file_domain_auto_trans(automount_t, file_type, autofs_t, dir)  ????
>>    
>>
>
>s/domain/type
>
>  
>
Typo.

>autofs_t is for the autofs inodes themselves, so I don't think you want
>to apply them to the mount point directories.  Does automount always re-
>create the mount point directory, or does it re-use one if it already
>exists?
>
>  
>
I was just looking for a type with mounton type.  Maybe we could create 
an automont_mnt_t

file_type_auto_trans(automount_t, file_type, automount_mnt_t, dir)

>>Then how do we allow automount to delete the directory?
>>    
>>
>
>It would need permissions to the parent, so you need to be able to
>enumerate or identify by attribute what directory types might be used.
>
>  
>
Yup that is the problem.   If there was a way to say automount can only 
remove automount_mnt_t directories.

Dan


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
