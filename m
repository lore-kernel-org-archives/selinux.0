Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 15:01:14 -0400
Message-Id: <1147892474.30789.398.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 13:52 -0400, Karl MacMillan wrote:
> This leads me to conclude that package managers may need to be able to
> set raw contexts that are not currently valid. It is not a pleasant
> trade-off, but it does have potential side benefits for backup and
> restore tools.

I don't think it is useful for restore(8), as lgetxattr() will show it
as unlabeled_t and compares will still fail.  Per the earlier discussion
on this thread.

It might have some utility in creating filesystems for a system running
a different policy than the build/host system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
