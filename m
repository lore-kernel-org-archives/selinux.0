Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t95LuF51006364
 for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2015 17:56:15 -0400
Received: by laag4 with SMTP id g4so6997492laa.2
 for <selinux@tycho.nsa.gov>; Mon, 05 Oct 2015 14:56:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5612927E.4000801@tycho.nsa.gov>
References: <1443986381-14412-1-git-send-email-agruenba@redhat.com>
 <1443986381-14412-2-git-send-email-agruenba@redhat.com>
 <5612927E.4000801@tycho.nsa.gov>
Date: Mon, 5 Oct 2015 23:56:12 +0200
Message-ID: <CAHc6FU78E-aTZP9gw51iO3e277AZ1UA7R-_Qw8Bwe=idJ=qmbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] security: Add hook to invalidate inode security
 labels
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 5, 2015 at 5:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Not fond of these magic initialized values.

That should be a solvable problem.

> Is it always safe to call inode_doinit() from all callers of
> inode_has_perm()?

As long as inode_has_perm is only used in contexts in which a file
permission check / acl check would be possible, I don't see why not.

> What about the cases where isec->sid is used without going through
> inode_has_perm()?

inode_has_perm seems to be called frequently and invalid labels seem
to be reload quickly, so this change may make SELinux work well enough
to be useful on top of gfs2 or similar. More checks would of course be
better. The ideal case would be to always reload invalid labels, but
that currently won't be possible because we don't have dentries
everywhere.

I can't tell if this is this good enough to provide a useful level of
protection. In any case, without a patch like this, on gfs2 and
similar file systems, SELinux currently doesn't work at all.

How we can make progress with this problem?

Thanks,
Andreas
