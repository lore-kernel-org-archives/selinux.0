Subject: Re: Security contexts for the contexts directory?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
In-Reply-To: <40B5F324.9010208@redhat.com>
References: <40B5D706.2050902@redhat.com>
	 <1085663772.1072.149.camel@moss-spartans.epoch.ncsc.mil>
	 <40B5F324.9010208@redhat.com>
Content-Type: text/plain
Message-Id: <1085668041.1072.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 27 May 2004 10:27:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-27 at 09:54, Daniel J Walsh wrote:
> Ok how about, default_contexts_t for contexts directory and users 
> directory.  Create a new directory called files and put file_contexts in 
> there with a context of file_contexts_t.

The existing default_context_t (no 's') type seems reasonable for the
contexts directory and users subdirectory.  Note however that this will
likely require new allow rules in the policy, as some domains may have
previously had read access to the files under etc_t and will now need
read permission to default_context_t.

> Should that have default_contexts_t also? Or something different?

/etc/selinux/config should have a different type.  We could define a
type for the /etc/selinux directory and simply use that type for the
config file as well to ease maintenance.  That would also make sense
from a control perspective - you are unlikely to be allowed to modify
the /etc/selinux directory (e.g. add new policies under it) unless you
can also modify /etc/selinux/config to set the type.  No other files
under /etc/selinux would normally have that type, as everything else is
a subdirectory and has a separate type assigned.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
