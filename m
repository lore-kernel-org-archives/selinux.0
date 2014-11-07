Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7M5oNE025379
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 17:05:50 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4109261.WfcAOoSvNG@sifl>
References: <4109261.WfcAOoSvNG@sifl>
 <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154238.2555.85960.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 2/7] Overlayfs: Use copy-up security hooks
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 07 Nov 2014 22:05:40 +0000
Message-ID: <3148.1415397940@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore <paul@paul-moore.com> wrote:

> So the LSM must modify the xattr in place?  I suppose that since the @value
> is allocated to the max size it shouldn't be a problem.  Just checking ...

... And the caller must provide a maximally sized buffer (which it likely has
to allocate anyway).

I'm not sure I really need to provide the modification thing.  I suspect a
binary keep or discard decision is sufficient.

David
