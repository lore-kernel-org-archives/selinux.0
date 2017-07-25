Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6PJvYbo017270
 for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2017 15:57:34 -0400
Received: by mail-lf0-f53.google.com with SMTP id m86so53078043lfi.4
 for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2017 12:21:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1707251056220.17168@namei.org>
References: <alpine.LRH.2.20.1707251056220.17168@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Jul 2017 15:21:21 -0400
Message-ID: <CAHC9VhR4=mnnzwcbVr3Xn3EUDcTgBEV0+m8gRYHfyvUZ5eFh-w@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Security next tree merged to v4.13-rc2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 24, 2017 at 8:57 PM, James Morris <jmorris@namei.org> wrote:
> FYI for subsystem developers.

I just rebased the selinux/next branch on top this, for those of you
who have patches in-flight (I believe just Stephen at the moment)
don't bother respinning the patches, I'll take of any merge problems
when I apply your patch.

Also, a heads-up that the official SELinux kernel repository will be
moving soon, more information once it is setup.

-- 
paul moore
www.paul-moore.com
