Subject: Re: is_selinux_enabled in fileutils
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <JBrindle@snu.edu>, Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <sf7751ab.035@atlas.snu.edu>
References: <sf7751ab.035@atlas.snu.edu>
Content-Type: text/plain
Message-Id: <1064838528.10464.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Sep 2003 08:28:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-09-28 at 22:24, Joshua Brindle wrote:
> second, why aren't the selinux patches to file/coreutils generalized
> for all extended attributes? If we (or someone) made patches that
> would copy/move/view all extended attributes or just specified ones
> it could be used by many more people than just selinux users and
> would be more friendly upstream. the core/fileutils patches don't
> really even need to rely on libselinux since xattr is now standard
> in the kernel and the library for accessing xattr's is completely 
> separate from selinux..

As a side note, there already is a general xattr patch for coreutils
from acl.bestbits.at, but it has the limitation that I mentioned with
respect to not being able to create files immediately with a specified
security attribute.  This is a limitation of the xattr API, not just the
implementation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
