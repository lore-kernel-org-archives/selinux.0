Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAAFjsZT021502
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 10:45:54 -0500
Received: by mail-qc0-f171.google.com with SMTP id m20so5949250qcx.16
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 07:45:40 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/7] Overlayfs: Use copy-up security hooks
Date: Mon, 10 Nov 2014 10:45:37 -0500
Message-ID: <3253042.xfZ6VF8OvX@sifl>
In-Reply-To: <3148.1415397940@warthog.procyon.org.uk>
References: <4109261.WfcAOoSvNG@sifl>
 <20141105154238.2555.85960.stgit@warthog.procyon.org.uk>
 <3148.1415397940@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-unionfs@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 07, 2014 10:05:40 PM David Howells wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > So the LSM must modify the xattr in place?  I suppose that since the
> > @value is allocated to the max size it shouldn't be a problem.  Just
> > checking ...
> 
> ... And the caller must provide a maximally sized buffer (which it likely
> has to allocate anyway).
> 
> I'm not sure I really need to provide the modification thing.  I suspect a
> binary keep or discard decision is sufficient.

The docker use case we've been talking about in this thread doesn't really 
care about the on-disk file labels (xattrs) because the docker folks want to 
use context= mounts; however if someone did care about on-disk file labels for 
the upper layer in the overlayfs then they might want to modify the xattr.

-- 
paul moore
www.paul-moore.com
