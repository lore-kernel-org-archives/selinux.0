Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DNw5LU021760
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 19:58:05 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so1930174ywc.11
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 16:57:59 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com.
 [209.85.219.174])
 by smtp.gmail.com with ESMTPSA id l69-v6sm1877654ywe.40.2018.09.13.16.57.56
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Sep 2018 16:57:57 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id w184-v6so1639038ybe.11
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 16:57:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 13 Sep 2018 16:57:54 -0700
Message-ID: <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/13/2018 4:06 PM, Kees Cook wrote:
>> - what order should any stacking happen? Makefile? security=?
> Makefile by default.

Okay, if ordering is by Makefile and everyone dislikes my
$lsm.enabled=0/1 thing, then these mean the same thing:

security=selinux,tomoyo
security=tomoyo,selinux

i.e. order of security= is _ignored_ in favor of the Makefile ordering.

That seems dangerous to accept input that is "out of order", though,
if we ever DO want to make order definable.

-Kees

-- 
Kees Cook
Pixel Security
