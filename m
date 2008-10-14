Subject: Re: user guide drafts: Maintaining SELinux Labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        Glenn Faden <Glenn.Faden@sun.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48F02876.3020203@redhat.com>
References: <737og9$5vh3i@dmzms99902.na.baesystems.com>
	 <48ED4FBC.4020303@redhat.com>
	 <1223643319.25569.23.camel@moss-spartans.epoch.ncsc.mil>
	 <48F02876.3020203@redhat.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:15:26 -0400
Message-Id: <1223993726.5193.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-10-11 at 14:15 +1000, Murray McAllister wrote:
> Thanks. How about:
> 
> When files and directories are copied, the SELinux context of the new 
> file or directory depends on the context of the creating process, and 
> the context of the target, parent directory: the type is inherited from 
> the target, parent directory (unless a type transition rule exists[1]); 
> the SELinux user identity and level are inherited from the creating 
> process; and the role is always object_r, which is a generic role for 
> files. This helps ensure files and directories are labeled with the 
> correct SELinux context after being copied.

It still seems a bit confusing to read.  Part of the issue is that you
are confusing two things above:
- file copying,
- new file creation

The default labeling rules apply whenever a new file is created at
runtime.  File copying is a particular case where a new file is created,
and there are two situations for it:
- (default) New file is created in accordance with the usual default
labeling rules, thereby _not_ necessarily preserving the context of the
original file but rather reflecting the runtime properties of the new
file.  Example:  When a top secret process copies an unclassified file,
the new file is necessarily top secret, not unclassified.
- (when using options to preserve context of the original file) New file
is created with the context of the original file, thereby preserving the
context of the original and _not_ reflecting the runtime properties of
the new file.  The ability to do this is limited by policy and may fail
for a variety of reasons, e.g.:
1) the process may not be authorized to create files with the original
file label (e.g. top secret process may not create unclassified file,
user_t process may not create an etc_t file),
2) the file security context may not be allowed to exist within the
target file system (e.g. top secret file may not be created within a
filesystem capped at secret, passwd_exec_t file may not be created on
removable media).

> Also, when a file is copied over an existing file, the existing file's 
> context is maintained, unless the user specified cp options to preserve 
> the context of the original file, such as --preserve=context.
> 
> #Is the following required, or is it covered by the above:
> 
> On systems running the MLS policy, when files and directories are 
> copied, they inherit the type from the parent directory they are being 
> copied to, and the level from the process that copied them.
> 
> [1] By default, the type is copied from the parent directory. This 
> behavior can be overridden by using type_transition statements in custom 
> SELinux policies. Type transition rules are for a creating process 
> domain, parent directory type, and file object class triple. For 
> example, when a process creates a file in /tmp/, a type transition rule 
> is usually defined so that each domain gets its own private, temporary 
> file type.
> >>  On systems running the MLS policy, when 
> >> files are copied, they inherit the type from the parent directory they 
> >> are being copied to, and the level from the process that copied them.
> >>
> >> Is the last sentence, is "the level from the process that copied them" 
> >> correct? Should it be "from the process or user that..."?
> >>
> >> [1] By default, the type is copied from the parent directory. This 
> >> behavior can be overridden by using type_transition statements in custom 
> >> SELinux policies.
> >>
> >> I've included an example at the end of the section to show copying a 
> >> file over an existing one.
> >>
> >> Thanks for your feedback.
> >>
> >> --
> >> This message was distributed to subscribers of the selinux mailing list.
> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
