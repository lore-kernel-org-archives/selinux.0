Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sARKF0pV008820
 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2014 15:15:00 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so4157806obc.38
 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2014 12:14:58 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <20141127173851.GA16764@e145.network2>
References: <5463658D.7050702@tresys.com>
 <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
 <20141124112636.GA6200@e145.network2>
 <CAPzO=NyHcEdpQN9iVwEC5LXtYzWjaK0jajz2tFG3pf+-HXqDaA@mail.gmail.com>
 <CAPzO=Nxda_B6u8wX3UmM5DNdOSe568h8tiQmtLTdxHMJEQqMbw@mail.gmail.com>
 <20141127173851.GA16764@e145.network2>
Date: Thu, 27 Nov 2014 21:14:58 +0100
Message-ID: <CAPzO=NzR1kCWTE1fzNo7cFj8v=mEk1K81hFv1bQZLW2piUq7uQ@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc6
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Nov 27, 2014 at 6:38 PM, Dominick Grift <dac.override@gmail.com> wrote:
> On Thu, Nov 27, 2014 at 01:23:13PM +0100, Sven Vermeulen wrote:
>>
>> So in this case, object_r is assigned (during migration) to system_u,
>> unconfined_u and user_u, but not to root, staff_u, sysadm_u and
>> testrole_u.
>>
>> Those roles still work though. Is showing object_r in the "SELinux
>> Roles" part cosmetic perhaps?
>>
>
> Strange ... as far as i know object_r needs to be associated with everyone
>
> Is your output of seinfo -xu consistent with that of semanage user (as far as roles associated with identities is concerned)?

It is not. seinfo -xu shows object_r to be associated with *all* roles
(as you suggested) whereas the "semanage user -l" output shows it
missing with a few of them.

This is the only inconsistency though - the rest of the output does match.

Wkr,
  Sven Vermeulen
