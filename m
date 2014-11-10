Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAAFS6vM020155
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 10:28:07 -0500
Received: by mail-qa0-f47.google.com with SMTP id dc16so5452001qab.6
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 07:28:04 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/7] Security: Provide copy-up security hooks for unioned
 files
Date: Mon, 10 Nov 2014 10:28:02 -0500
Message-ID: <1598563.E145j9ZHLH@sifl>
In-Reply-To: <3206.1415398234@warthog.procyon.org.uk>
References: <2455443.WUExuKDC0I@sifl>
 <20141105154228.2555.55814.stgit@warthog.procyon.org.uk>
 <3206.1415398234@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-unionfs@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 07, 2014 10:10:34 PM David Howells wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > This didn't occur to me earlier, but we may want to pick a different
> > phrase to use instead of "copy_up" as that has a special meaning for some
> > security/MLS folks...
> 
> It does?

Yep, think upgrading the sensitivity level, e.g. relabeling a "secret" file up 
to a "top secret".

> security_inode_make_union()?

Actually, after thinking on this some more, forget I mentioned anything.  The 
existing "copy_up" makes the most sense for the LSM hook (it matches the 
naming of the caller in overlayfs, which is a nice thing) and the number of 
times any MLS will look that closely at the kernel code is going to be very 
few.

-- 
paul moore
www.paul-moore.com
