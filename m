Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t33MMPo8015512
 for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2015 18:22:25 -0400
Received: by obvd1 with SMTP id d1so186739533obv.0
 for <selinux@tycho.nsa.gov>; Fri, 03 Apr 2015 15:22:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.11.1504040206200.15145@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <alpine.LRH.2.11.1504022331430.4811@namei.org>
 <3507958.kG4l2LfREA@sifl>
 <alpine.LRH.2.11.1504031344190.16304@namei.org>
 <CAHC9VhSHRWDuA+DKV_XxMq4+b5Q64O2_E6dpPmouoM3OO4rA7Q@mail.gmail.com>
 <alpine.LRH.2.11.1504040206200.15145@namei.org>
Date: Fri, 3 Apr 2015 18:22:22 -0400
Message-ID: <CAHC9VhRXygXu7UD=rsjsKn5n1UmFozixHmtrhFWohmHbOjijUA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Apr 3, 2015 at 11:07 AM, James Morris <jmorris@namei.org> wrote:
> On Fri, 3 Apr 2015, Paul Moore wrote:
>
>> > Yep, I saw that and some backmerge strangeness.  Did you rebase your tree
>> > after I created a fresh branch?
>>
>> It looks like I'm based off your tree from Feb 1st, the last commit
>> from your tree looks to be: 11cd64a234d5a1a7111627ef947beb0e5fad9e71.
>>
>> Do you need me to rebase?
>>
>
> Yep, see if that fixes things.

Okay, try it now; I rebased selinux#upstream against your latest next
branch.  The same patches are included, just in a slightly different
order, and I included the error code fix for -stable since it isn't in
your next branch or Linus' current.

  # git pull git://git.infradead.org/users/pcmoore/selinux upstream
  From git://git.infradead.org/users/pcmoore/selinux
   * branch            upstream   -> FETCH_HEAD
  Updating 4f9a60f..6ad2606
  Fast-forward
   security/selinux/avc.c         |  6 ++--
   security/selinux/selinuxfs.c   |  2 +-
   security/selinux/ss/avtab.c    | 72
++++++++++++++++++++++++++++++++----------
   security/selinux/ss/avtab.h    |  8 +++--
   security/selinux/ss/mls.c      | 10 ++----
   security/selinux/ss/services.c |  6 +---
   6 files changed, 68 insertions(+), 36 deletions(-)

-- 
paul moore
www.paul-moore.com
