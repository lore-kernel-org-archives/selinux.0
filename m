Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3394nhe032584
 for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2015 05:04:49 -0400
Received: by obbec2 with SMTP id ec2so163387326obb.3
 for <selinux@tycho.nsa.gov>; Fri, 03 Apr 2015 02:04:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.11.1504031344190.16304@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <alpine.LRH.2.11.1504022331430.4811@namei.org>
 <3507958.kG4l2LfREA@sifl>
 <alpine.LRH.2.11.1504031344190.16304@namei.org>
Date: Fri, 3 Apr 2015 05:04:47 -0400
Message-ID: <CAHC9VhSHRWDuA+DKV_XxMq4+b5Q64O2_E6dpPmouoM3OO4rA7Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 2, 2015 at 10:45 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 2 Apr 2015, Paul Moore wrote:
>
>> necessary to resolve conflicts.  When I do a test merge into your next branch
>> I see the following:
>>
>>   #git pull selinux next
>>   From git://git.infradead.org/users/pcmoore/selinux
>>    * branch            next       -> FETCH_HEAD
>>   Auto-merging security/selinux/selinuxfs.c
>>   Merge made by the 'recursive' strategy.
>>    security/selinux/avc.c         |  6 ++--
>>    security/selinux/selinuxfs.c   |  2 +-
>>    security/selinux/ss/avtab.c    | 72 +++++++++++++++++++++++++++++---------
>>    security/selinux/ss/avtab.h    |  8 +++--
>>    security/selinux/ss/mls.c      | 10 ++----
>>    security/selinux/ss/services.c |  6 +---
>>    6 files changed, 68 insertions(+), 36 deletions(-)
>>
>> The merge diffstat looks as I would expect, the only odd thing is selinuxfs.c,
>> but it looks like that is simply because your next branch doesn't include the
>> error code fix I sent you for v4.0:
>>
>>   commit 6436a123a147db51a0b06024a8350f4c230e73ff
>>   Author: Joe Perches <joe@perches.com>
>>   Date:   Mon Mar 23 18:01:35 2015 -0700
>>
>>     selinux: fix sel_write_enforce broken return value
>>
>>     Return a negative error value like the rest of the entries in this
>>     function.
>>
>>     Cc: <stable@vger.kernel.org>
>>     Signed-off-by: Joe Perches <joe@perches.com>
>>     Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>     [PM: tweaked subject line]
>>     Signed-off-by: Paul Moore <pmoore@redhat.com>
>>
>> Are you asking because you ran into a problem, or just to check?
>
> Yep, I saw that and some backmerge strangeness.  Did you rebase your tree
> after I created a fresh branch?

It looks like I'm based off your tree from Feb 1st, the last commit
from your tree looks to be: 11cd64a234d5a1a7111627ef947beb0e5fad9e71.

Do you need me to rebase?

-- 
paul moore
www.paul-moore.com
