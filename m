Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6VMhsnl024809
 for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2017 18:43:54 -0400
Received: by mail-lf0-f47.google.com with SMTP id y15so119356438lfd.5
 for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2017 15:43:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170731141246.13547-1-sds@tycho.nsa.gov>
References: <20170731141246.13547-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Jul 2017 18:43:47 -0400
Message-ID: <CAHC9VhRfXO9UuobvG4ckxNtg9xN0FPSUStKmCMkpHJPS-zsLzw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v4] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 31, 2017 at 10:12 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As systemd ramps up enabling NNP (NoNewPrivileges) for system services,
> it is increasingly breaking SELinux domain transitions for those services
> and their descendants ...

...

> v4 moves both of the new permissions to the new process2 class and
> checks both if both NNP is enabled and the mount is nosuid.

This looks good to me, but I'm going to give it another day or two in
case the the policy folks want to comment.

-- 
paul moore
www.paul-moore.com
