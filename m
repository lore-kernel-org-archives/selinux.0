Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050112144411.GZ26175@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <20050110232312.GI6967@lkcl.net>
	 <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
	 <20050111214818.GE26175@lkcl.net>
	 <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112144411.GZ26175@lkcl.net>
Content-Type: text/plain
Message-Id: <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 10:00:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 09:44, Luke Kenneth Casson Leighton wrote:
>  ... how about encoding the file attributes in the policy files,
>  such that they are ACL-like?

I don't follow your line of thinking.  The policy defines allowed
interactions among security equivalence classes (types for TE, levels
for MLS).  A file attribute (which is merely a tag identifying the
security equivalence class into which the file falls) is stored in the
filesystem, associated with the inode.  You don't want to move the
file->type associations into the policy; you want them bound to the real
objects and maintained properly at runtime.

>  the ultimate aim of which would be to make it easier for
>  administrators to add permissions and programs without going
>  through a complete policy rebuild / reload.

This functionality can all be built on top of the existing mechanism. 
And we already have some incremental steps in this direction:
- the conditional policy support developed by Tresys, included in the
mainline SELinux, and used extensively now in Fedora, allows
well-defined changes in policy based on policy boolean settings that can
be manipulated from userspace and controlled at fine granularity,
- the binary policy module support developed by Tresys allows policy
modules to be constructed, built, and distributed without requiring a
full policy source rebuild and providing proper dependency checking,
- the policy daemon being developed by Tresys will allow policy
management to be decomposed.

See the mailing list archives if you haven't already read about it. 
Obviously, there is much work to do in this space, and contributors are
welcome.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
