Subject: Re: Problems with MCS/Targeted policy update.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <430F6474.1040802@redhat.com>
References: <430C776B.4060309@redhat.com>  <430F5C8B.3060102@redhat.com>
	 <1125080692.8692.82.camel@moss-spartans.epoch.ncsc.mil>
	 <430F6474.1040802@redhat.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 14:55:30 -0400
Message-Id: <1125082530.8692.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 14:50 -0400, Daniel J Walsh wrote:
> Ok then I think the security_context_to_sid functions in the kernel need 
> to change to do the translation.

We just need security_context_to_sid_default to return a status to the
caller (inode_doinit) to indicate that the caller needs to perform a
setxattr to update the on-disk state.  Then the caller can get the full
context via a security_sid_to_context() and pass that to setxattr.

That will still only affect existing inodes, nothing else.
selinuxfs, /proc/pid/attr, and setxattr will only accept legal contexts
that include the MLS field.  We are only trying to deal with upgrading
without relabeling filesystems.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
