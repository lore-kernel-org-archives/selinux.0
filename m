Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85HDb3G029154
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 13:13:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id l189-v6so2928449ywb.10
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 10:13:32 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177])
 by smtp.gmail.com with ESMTPSA id p190-v6sm840390ywg.95.2018.09.05.10.13.28
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Sep 2018 10:13:29 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id m123-v6so2987068ybm.0
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 10:13:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <5806108.mdyebWjNCB@liv>
 <CACT4Y+ZVHit9C-w78mEUEtpZjyncaR_3S5fu_KZk2YuBtthK9w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Sep 2018 10:13:27 -0700
Message-ID: <CAGXu5j+OhEFJQJTiip5AmL2PYgBZwwL7vaRCFjSaFOXhwJnx0Q@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Russell Coker <russell@coker.com.au>, Stephen Smalley <sds@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>,
 syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
 Tyler Hicks <tyhicks@canonical.com>,
 John Johansen <john.johansen@canonical.com>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Serge Hallyn <serge@hallyn.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 SELinux <selinux@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 4, 2018 at 7:53 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Again, if you change wheezy to stretch here, it should reproduce the problem:
> https://github.com/google/syzkaller/blob/master/tools/create-image.sh

FWIW, I sent an update for the image version here:
https://github.com/google/syzkaller/pull/708

-Kees

-- 
Kees Cook
Pixel Security
