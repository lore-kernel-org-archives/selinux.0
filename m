Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4MI35sJ020822
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 14:03:05 -0400
Received: by oige141 with SMTP id e141so19673258oig.1
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 11:03:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95ARYdCokbGYLW8REPjx_qH-X--xsZcCmLnRoGU7KP+nZQ@mail.gmail.com>
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl> <555DD091.8060307@tycho.nsa.gov>
 <CAHC9VhTX8k2gSVBZaX_68b11OzBxFhWbkLrHfpjZ=v0h=82Ceg@mail.gmail.com>
 <555DEA32.4080205@tycho.nsa.gov>
 <CAHC9VhQSA7KuDwL3x45iShSGgsd11Yv3vS=_O4BN_S=fhvrQgg@mail.gmail.com>
 <CABXk95ARYdCokbGYLW8REPjx_qH-X--xsZcCmLnRoGU7KP+nZQ@mail.gmail.com>
Date: Fri, 22 May 2015 14:03:03 -0400
Message-ID: <CAHC9VhTmrJciwdkjGaMjx2RhyrS_En6JZF-pxWiWoz8geF_f3w@mail.gmail.com>
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

On Thu, May 21, 2015 at 11:14 AM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> I selected operation because it is not ioctl specific. Stephen and I
> had discussed the possibility of this being used for other things but
> ultimately decided to focus on ioctls because that was my intended
> use-case. I would be ok with other names, but I also thing the naming
> could be kept the same and I could add clearer in-code comments to
> better convey the extended operations or extended permissions idea.

<grumble> <grumble> <grumble>

Okay, it's been a day and I can't think of anything else beyond what
we've discussed so just stick with operation for now and add some
better comments.  It's all internal anyway so renaming in the future
is a non-issue (minus the usual code churn arguments).

-- 
paul moore
www.paul-moore.com
