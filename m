Message-Id: <sf7751ab.035@atlas.snu.edu>
Date: Sun, 28 Sep 2003 21:24:33 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <SELinux@tycho.nsa.gov>
Subject: is_selinux_enabled in fileutils
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm just wondering a few things about the new API patches
for fileutils (and no doubt others)

right now the ls, cp, mv patches etc do an is_selinux_enabled
check which isn't technically required (since xattr is not specific
to selinux). IMHO these artificial contraints shouldn't be added
so that recovery cd's and things of this nature which have xattr
enabled but not selinux will be able to see/copy/move files with
their context. We aren't gaining any security by adding these
contraints since libxattr, setfattr, getfattr, etc doesn't care
if selinux is enabled or not (and are easier for mangling attributes
anyway).

second, why aren't the selinux patches to file/coreutils generalized
for all extended attributes? If we (or someone) made patches that
would copy/move/view all extended attributes or just specified ones
it could be used by many more people than just selinux users and
would be more friendly upstream. the core/fileutils patches don't
really even need to rely on libselinux since xattr is now standard
in the kernel and the library for accessing xattr's is completely 
separate from selinux..

Thanks..

Joshua Brindle
Hardened Gentoo



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
