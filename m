Subject: Re: is_selinux_enabled in fileutils
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <sf7751ab.035@atlas.snu.edu>
References: <sf7751ab.035@atlas.snu.edu>
Content-Type: text/plain
Message-Id: <1064838175.10464.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Sep 2003 08:22:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-09-28 at 22:24, Joshua Brindle wrote:
> I'm just wondering a few things about the new API patches
> for fileutils (and no doubt others)
> 
> right now the ls, cp, mv patches etc do an is_selinux_enabled
> check which isn't technically required (since xattr is not specific
> to selinux). IMHO these artificial contraints shouldn't be added
> so that recovery cd's and things of this nature which have xattr
> enabled but not selinux will be able to see/copy/move files with
> their context. We aren't gaining any security by adding these
> contraints since libxattr, setfattr, getfattr, etc doesn't care
> if selinux is enabled or not (and are easier for mangling attributes
> anyway).
> 
> second, why aren't the selinux patches to file/coreutils generalized
> for all extended attributes? If we (or someone) made patches that
> would copy/move/view all extended attributes or just specified ones
> it could be used by many more people than just selinux users and
> would be more friendly upstream. the core/fileutils patches don't
> really even need to rely on libselinux since xattr is now standard
> in the kernel and the library for accessing xattr's is completely 
> separate from selinux..

The xattr API only supports a subset of the SELinux API.  For example,
the xattr API provides no way to create a file with a specified
attribute value; you have to create the file with some default behavior,
typically inherit-from-parent-directory, and then change its attribute. 
This leaves a window where the file may be accessible to unauthorized
processes.  The SELinux API allows for immediate creation of a file with
a specified attribute.  The new SELinux API makes use of three
components:  the process attribute API (/proc/pid/attr), the xattr API,
and the selinuxfs policy API.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
