Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9VESYWt019147
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 09:28:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9VESAC7000876
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:28:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9VESAuw000873
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:28:10 GMT
Subject: Re: attr_copy_file()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310310933.46513.russell@coker.com.au>
References: <200310310933.46513.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1067610504.30233.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 31 Oct 2003 09:28:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-30 at 17:33, Russell Coker wrote:
> This function usually returns errors when running on SE Linux.  It tries to 
> set the security.selinux attribute which in most cases will fail, and is 
> often not desirable even if it will work.
> 
> To deal with this it has to check for a security.selinux attribute name and 
> for whether SE Linux is active, if so then it needs special case handling.
> 
> I am considering two options for dealing with this.  One is to just never copy 
> security.selinux when SE Linux is enabled, the other is to never display 
> EPERM error messages in this case if the operation fails.  The problem with 
> the latter is that every cp by sysadm_t acts like a "cp -c", which often is 
> not what you desire.
> 
> This gets ugly in that code for is_selinux_enabled() will need to be copied 
> into libxattr source (can't have libxattr and libselinux depend on each 
> other).

- libselinux no longer depends on libattr at all, as it can obtain the
[gs]etxattr functions from glibc.  I posted a patch to eliminate the
libattr dependency a while back.

- attr_copy_file doesn't appear to be called from the RH coreutils SRPM,
so I assume you are looking at the one from acl.bestbits.at for some
reason.  Or has the coreutils xattr patch been incorporated into a more
recent RH one?

- In the coreutils-xattr patch, a filter is already applied (via
attr_copy_check_permissions) that excludes POSIX ACLs, trusted
SGI attributes, and xfsroot attributes from the default copying
behavior.  It would be trivial to add a test to
attr_copy_check_permissions to also exclude all attributes beginning
with the "security." prefix, which are also permission-related.  I'd
suggest submitting a patch to acl-devel to do this.

- I don't see any reason for libattr to test for the presence of
SELinux.  It just needs to be patched to know about the "security."
prefix as another namespace that has to do with file permissions and
thus should not be copied by default.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
