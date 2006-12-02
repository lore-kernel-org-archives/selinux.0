Message-ID: <4570F505.5050305@tresys.com>
Date: Fri, 01 Dec 2006 22:37:41 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch for restorecond to not report an error if filesystem	does
 not support XATTR
References: <6FE441CD9F0C0C479F2D88F959B015885C80CA@exchange.columbia.tresys.com> <1164913329.23019.978.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164913329.23019.978.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> 
> Interesting question...the policy Makefile and the fixfiles script have
> always just used a hardcoded list of filesystem types known to support
> file security labeling.  And the policy configuration explicitly
> specifies the filesystem types for which SELinux tries to use xattrs, as
> the mere presence of an xattr handler has never been a sufficient test.
> Possibly we should be extracting that list from policy and making it
> available for programs that need to know it.
> 
> Even testing the result of setxattr for EOPNOTSUPP is not 100%, as
> setxattr will also fall back to setting the incore value if a) you pass
> permission checks and b) the filesystem provides no setxattr method at
> all (NFS happens to provide one, but it only supports ACLs).  So it
> could succeed (e.g. devpts nodes) or fail with -EACCES (e.g. proc).
> 

Can we make an selinuxfs node that just outputs the list of fs_use_xattr 
filesystems?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
