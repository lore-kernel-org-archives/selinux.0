Subject: Re: [idea] udev + selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Nigel Kukard <nkukard@lbsd.net>, linux-hotplug-devel@lists.sourceforge.net,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
In-Reply-To: <20040831191809.GC4375@lkcl.net>
References: <20040830173744.GD10151@lbsd.net>
	 <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net>
	 <20040831191809.GC4375@lkcl.net>
Content-Type: text/plain
Message-Id: <1093980403.8517.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 31 Aug 2004 15:26:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-31 at 15:18, Luke Kenneth Casson Leighton wrote:
>  i think we need the input of more experienced people than us to
>  say why these associate things are needed.

It provides control over the set of files that can live in a given
filesystem, based on their security types (equivalence classes).  As you
are now creating device types in a different filesystem type, further
allow rules are needed to allow that association.

>  a correct implementation of the
>  hacked-together-relaxed-fscontext-hooks.c-patch results in an atomic
>  operation (mount with a new context which would otherwise need to be
>  achieved with two commands: mount followed by restorecon)

The more important issue is that fscontext= lets you set the superblock
security context, not just the root directory context.  restorecon can't
do that.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
