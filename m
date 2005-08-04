Subject: Re: restoring file attributes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rich turner <rich@storix.com>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <1123088488.4481.51.camel@rich>
References: <1123088488.4481.51.camel@rich>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 09:17:20 -0400
Message-Id: <1123161440.13654.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-03 at 10:01 -0700, rich turner wrote:
> i am performing a bare-metal restore of system that previously was
> selinux-enabled and enforcing. after restoring all of the files on the
> system using tar, i need to reset all of the file security contexts
> (because tar does not backup or restore extended filesystem attributes).
> that leads me to a few questions.

Side bar: Note that star can be used to preserve such attributes,
although you have to invoke it with the right set of options to do so
and usage is a bit arcane.  There are also versions of rsync and dump
that know about EAs.

> 1. i plan to use setfiles to apply extended attributes to files.
> however, setfiles requires that i supply the spec_file to use when
> applying the attributes. is there a consistent way that i can determine
> which spec_file is being used on a running system?

. /etc/selinux/config
SPEC=/etc/selinux/$SELINUXTYPE/contexts/files/file_contexts

Or just run fixfiles.  In Fedora, Red Hat introduced the /sbin/fixfiles
script as a front-end wrapper for setfiles, and it automatically
determines the spec file location using the above technique.  We later
merged fixfiles into the upstream policycoreutils package, it should be
useable from any distro with SELinux support.

> 2. is /etc/selinux/config specific to fc4, or can i expect this same
> file with the same format on all uses of selinux on linux?

libselinux looks for it, so it should be present on all SELinux-enabled
distros.  Older versions of SELinux looked at /etc/sysconfig/selinux and
under /etc/security/selinux, and libselinux still has a fallback for
those locations if /etc/selinux doesn't exist, but that is just for
backward compatibility (e.g. for FC2).  FC3 and later are all
using /etc/selinux/config.

> 3. on a selinux-enabled and enforcing system, is there a way to know
> what SELINUXTYPE is being used? targeted, strict, etc.

/etc/selinux/config is the source of information; whether or not you can
read that file depends on your policy.  sestatus is a utility for
checking various bits of information about your SELinux setup,
originally created by the Hardened Gentoo folks, but is now included in
policycoreutils.

> 4. are "targeted" and "strict" names used by fc4, or will they be
> consistent on other distributions?

At one time at least, I think Debian was only allowing a single policy
to be installed at a time, with the directories and files directly
placed under /etc/selinux and SELINUXTYPE=. in /etc/selinux/config.
I'm not sure if that is still true - Russell will know.

Typically, I'd expect consistency for strict and targeted as the
upstream example policy includes their sources, and libselinux has a
built-in default fallback.  Of course, other policies are already
beginning to show up - mls, refpolicy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
