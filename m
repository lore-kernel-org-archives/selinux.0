Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vATJU1Us007863
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 14:30:02 -0500
Received: by mail-lf0-f65.google.com with SMTP id e137so5191780lfg.5
 for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2017 11:29:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANn89iJc=tZkN41WoCm5Zy9nPfs1tfZf9nuSXYS9EB_aem+y4g@mail.gmail.com>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <1511976706.10464.19.camel@tycho.nsa.gov>
 <CANn89iJc=tZkN41WoCm5Zy9nPfs1tfZf9nuSXYS9EB_aem+y4g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Nov 2017 14:29:57 -0500
Message-ID: <CAHC9VhSw5N4h0ODqVkMVbxXg9Jiu5O8WLNiJtdYHO2xR_Eu-fw@mail.gmail.com>
To: James Morris <james.l.morris@oracle.com>,
 Eric Dumazet <edumazet@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, netdev <netdev@vger.kernel.org>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 29, 2017 at 12:34 PM, Eric Dumazet <edumazet@google.com> wrote:
> On Wed, Nov 29, 2017 at 9:31 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Wed, 2017-11-29 at 21:26 +1100, James Morris wrote:
>>> I'm seeing a kernel stack corruption bug (detected via gcc) when
>>> running
>>> the SELinux testsuite on a 4.15-rc1 kernel, in the 2nd inet_socket
>>> test:
>>>
>>> https://github.com/SELinuxProject/selinux-testsuite/blob/master/tests
>>> /inet_socket/test
>>>
>>>   # Verify that unauthorized client cannot communicate with the
>>> server.
>>>   $result = system
>>>   "runcon -t test_inet_bad_client_t -- $basedir/client stream
>>> 127.0.0.1 65535 2>&1";
>>>
>>> This correctlly causes an access control error in the Netlabel code,
>>> and
>>> the bug seems to be triggered during the ICMP send:
>>>
>>> [  339.806024] SELinux: failure in selinux_parse_skb(), unable to
>>> parse packet
>>> [  339.822505] Kernel panic - not syncing: stack-protector: Kernel
>>> stack is corrupted in: ffffffff81745af5
>>> [  339.822505]
>>> [  339.852250] CPU: 4 PID: 3642 Comm: client Not tainted 4.15.0-rc1-
>>> test #15
>>> [  339.868498] Hardware name: LENOVO 10FGS0VA1L/30BC, BIOS
>>> FWKT68A   01/19/2017
>>> [  339.885060] Call Trace:
>>> [  339.896875]  <IRQ>
>>> [  339.908103]  dump_stack+0x63/0x87
>>> [  339.920645]  panic+0xe8/0x248
>>> [  339.932668]  ? ip_push_pending_frames+0x33/0x40
>>> [  339.946328]  ? icmp_send+0x525/0x530
>>> [  339.958861]  ? kfree_skbmem+0x60/0x70
>>> [  339.971431]  __stack_chk_fail+0x1b/0x20
>>> [  339.984049]  icmp_send+0x525/0x530

...

>>> This is mostly reliable, and I'm only seeing it on bare metal (not in
>>> a
>>> virtualbox vm).
>>>
>>> The SELinux skb parse error at the start only sometimes appears, and
>>> looking at the code, I suspect some kind of memory corruption being
>>> the
>>> cause at that point (basic packet header checks).
>>>
>>> I bisected the bug down to the following change:
>>>
>>> commit bffa72cf7f9df842f0016ba03586039296b4caaf
>>> Author: Eric Dumazet <edumazet@google.com>
>>> Date:   Tue Sep 19 05:14:24 2017 -0700
>>>
>>>     net: sk_buff rbnode reorg
>>>     ...
>>>
>>>
>>> Anyone else able to reproduce this, or have any ideas on what's
>>> happening?
>>
>> So far I haven't been able to reproduce with 4.15-rc1 or -linus.
>
> You might try adding KASAN in the picture ? ( CONFIG_KASAN=y )

As another data point, I have not hit this problem either, but I'm not
currently building my test kernels with KASAN enabled.

-- 
paul moore
www.paul-moore.com
