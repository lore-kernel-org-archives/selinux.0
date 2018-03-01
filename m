Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w21GL1aZ025928
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 11:21:01 -0500
Received: by mail-lf0-f68.google.com with SMTP id 70so9181279lfw.2
 for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2018 08:20:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519914989.3063.1.camel@btinternet.com>
References: <20180301083316.GA6779@localhost.localdomain>
 <CAHC9VhQAnsSTK4V2w3+CiikR6465Jpnu7_vr=3VFEQch7LECtA@mail.gmail.com>
 <1519914989.3063.1.camel@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Mar 2018 11:20:55 -0500
Message-ID: <CAHC9VhSz-Dq2uph47B4VRyH-jOKER+5Ajm5pxjQuYcdR4GjH-g@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, netdev@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Regression found when running LTP connect01 on
 next-20180301
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 1, 2018 at 9:36 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
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

Thanks.  Let me know if you get stuck.

-- 
paul moore
www.paul-moore.com
