Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7MAhYs025800
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 17:10:43 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2455443.WUExuKDC0I@sifl>
References: <2455443.WUExuKDC0I@sifl>
 <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154228.2555.55814.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 1/7] Security: Provide copy-up security hooks for unioned
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 07 Nov 2014 22:10:34 +0000
Message-ID: <3206.1415398234@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore <paul@paul-moore.com> wrote:

> This didn't occur to me earlier, but we may want to pick a different phrase
> to use instead of "copy_up" as that has a special meaning for some
> security/MLS folks...

It does?

security_inode_make_union()?

David
