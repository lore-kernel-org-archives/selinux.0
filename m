Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7J9ZlOb005266
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 05:35:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7J9P65A029224
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 09:25:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D99FB61AFE
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 19:26:00 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12820-05 for <selinux@tycho.nsa.gov>;
	Fri, 19 Aug 2005 19:26:00 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 586FD61AFD
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 19:26:00 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   fedora-selinux-list@redhat.com
Subject: kernel Oops from policy
Date: Fri, 19 Aug 2005 19:25:50 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200508191925.55561.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

r_dir_file(insmod_t, debugfs_t)

The above needs to be added to the strict policy to prevent a kernel Oops on 
boot with the usb_uhci driver.  Below is the kernel message log from before I 
added the above to one of my systems.  I only really needed to allow search 
access to the directory, but I decided to allow full read access to the 
directory and any files under it just in case.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=166327

Above is a bugzilla entry.


USB Universal Host Controller Interface driver v2.2
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
audit(1124441960.362:2): avc:  denied  { search } for  pid=958 comm="modprobe" 
n
ame="/" dev=debugfs ino=3962 scontext=system_u:system_r:insmod_t 
tcontext=system_u:object_r:debugfs_t tclass=dir
Unable to handle kernel NULL pointer dereference at virtual address 00000013
 printing eip:
c01e1d48
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: uhci_hcd i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec 
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 
mii flo
ppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
CPU:    0
EIP:    0060:[<c01e1d48>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-1.1398_FC4)
EIP is at debugfs_mknod+0x1b/0x47
eax: ffffffef   ebx: fffffff3   ecx: 00006468   edx: d72ac578
esi: d591ecb0   edi: d6939f6c   ebp: d89e6aca   esp: d6939f3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 958, threadinfo=d6939000 task=d6cf4000)
Stack: d72ac71c c01e1d8f 00000000 d72ac71c c01e1ecf 41ed001c 00000000 000041ed
       00000000 d89e6aca c01e1f4c d6939f6c fffffff3 ffffffed c0000000 d89e9700
       d6939000 c01e1fc4 00000000 00000000 d883603c d89e7108 d6939000 c0000000
Call Trace:
 [<c01e1d8f>] debugfs_mkdir+0x1b/0x28
 [<c01e1ecf>] debugfs_create_by_name+0x91/0xbe
 [<c01e1f4c>] debugfs_create_file+0x50/0xaa
 [<c01e1fc4>] debugfs_create_dir+0x1e/0x22
 [<d883603c>] uhci_hcd_init+0x3c/0xea [uhci_hcd]
 [<c014844c>] sys_init_module+0xca/0x1c4
 [<c0103a51>] syscall_call+0x7/0xb
Code: 00 00 60 12 3d c0 89 d8 83 c4 08 5b 5e 5f 5d c3 53 89 d3 89 ca 8b 4c 24 
08 8b 80 dc 00 00 00 e8 2f ff ff ff 89 c2 b8 ef ff ff ff <8b> 4b 20 85 c9 74 
02 5b c3 b0 ff 85 d2 74 f8 89 d8 e8 a7 84 fb
 <6>ACPI: Power Button (FF) [PWRF]


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
