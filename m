Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8DN1h7o013998
 for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2018 19:01:44 -0400
To: Paul Moore <paul@paul-moore.com>, Golden_Miller83@protonmail.ch
Cc: keescook@chromium.org, linux-security-module@vger.kernel.org,
 James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org,
 casey.schaufler@intel.com
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <tb3zfQ7fac9Oth8YArOo84SbMfqV1s0DjOmVy7op90J_o1XOaEjflZloOpj9PIiUQRhKJxhauXzJD3irkSSjOXK94qYlfQ1frIQiH1OTWPQ=@protonmail.ch>
 <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <372226d8-89ec-312d-7698-9b2b9e8ec85b@schaufler-ca.com>
Date: Thu, 13 Sep 2018 16:01:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR0qfTn3qwVGpBV=LcM8O1jz-dmqxTW0OqJ-xfO+1k6ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/13/2018 2:50 PM, Paul Moore wrote:
> On Thu, Sep 13, 2018 at 4:58 PM Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
>
>> This implies that your real concern is something else than
>> CONFIG_SECURITY_STACKING which only allows you to ignore the whole
>> thing. Please reveal it. There are a lot of people waiting for LSM
>> stacking which is several years late and it would be great to
>> resolve potential issues earlier  rather later.

It would be really handy if the "lot of people" were a lot more
vocal about their impatience. Keeping the stacking work on the stove,
much less on a front burner, hasn't always been easy.

> What?  I resent the implication that I'm hiding anything; there are a
> lot of fair criticisms you could level at me, but I take offense at
> the idea that I'm not being honest here.  I've been speaking with
> Casey, John, and others about stacking for years, both on-list and
> in-person at conferences, and my
> neutral-opinion-just-make-it-work-for-everything-and-make-it-optional
> stance has been pretty consistent and isn't new.

Paul has always been quite upfront about this, and responsive as well.
I won't say that we always agree because we don't, but I don't have a
good argument against either point.

> Also, let's be really clear here: I'm only asking that stacking be
> made a build time option (as it is in Casey's patchset).  That seems
> like a pretty modest ask for something so significant and "several
> years late" as you put it.

There's a significant difference between something taking a long time
and something being late. I hope that I haven't given anyone the impression
that I'd have this finished years ago. If so, I owe whoever that was a
beer. This patch set may look deceptively straight forward, but there have
been many heavy branches pruned from the tree. This subset of the total
change for "extreme" stacking represents the easy part. Without a road map
for completing the task (i.e. any/all modules together) Paul's hesitation
to take anything is defensible, and the desire that it be configurable
reasonable.
