Message-ID: <4469DB84.1080507@gentoo.org>
Date: Tue, 16 May 2006 10:02:44 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        Daniel J Walsh <dwalsh@redhat.com>,
        selinux-dev <selinux-dev@tresys.com>,
        James Morris <jmorris@redhat.com>
Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred	mappingof
 inode security contexts
References: <6FE441CD9F0C0C479F2D88F959B01588170599@exchange.columbia.tresys.com> <1147786883.30789.104.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1147786883.30789.104.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-05-16 at 08:50 -0400, Joshua Brindle wrote:
>   
> <snip>
> IIUC, restore -C works by calling lgetxattr() on the files and comparing
> the attribute returned by it against what is in the dump.  So if
> lgetxattr() returns unlabeled_t rather than the unmapped string, the
> compare will fail.  Likewise for verification of a successful restore
> from a dump.  IIUC, the raw read of the device only occurs when dumping
> the partition; restore itself operates via the normal system calls on
> the fs.
>
>   
I'm not sure if this is the appropriate behavior. For example, restore 
doesn't/can't verify that the UID/GID for the file being restored is 
mapped the same as it was when the archive was created. IMHO restore's 
job isn't to interpret the backup, its job is to write it out and let 
the admin interpret it.

> Canonicalization would still occur for contexts that are valid; the only
> change here is in what we return to userspace (and in logs) for invalid
> contexts.
>
>   
>> <snip>
>
> At present, both the avc and audit will end up displaying the unlabeled
> SID's context for all invalid contexts because that is what
> security_sid_to_context() will return.  What I'm suggesting would change
> that behavior so that they both will display the unmapped string
> representation, thereby preserving the actual text label.
>   

So the denial would have the unmapped context? I don't think I 
understand that, it wouldn't be a denial that represents what actually 
happened (not to mention the type wouldn't necessarilly be in the policy 
so any attempt to audit2allow or similar will yield an 
uncompilable/unlinkable policy)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
