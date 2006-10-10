Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AEZ8L5017253
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 10:35:08 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AEXqib017767
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:33:53 GMT
Received: by wx-out-0506.google.com with SMTP id i26so2085229wxd
        for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 07:35:07 -0700 (PDT)
Message-ID: <6a9b0ede0610100735h1a92f4c3i890391f8a0b0238e@mail.gmail.com>
Date: Tue, 10 Oct 2006 20:05:07 +0530
From: "abcde efghi" <svmdcv@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: nfs mount takes long time on x86 rhel4 u4 with selinux enabled
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
In-Reply-To: <6a9b0ede0610100500v4bbe7866v661bb5939446cac2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <6a9b0ede0610100500v4bbe7866v661bb5939446cac2@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi

during installation time it was disabled
and during boottime i enabled it
(.i.e by setting selinux=enforcing in /etc/selinux/config and reboot)
that time it is taking some time to mount
what could be the pbm? is it really bcoz of portmap daemon?
how does portmap daemon cause this pbm? any pointers?

note the time and call trace details:

time mount <server:/disk/disk1/data1/ /mnt --type nfs
-orw,bg,nointr,hard,timeo=600,wsize=32768,rsize=32768,nfsvers=3,tcp,actimeo=0,
addr=10.0.0.60

 real    1m45.006s
 user    0m0.000s
 sys     0m0.017s

 .
 mount         D F8CCB803  2036  4202   4169                     (NOTLB)
 f5c26d04 00000082 00000246 f8ccb803 00000000 f6f2b080 0648da88 f8cccac2
        f8ccb803 00000000 00000000 06051de0 00000000 00000000 a2fd0280
 000f456a
        0231aa80 f744ceb0 f744d01c f6f2b100 02120414 f6f2b080 f6f2b100
 f5c26d30
 Call Trace:
  [<f8ccb803>] xprt_timer+0x0/0x79 [sunrpc]
  [<f8cccac2>] rpc_sleep_on+0x24/0x33 [sunrpc]
  [<f8ccb803>] xprt_timer+0x0/0x79 [sunrpc]
  [<02120414>] prepare_to_wait+0x12/0x4c
  [<f8cccfed>] __rpc_execute+0x1a0/0x326 [sunrpc]
  [<021204e9>] autoremove_wake_function+0x0/0x2d
  [<021204e9>] autoremove_wake_function+0x0/0x2d
  [<021204e9>] autoremove_wake_function+0x0/0x2d
  [<f8cc95de>] rpc_call_sync+0x68/0x8c [sunrpc]
  [<f8cd2b0e>] rpc_register+0xde/0x11b [sunrpc]
  [<022b647f>] inet_addr_type+0x20/0xa6
  [<f8ccf178>] svc_register+0x80/0xd9 [sunrpc]
  [<f8cd1223>] svc_setup_socket+0x88/0x1af [sunrpc]
  [<f8cd143f>] svc_create_socket+0xf5/0x12c [sunrpc]
  [<f8cd1579>] svc_makesock+0x4c/0x53 [sunrpc]
  [<f8a2e002>] lockd_up+0x95/0x13c [lockd]
  [<f8d71868>] nfs_fill_super+0x186/0x2ca [nfs]
  [<022c9864>] __down_failed+0x8/0xc
  [<f8d735d6>] nfs_get_sb+0x1d0/0x203 [nfs]
  [<021601ca>] do_kern_mount+0x8a/0x147
  [<02172eab>] do_new_mount+0x61/0x90
  [<0217352c>] do_mount+0x178/0x190
  [<021557c7>] get_user_size+0x30/0x57
  [<021732d0>] exact_copy_from_user+0x31/0x66
  [<02173883>] sys_mount+0x91/0x108


thanks


 .
On 10/10/06, abcde efghi <svmdcv@gmail.com> wrote:
> hi
>
> nfs mount takes long time on x86 rhel4 u4 with selinux enabled.
> This happens only with selinux enabled. Without selinx it takes few
> milli-seconds.
> When I installed machine with selinux enabled and selinux enabled
> during run,mount works properly.
>
> why is it so?
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
