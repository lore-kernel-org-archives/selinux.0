Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t53L1v6L026710
 for <selinux@tycho.nsa.gov>; Wed, 3 Jun 2015 17:01:58 -0400
Received: by oihb142 with SMTP id b142so17085296oih.3
 for <selinux@tycho.nsa.gov>; Wed, 03 Jun 2015 14:01:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95BzUMsq72Nr-r=oZjttVyq3kwUeWOJfG9mxboSAYS09bg@mail.gmail.com>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl> <555DD091.8060307@tycho.nsa.gov>
 <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
 <555DEA32.4080205@tycho.nsa.gov>
 <CAHC9VhQSA7KuDwL3x45iShSGgsd11Yv3vS=_O4BN_S=fhvrQgg@mail.gmail.com>
 <CABXk95ARYdCokbGYLW8REPjx_qH-X--xsZcCmLnRoGU7KP+nZQ@mail.gmail.com>
 <CAHC9VhTmrJciwdkjGaMjx2RhyrS_En6JZF-pxWiWoz8geF_f3w@mail.gmail.com>
 <CABXk95BzUMsq72Nr-r=oZjttVyq3kwUeWOJfG9mxboSAYS09bg@mail.gmail.com>
Date: Wed, 3 Jun 2015 17:01:55 -0400
Message-ID: <CAHC9VhTZ=gUTDhBuPwb7b3=Y_rjodHneMyK2K2v=LtVqbiYY5w@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 3, 2015 at 2:40 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> Ok, I have finished a revision that addresses your comments (will
> email out shortly). You'll be happy to hear that I am using "extended
> permissions" instead of "operations."
>
> I tried to focus on:
>
> -Creating a stable binary policy format that will work for ioctls and
> netlink (and others) such that the policy version XPERMS_IOCTL will
> remain valid if/when version XPERMS_NETLINK is added

Great, thank you.  I realize we may need to change it when we get
there, but I appreciate the effort.

> -Keeping the current version simple, don’t partially add logic for
> selecting between ioctl/netlink in the AVC. I originally started
> adding additional components to the avc structures, but a few
> questions came up that Stephen and I did not know the answer to. It
> makes sense to punt these decisions to if/when the netlink extended
> permissions capability is actually added (saves memory in the
> meantime). The internals can change as long as the binary policy is
> stable.

That sounds fine to me.

-- 
paul moore
www.paul-moore.com
