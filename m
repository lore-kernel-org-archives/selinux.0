Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4BFCfFt015246
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 11:12:41 -0400
Received: by yhjj72 with SMTP id j72so3012373yhj.12
        for <selinux@tycho.nsa.gov>; Fri, 11 May 2012 08:12:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FAD2219.6090603@schaufler-ca.com>
References: <CAHx7xgW22yYYEgDR=tqomoS3AEOOwOc351d0+1WZNnbsv1rYVA@mail.gmail.com>
	<4FAD2219.6090603@schaufler-ca.com>
Date: Fri, 11 May 2012 19:12:42 +0400
Message-ID: <CAHx7xgVkBK8wOTLuFSAFOe93ym_uR6UU2W3XHGgxS6fEqr2hTg@mail.gmail.com>
Subject: Re: labeled NFS
From: zyxel <zyx1984@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8fb20228fb13a204bfc42a0c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8fb20228fb13a204bfc42a0c
Content-Type: text/plain; charset=ISO-8859-1

dmesg output are listed here:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SELinux: initialized (dev nfsd, type nfsd), uses genfs_contexts
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
Slow work thread pool: Starting up
Slow work thread pool: Ready
FS-Cache: Loaded
FS-Cache: Netfs 'nfs' registered for caching
SELinux: initialized (dev 0:17, type nfs4), uses native labeling
BUG: unable to handle kernel NULL pointer dereference at 0000000000000204
IP: [<ffffffffa03512b8>] nfs4_remote_get_sb+0x148/0x330 [nfs]
PGD 0
Oops: 0000 [#1] SMP
last sysfs file: /sys/devices/virtual/block/dm-0/dev
CPU 0
Modules linked in: nfs fscache nfsd lockd nfs_acl auth_rpcgss exportfs fuse
autofs4 sunrpc ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter
ip_tables ip6t_REJECT nf_conntrack_ipv6 xt_state nf_conntrack
ip6table_filter ip6_tables ipv6 dm_mirror dm_region_hash dm_log uinput
floppy microcode virtio_balloon virtio_net pcspkr snd_hda_intel
snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd
soundcore snd_page_alloc i2c_piix4 i2c_core ext4 mbcache jbd2 virtio_blk
virtio_pci virtio_ring virtio pata_acpi ata_generic ata_piix dm_mod [last
unloaded: speedstep_lib]
Pid: 2191, comm: mount.nfs4 Not tainted 2.6.32NFS_TEST #1 KVM
RIP: 0010:[<ffffffffa03512b8>]  [<ffffffffa03512b8>]
nfs4_remote_get_sb+0x148/0x330 [nfs]
RSP: 0018:ffff88003bae3c48  EFLAGS: 00010287
RAX: ffff880026a013c0 RBX: ffff88003c635800 RCX: 0000000000000004
RDX: 0000000000000004 RSI: ffff880026a013c0 RDI: ffff880026a2bdb8
RBP: ffff88003bae3cb8 R08: ffff880026a2bde8 R09: ffff880026a013c0
R10: 000000010002214a R11: 0000000000000001 R12: ffff88003ba03480
R13: ffff88003f8701c0 R14: 0000000000000000 R15: ffff88003be0c000
FS:  00007f59127a3700(0000) GS:ffff880001e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000204 CR3: 000000003ba5f000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process mount.nfs4 (pid: 2191, threadinfo ffff88003bae2000, task
ffff880037758aa0)
Stack:
 00000000000000d0 ffff88003b06da80 ffff88003b06da80 ffff880021c55b40
 <0> ffff88003a15cc00 0000000000000000 ffff88003bae3c88 0000000000000000
 <0> ffff88003bae3cb8 ffff88003b06da80 ffffffffa03870a0 0000000000000000
 Call Trace:
  [<ffffffff8115186b>] vfs_kern_mount+0x7b/0x1b0
   [<ffffffffa0350c2f>] nfs_do_root_mount+0x7f/0xb0 [nfs]
    [<ffffffffa0350d72>] nfs4_try_mount+0x52/0xd0 [nfs]
     [<ffffffffa0351652>] nfs4_get_sb+0xa2/0x340 [nfs]
      [<ffffffff8115186b>] vfs_kern_mount+0x7b/0x1b0
       [<ffffffff81151a12>] do_kern_mount+0x52/0x130
        [<ffffffff8116eda7>] do_mount+0x2e7/0x840
         [<ffffffff8116c8f2>] ? copy_mount_options+0xf2/0x1a0
          [<ffffffff8116f390>] sys_mount+0x90/0xe0
           [<ffffffff81013072>] system_call_fastpath+0x16/0x1b
           Code: f7 45 31 f6 e8 0a 2a ff ff 49 83 7f 68 00 0f 84 4a 01 00
00 4c 89 e6 4c 89 ff e8 84 9c ff ff 48 3d 00 f0 ff ff 0f 87 b9 01 00 00
<41> 8b 96 04 02 00 00 4c 8d ab 90 01 00 00 48 8d 4d c8 4c 89 ff
           RIP  [<ffffffffa03512b8>] nfs4_remote_get_sb+0x148/0x330 [nfs]
            RSP <ffff88003bae3c48>
            CR2: 0000000000000204
            ---[ end trace 2ef321f85929034b ]---


I noticed that this error comes out when mounting the same nfs share on
client without nosharecache option, but I can't understand why.
So if I mount
 #mount -t nfs4 -o nosharecache server:/ /mnt/nfsv4
and then
 #mount -t nfs4 -o nosharecache server:/ /mnt/nfsv4_2
everything works fine.

For now I have one more question: could I use netlabel for my task to
prevent access to NFS shared files for processes with lower security level?
I found not enough information about netlabel and how to configure it.
Maybe it may help me. Or it can't be done and I must use labeled NFS
instead.

2012/5/11 Casey Schaufler <casey@schaufler-ca.com>

>  On 5/11/2012 4:05 AM, zyxel wrote:
>
> Hello.
>
> I have some questions about labeled NFS.
> We have client and server systems running RHEL 6.1
> Kernels for both client and server were downloaded from git://
> git.selinuxproject.org/~dpquigl/lnfs<http://git.selinuxproject.org/%7Edpquigl/lnfs>
> Kernel version is 2.6.32. and they are already patched to support labeled
> NFS.
> Server is configured to export NFS share. Nfs-utils on server are patched
> for labeled nfs too.
>
> Here is listing for server exports file:
> /export *(rw,fsid=0,sec=unix,insecure,no_subtree_check,sync,security_label)
>
> Client and server have the same MLS policy.
>
> If I mount NFS share with command
>  #mount -t nfs4 server:/ /mnt/nfsv4
> everything works good, but when i try to mount the same share to another
> directory
>  #mount -t nfs4 server:/ /mnt/nfsv4_2
> it fails with:
>
> Message from syslogd@localhost at May 11 13:07:17 ...
> kernel:Oops: 0000 [#1] SMP
>
> Message from syslogd@localhost at May 11 13:07:17 ...
> kernel:last sysfs file: /sys/devices/virtual/block/dm-0/dev
>
> Message from syslogd@localhost at May 11 13:07:17 ...
> kernel:Stack:
>
>
> An "Oops" indicates that a component of the kernel had a fatal
> error, but that it only affected the current process or device
> and the kernel was able to continue otherwise.
>
> Use dmesg to see the kernel log. Any number of issues, from
> misconfiguration to just plain bad code could have caused your
> problem. There is not enough information in your email to do
> much diagnosis.
>
>
>
> Why does it happens? Where I can get more information about that.
>
> The second question is that maybe I don't need labeled NFS.
> My task is to transfer security levels between client and server over NFS
> so that client with security level s0, for example, couldn't get access to
> file with level s1 on NFS share.
> I don't know if it may be done with netlabel or something.
> Could you help me a bit.
>
> Andrei
>
>
>

--e89a8fb20228fb13a204bfc42a0c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

dmesg output are listed here:<br><br>Installing knfsd (copyright (C) 1996 <=
a href=3D"mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<br>SELinux: ini=
tialized (dev nfsd, type nfsd), uses genfs_contexts<br>NFSD: Using /var/lib=
/nfs/v4recovery as the NFSv4 state recovery directory<br>
NFSD: starting 90-second grace period<br>Slow work thread pool: Starting up=
<br>Slow work thread pool: Ready<br>FS-Cache: Loaded<br>FS-Cache: Netfs &#3=
9;nfs&#39; registered for caching<br>SELinux: initialized (dev 0:17, type n=
fs4), uses native labeling<br>
BUG: unable to handle kernel NULL pointer dereference at 0000000000000204<b=
r>IP: [&lt;ffffffffa03512b8&gt;] nfs4_remote_get_sb+0x148/0x330 [nfs]<br>PG=
D 0 <br>Oops: 0000 [#1] SMP <br>last sysfs file: /sys/devices/virtual/block=
/dm-0/dev<br>
CPU 0 <br>Modules linked in: nfs fscache nfsd lockd nfs_acl auth_rpcgss exp=
ortfs fuse autofs4 sunrpc ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 iptab=
le_filter ip_tables ip6t_REJECT nf_conntrack_ipv6 xt_state nf_conntrack ip6=
table_filter ip6_tables ipv6 dm_mirror dm_region_hash dm_log uinput floppy =
microcode virtio_balloon virtio_net pcspkr snd_hda_intel snd_hda_codec snd_=
hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc=
 i2c_piix4 i2c_core ext4 mbcache jbd2 virtio_blk virtio_pci virtio_ring vir=
tio pata_acpi ata_generic ata_piix dm_mod [last unloaded: speedstep_lib]<br=
>
Pid: 2191, comm: mount.nfs4 Not tainted 2.6.32NFS_TEST #1 KVM<br>RIP: 0010:=
[&lt;ffffffffa03512b8&gt;]=A0 [&lt;ffffffffa03512b8&gt;] nfs4_remote_get_sb=
+0x148/0x330 [nfs]<br>RSP: 0018:ffff88003bae3c48=A0 EFLAGS: 00010287<br>RAX=
: ffff880026a013c0 RBX: ffff88003c635800 RCX: 0000000000000004<br>
RDX: 0000000000000004 RSI: ffff880026a013c0 RDI: ffff880026a2bdb8<br>RBP: f=
fff88003bae3cb8 R08: ffff880026a2bde8 R09: ffff880026a013c0<br>R10: 0000000=
10002214a R11: 0000000000000001 R12: ffff88003ba03480<br>R13: ffff88003f870=
1c0 R14: 0000000000000000 R15: ffff88003be0c000<br>
FS:=A0 00007f59127a3700(0000) GS:ffff880001e00000(0000) knlGS:0000000000000=
000<br>CS:=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003b<br>CR2: 00000000=
00000204 CR3: 000000003ba5f000 CR4: 00000000000006f0<br>DR0: 00000000000000=
00 DR1: 0000000000000000 DR2: 0000000000000000<br>
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400<br>Proces=
s mount.nfs4 (pid: 2191, threadinfo ffff88003bae2000, task ffff880037758aa0=
)<br>Stack:<br>=A000000000000000d0 ffff88003b06da80 ffff88003b06da80 ffff88=
0021c55b40<br>
=A0&lt;0&gt; ffff88003a15cc00 0000000000000000 ffff88003bae3c88 00000000000=
00000<br>=A0&lt;0&gt; ffff88003bae3cb8 ffff88003b06da80 ffffffffa03870a0 00=
00000000000000<br>=A0Call Trace:<br>=A0 [&lt;ffffffff8115186b&gt;] vfs_kern=
_mount+0x7b/0x1b0<br>
=A0=A0 [&lt;ffffffffa0350c2f&gt;] nfs_do_root_mount+0x7f/0xb0 [nfs]<br>=A0=
=A0=A0 [&lt;ffffffffa0350d72&gt;] nfs4_try_mount+0x52/0xd0 [nfs]<br>=A0=A0=
=A0=A0 [&lt;ffffffffa0351652&gt;] nfs4_get_sb+0xa2/0x340 [nfs]<br>=A0=A0=A0=
=A0=A0 [&lt;ffffffff8115186b&gt;] vfs_kern_mount+0x7b/0x1b0<br>
=A0=A0=A0=A0=A0=A0 [&lt;ffffffff81151a12&gt;] do_kern_mount+0x52/0x130<br>=
=A0=A0=A0=A0=A0=A0=A0 [&lt;ffffffff8116eda7&gt;] do_mount+0x2e7/0x840<br>=
=A0=A0=A0=A0=A0=A0=A0=A0 [&lt;ffffffff8116c8f2&gt;] ? copy_mount_options+0x=
f2/0x1a0<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0 [&lt;ffffffff8116f390&gt;] sys_moun=
t+0x90/0xe0<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [&lt;ffffffff81013072&gt;] system_call_fastp=
ath+0x16/0x1b<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Code: f7 45 31 f6 e8 0a 2a =
ff ff 49 83 7f 68 00 0f 84 4a 01 00 00 4c 89 e6 4c 89 ff e8 84 9c ff ff 48 =
3d 00 f0 ff ff 0f 87 b9 01 00 00 &lt;41&gt; 8b 96 04 02 00 00 4c 8d ab 90 0=
1 00 00 48 8d 4d c8 4c 89 ff <br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RIP=A0 [&lt;ffffffffa03512b8&gt;] nfs4_remot=
e_get_sb+0x148/0x330 [nfs]<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RSP &lt;fff=
f88003bae3c48&gt;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CR2: 000000000000020=
4<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ---[ end trace 2ef321f85929034b ]---=
<br><br><br>
I noticed that this error comes out when mounting the same nfs share on cli=
ent without nosharecache option, but I can&#39;t understand why.<br>So if I=
 mount <br>=A0#mount -t nfs4 -o nosharecache server:/ /mnt/nfsv4<br>
      and then <br>
      =A0#mount -t nfs4 -o nosharecache server:/ /mnt/nfsv4_2<br>everything=
 works fine.<br><br>For now I have one more question: could I use netlabel =
for my task to prevent access to NFS shared files for processes with lower =
security level?<br>
I found not enough information about netlabel and how to configure it. Mayb=
e it may help me. Or it can&#39;t be done and I must use labeled NFS instea=
d.<br><br><div class=3D"gmail_quote">2012/5/11 Casey Schaufler <span dir=3D=
"ltr">&lt;<a href=3D"mailto:casey@schaufler-ca.com" target=3D"_blank">casey=
@schaufler-ca.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000"><div class=3D"im">
    On 5/11/2012 4:05 AM, zyxel wrote:
    <blockquote type=3D"cite">Hello. <br>
      <br>
      I have some questions about labeled NFS.<br>
      We have client and server systems running RHEL 6.1<br>
      Kernels for both client and server were downloaded from git://<a href=
=3D"http://git.selinuxproject.org/%7Edpquigl/lnfs" target=3D"_blank">git.se=
linuxproject.org/~dpquigl/lnfs</a><br>
      Kernel version is 2.6.32. and they are already patched to support
      labeled NFS.<br>
      Server is configured to export NFS share. Nfs-utils on server are
      patched for labeled nfs too.<br>
      <br>
      Here is listing for server exports file:<br>
      /export
      *(rw,fsid=3D0,sec=3Dunix,insecure,no_subtree_check,sync,security_labe=
l)<br>
      <br>
      Client and server have the same MLS policy.<br>
      <br>
      If I mount NFS share with command<br>
      =A0#mount -t nfs4 server:/ /mnt/nfsv4<br>
      everything works good, but when i try to mount the same share to
      another directory<br>
      =A0#mount -t nfs4 server:/ /mnt/nfsv4_2<br>
      it fails with:<br>
      <br>
      Message from syslogd@localhost at May 11 13:07:17 ...<br>
      kernel:Oops: 0000 [#1] SMP <br>
      =A0<br>
      Message from syslogd@localhost at May 11 13:07:17 ...<br>
      kernel:last sysfs file: /sys/devices/virtual/block/dm-0/dev<br>
      =A0 <br>
      Message from syslogd@localhost at May 11 13:07:17 ...<br>
      kernel:Stack:<br>
    </blockquote>
    </div><tt><br>
      An &quot;Oops&quot; indicates that a component of the kernel had a fa=
tal<br>
      error, but that it only affected the current process or device<br>
      and the kernel was able to continue otherwise.<br>
      <br>
      Use dmesg to see the kernel log. Any number of issues, from<br>
      misconfiguration to just plain bad code could have caused your<br>
      problem. There is not enough information in your email to do<br>
      much diagnosis.<br>
      <br>
      <br>
    </tt><div class=3D"im">
    <blockquote type=3D"cite"><br>
      Why does it happens? Where I can get more information about that.<br>
      <br>
      The second question is that maybe I don&#39;t need labeled NFS.<br>
      My task is to transfer security levels between client and server
      over NFS<br>
      so that client with security level s0, for example, couldn&#39;t get
      access to file with level s1 on NFS share.<br>
      I don&#39;t know if it may be done with netlabel or something.<br>
      Could you help me a bit.<br>
      <br>
      Andrei<br>
    </blockquote>
    <br>
  </div></div>

</blockquote></div><br>

--e89a8fb20228fb13a204bfc42a0c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
