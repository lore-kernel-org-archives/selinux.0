Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CJEH5Q027639
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 15:14:19 -0400
Received: by mail-lf0-f67.google.com with SMTP id q132so5742386lfe.4
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 11:55:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170912173659.GB5111@julius.enp8s0.d30>
References: <20170912133835.GA5111@julius.enp8s0.d30>
 <CAB9W1A0yYAg3UzwPMo6RVUZEdHDNr3BhjKb=vhvJ4GcmyEA+mw@mail.gmail.com>
 <20170912173659.GB5111@julius.enp8s0.d30>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Sep 2017 14:55:38 -0400
Message-ID: <CAHC9VhSg02C_xd1HnRPkgGvD8WxPQWj3K5+6MpHnZvhHT0vDRA@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: with extended_socket_class should be still be seeing
 "socket"?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 12, 2017 at 1:36 PM, Dominick Grift <dac.override@gmail.com> wrote:
> On Tue, Sep 12, 2017 at 12:01:35PM -0400, Stephen Smalley wrote:
>> On Sep 12, 2017 7:01 AM, "Dominick Grift" <dac.override@gmail.com> wrote:
>>
>> I have extended socket class polcap enabled but i am still seeing "socket"
>> class events and i was wondering whether that is to be expected?
>>
>> avc:  denied  { create } for  pid=10484 comm="nethogs" scontext=wheel.id:
>> sysadm.role:nethogs.subj:s0 tcontext=wheel.id:sysadm.role:nethogs.subj:s0
>> tclass=socket permissive=0
>>
>> This seems to be common to processes that also create (and map! [1])
>> "packet_socket" sockets (tcpdump/nethogs)
>>
>> [1] avc:  denied  { map } for  pid=10525 comm="nethogs"
>> path="socket:[56040]" dev="sockfs" ino=56040
>> scontext=wheel.id:sysadm.role:nethogs.subj:s0
>> tcontext=wheel.id:sysadm.role:nethogs.subj:s0 tclass=packet_socket
>> permissive=0
>>
>>
>> No, that is not expected. Can you enable sys call audit and get those
>> records?
>
> type=PROCTITLE msg=audit(09/12/2017 19:35:54.063:4458) : proctitle=nethogs enp8s0
> type=SYSCALL msg=audit(09/12/2017 19:35:54.063:4458) : arch=x86_64 syscall=socket success=yes exit=5 a0=local a1=SOCK_RAW a2=ip a3=0xb4 items=0 ppid=3251 pid=8963 auid=kcinimod uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts5 ses=1 comm=nethogs exe=/usr/sbin/nethogs subj=wheel.id:sysadm.role:nethogs.subj:s0 key=(null)
> type=AVC msg=audit(09/12/2017 19:35:54.063:4458) : avc:  denied  { create } for  pid=8963 comm=nethogs scontext=wheel.id:sysadm.role:nethogs.subj:s0 tcontext=wheel.id:sysadm.role:nethogs.subj:s0 tclass=socket permissive=1

Ah ha, AF_UNIX/SOCK_RAW, that's the problem.  Luis Ressel fixed this
(see the commit below) and it should make it up to Linus during the
current merge window (eventually, maybe, hopefully).

If you run Fedora Rawhide, you can try one of recent kernel builds in
the COPR repo below, it should have the fix.

*  https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext

  commit 2a764b529ae57bed61da2c90ff132b9fec97f80b
  Author: Luis Ressel <aranea@aixah.de>
  Date:   Tue Jul 25 15:13:41 2017 -0400

   selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets

   For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
   net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.

   Signed-off-by: Luis Ressel <aranea@aixah.de>
   Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
