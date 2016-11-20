Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAKMGq2I001571
 for <selinux@tycho.nsa.gov>; Sun, 20 Nov 2016 17:16:53 -0500
Received: by mail-ua0-f193.google.com with SMTP id b35so23578040uaa.1
 for <selinux@tycho.nsa.gov>; Sun, 20 Nov 2016 14:16:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1479479438-7123-1-git-send-email-sds@tycho.nsa.gov>
References: <1479479438-7123-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 20 Nov 2016 17:16:50 -0500
Message-ID: <CAHC9VhQkHty-tj+fPJpZEj34EsuKs7p5m00Wqe0noJg2JYHKLg@mail.gmail.com>
Subject: Re: [PATCH] selinux: normalize input to /sys/fs/selinux/enforce
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Nov 18, 2016 at 9:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> At present, one can write any signed integer value to
> /sys/fs/selinux/enforce and it will be stored,
> e.g. echo -1 > /sys/fs/selinux/enforce or echo 2 >
> /sys/fs/selinux/enforce. This makes no real difference
> to the kernel, since it only ever cares if it is zero or non-zero,
> but some userspace code compares it with 1 to decide if SELinux
> is enforcing, and this could confuse it. Only a process that is
> already root and is allowed the setenforce permission in SELinux
> policy can write to /sys/fs/selinux/enforce, so this is not considered
> to be a security issue, but it should be fixed.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged, thanks.

-- 
paul moore
www.paul-moore.com
