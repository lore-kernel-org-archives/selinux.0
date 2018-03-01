Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21I4R8H000847
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 13:04:28 -0500
Received: by mail-qt0-f196.google.com with SMTP id c7so8685998qtn.3
 for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2018 10:04:02 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
 <linux-kernel@vger.kernel.org>, <anders.roxell@linaro.org>
Date: Thu, 01 Mar 2018 13:03:51 -0500
Message-ID: <161e2bc0f58.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1519914989.3063.1.camel@btinternet.com>
References: <20180301083316.GA6779@localhost.localdomain>
 <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
 <1519914989.3063.1.camel@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: Regression found when running LTP connect01 on
 next-20180301
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On March 1, 2018 9:36:37 AM Richard Haines <richard_c_haines@btinternet.com> wrote:
> On Thu, 2018-03-01 at 08:42 -0500, Paul Moore wrote:
>> On Thu, Mar 1, 2018 at 3:33 AM, Anders Roxell <anders.roxell@linaro.o
>> rg> wrote:
>> > Hi,
>> > 
>> > I was running LTP's testcase connect01 [1] and found a regression
>> > in linux-next
>> > (next-20180301).  Bisect gave me this patch as the problematic
>> > patch (sha
>> > d452930fd3b9 "selinux: Add SCTP support") on a x86 target.
>> > 
>> > Output from the test(LTP release 20180118):
>> > $ cd /opt/ltp/
>> > $ cat runtest/syscalls |grep connect01>runtest/connect-syscall
>> > $ ./runltp -pq -f connect-syscall
>> > "
>> > Running tests.......
>> > connect01    1  TPASS  :  bad file descriptor successful
>> > connect01    2  TPASS  :  invalid socket buffer successful
>> > connect01    3  TPASS  :  invalid salen successful
>> > connect01    4  TPASS  :  invalid socket successful
>> > connect01    5  TPASS  :  already connected successful
>> > connect01    6  TPASS  :  connection refused successful
>> > connect01    7  TFAIL  :  connect01.c:146: invalid address family ;
>> > returned -1 (expected -1), errno 22 (expected 97)
>> > INFO: ltp-pan reported some tests FAIL
>> > LTP Version: 20180118
>> > "
>> > 
>> > The output from the test expected 97 and we received 22, can you
>> > please
>> > elaborate on what have been changed?
>> > 
>> > Cheers,
>> > Anders
>> > [1] https://github.com/linux-test-project/ltp/blob/20180118/testcas
>> > es/kernel/syscalls/connect/connect01.c#L146
>> 
>> Hi Anders,
>> 
>> Thanks for the report.  Out of curiosity, we're you running the full
>> LTP test suite and this was the only failure, or did you just run the
>> connect01 test?  Either answer is fine, I'm just trying to understand
>> the scope of the regression.
>> 
>> Richard, are you able to look into this?  If not, let me know and
>> I'll
>> dig a bit deeper (I'll likely take a quick look today, but if the
>> failure is subtle it might require some digging).
>
> I'll have a look today.

One more thing I forgot to mention earlier, if there is a patch to fix this, could you please base it on top of the existing SELinux/SCTP patches that have already been merged, and not respin an earlier patch?

Thank you.

--
paul moore
www.paul-moore.com
