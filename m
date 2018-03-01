Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2191AXC001867
 for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2018 04:01:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 3zsRHS3PYwzJ3dt
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 09:01:08 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 3zsRHS1sV4zJ3dZ
 for <selinux@tycho.nsa.gov>; Thu,  1 Mar 2018 09:01:08 +0000 (UTC)
Received: by mail-lf0-f46.google.com with SMTP id g72so7680417lfg.3
 for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2018 01:01:07 -0800 (PST)
Date: Thu, 1 Mar 2018 09:33:16 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: richard_c_haines@btinternet.com, paul@paul-moore.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Message-ID: <20180301083316.GA6779@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Regression found when running LTP connect01 on next-20180301
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I was running LTP's testcase connect01 [1] and found a regression in linux-next
(next-20180301).  Bisect gave me this patch as the problematic patch (sha
d452930fd3b9 "selinux: Add SCTP support") on a x86 target.

Output from the test(LTP release 20180118):
$ cd /opt/ltp/
$ cat runtest/syscalls |grep connect01>runtest/connect-syscall
$ ./runltp -pq -f connect-syscall
"
Running tests.......
connect01    1  TPASS  :  bad file descriptor successful
connect01    2  TPASS  :  invalid socket buffer successful
connect01    3  TPASS  :  invalid salen successful
connect01    4  TPASS  :  invalid socket successful
connect01    5  TPASS  :  already connected successful
connect01    6  TPASS  :  connection refused successful
connect01    7  TFAIL  :  connect01.c:146: invalid address family ; returned -1 (expected -1), errno 22 (expected 97)
INFO: ltp-pan reported some tests FAIL
LTP Version: 20180118
"

The output from the test expected 97 and we received 22, can you please
elaborate on what have been changed?


Cheers,
Anders
[1] https://github.com/linux-test-project/ltp/blob/20180118/testcases/kernel/syscalls/connect/connect01.c#L146
