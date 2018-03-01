Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21EahK3018586
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 09:36:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3zsZkf1FkNz4KSFs
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 14:36:42 +0000 (UTC)
Received: from UPBD19PA03.eemsg.mil (unknown [192.168.18.4])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3zsZkf0Mhnz4KSFy
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 14:36:42 +0000 (UTC)
Message-ID: <1519914989.3063.1.camel@btinternet.com>
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>, Anders Roxell <anders.roxell@linaro.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 14:36:29 +0000
In-Reply-To: <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
References: <20180301083316.GA6779@localhost.localdomain>
 <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Regression found when running LTP connect01 on
 next-20180301
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-03-01 at 08:42 -0500, Paul Moore wrote:
> On Thu, Mar 1, 2018 at 3:33 AM, Anders Roxell <anders.roxell@linaro.o
> rg> wrote:
> > Hi,
> > 
> > I was running LTP's testcase connect01 [1] and found a regression
> > in linux-next
> > (next-20180301).  Bisect gave me this patch as the problematic
> > patch (sha
> > d452930fd3b9 "selinux: Add SCTP support") on a x86 target.
> > 
> > Output from the test(LTP release 20180118):
> > $ cd /opt/ltp/
> > $ cat runtest/syscalls |grep connect01>runtest/connect-syscall
> > $ ./runltp -pq -f connect-syscall
> > "
> > Running tests.......
> > connect01    1  TPASS  :  bad file descriptor successful
> > connect01    2  TPASS  :  invalid socket buffer successful
> > connect01    3  TPASS  :  invalid salen successful
> > connect01    4  TPASS  :  invalid socket successful
> > connect01    5  TPASS  :  already connected successful
> > connect01    6  TPASS  :  connection refused successful
> > connect01    7  TFAIL  :  connect01.c:146: invalid address family ;
> > returned -1 (expected -1), errno 22 (expected 97)
> > INFO: ltp-pan reported some tests FAIL
> > LTP Version: 20180118
> > "
> > 
> > The output from the test expected 97 and we received 22, can you
> > please
> > elaborate on what have been changed?
> > 
> > Cheers,
> > Anders
> > [1] https://github.com/linux-test-project/ltp/blob/20180118/testcas
> > es/kernel/syscalls/connect/connect01.c#L146
> 
> Hi Anders,
> 
> Thanks for the report.  Out of curiosity, we're you running the full
> LTP test suite and this was the only failure, or did you just run the
> connect01 test?  Either answer is fine, I'm just trying to understand
> the scope of the regression.
> 
> Richard, are you able to look into this?  If not, let me know and
> I'll
> dig a bit deeper (I'll likely take a quick look today, but if the
> failure is subtle it might require some digging).

I'll have a look today.
> 
