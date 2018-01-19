Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0JFo5F6027761
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:50:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID16.oob.disa.mil (Postfix) with SMTP id 3zNQJC4V0wz1P7YG
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 15:50:03 +0000 (UTC)
Received: from USFB3CPA04_EEMSG_MP26.eemsg.mil (unknown [192.168.16.21])
 by USFBF3ID16.oob.disa.mil (Postfix) with ESMTP id 3zNQJC2spgz1P7Y3
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 15:50:03 +0000 (UTC)
Received: by mail-pf0-f182.google.com with SMTP id a88so1626169pfe.12
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 07:50:02 -0800 (PST)
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, stable@vger.kernel.org
References: <20180118215853.228182-1-salyzyn@android.com>
 <CAHC9VhT=tgkKGiQ8CGSw4eBY+crc3iBdkxWGF4M6DoMT4VDGYg@mail.gmail.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <1f185712-9136-be88-02c0-5613a7683619@android.com>
Date: Fri, 19 Jan 2018 07:49:58 -0800
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT=tgkKGiQ8CGSw4eBY+crc3iBdkxWGF4M6DoMT4VDGYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/18/2018 02:36 PM, Paul Moore wrote:
> On Thu, Jan 18, 2018 at 4:58 PM, Mark Salyzyn <salyzyn@android.com> wrote:
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 14233 Comm: syz-executor2 Not tainted 4.4.112-g5f6325b #28
>> . . .
>> [<ffffffff81b6a19d>] selinux_socket_setsockopt+0x4d/0x80 security/selinux/hooks.c:4338
>> [<ffffffff81b4873d>] security_socket_setsockopt+0x7d/0xb0 security/security.c:1257
>> [<ffffffff82df1ac8>] SYSC_setsockopt net/socket.c:1757 [inline]
>> [<ffffffff82df1ac8>] SyS_setsockopt+0xe8/0x250 net/socket.c:1746
>> [<ffffffff83776499>] entry_SYSCALL_64_fastpath+0x16/0x92
>> Code: c2 42 9b b6 81 be 01 00 00 00 48 c7 c7 a0 cb 2b 84 e8
>> f7 2f 6d ff 49 8d 7d 10 48 b8 00 00 00 00 00 fc ff df 48 89
>> fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 01 00
>> 00 41 8b 75 10 31
>> RIP  [<ffffffff81b69b7e>] sock_has_perm+0x1fe/0x3e0 security/selinux/hooks.c:4069
>> RSP <ffff8800b5957ce0>
>> ---[ end trace 7b5aaf788fef6174 ]---
>>
>> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
>> flag") and all the associated infrastructure changes to take advantage
>> of a RCU grace period before freeing, there is a heightened
>> possibility that a security check is performed while an ill-timed
>> setsockopt call races in from user space.  It then is prudent to null
>> check sk_security, and if the case, reject the permissions.
>>
>> This adjustment is orthogonal to infrastructure improvements that may
>> nullify the needed check, but should be added as good code hygiene.
> I'm skeptical that this is the full solution for systems that lack the
> SOCK_RCU_FREE protection.  Is this really limited to just
> setsockopt()?
Maybe overstepped in my analysis and assumptions?

This is a result of a fuzzer hitting an android 4.4 KASAN kernel. We (so 
far) have _not_ seen this with an android 4.9 KASAN kernel (which has 
the SOCK_RCU_FREE adjustments). There is no standalone duplication or 
PoC _except_ via the fuzzer. The rest of the statements stands based on 
this tidbit (statements of general good code hygiene, not 100% sure 
SOCK_RCU_FREE usage is completely covered, KISS solution etc).

To be honest, yes, this may be a layer in the onion (swat this NULL 
check does not by itself solve the _problem_), I'd prefer kernel 
continuing on in a rational manner rather than panic ... and I have a 
gut feeling this could be a gratuitous NULL check if all the bugs in the 
network layer have been solved <that may be sarcasm, I can not tell>. 
Programming to solve a problem with one's gut is not a good practice, 
but hygiene is. This is 10 characters, and an estimated 1.2ns of added 
hygiene.

No, I do not think this is limited to setsockopt, but would be willing 
to believe a multithreaded attack of any socket functions or ioctl would 
drop down to the check with sock_has_perm at possibly the wrong time in 
socket teardown.

Sincerely -- Mark Salyzyn
