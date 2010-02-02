Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12GTapS023826
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 11:29:36 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o12GTcXo025173
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 16:29:39 GMT
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 02 Feb 2010 17:29:32 +0100
Message-Id: <1265128172.3003.17.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

the latest patch for runtime switching of different policy types fails
with:

SELinux: Switching between standard and MLS/MCS policy...
SELinux:  permission module_request in class system not defined in
policy
SELinux: the above unknown classes and permissions will be allowed
BUG: unable to handle kernel NULL pointer dereference at 000002ff
IP: [<c05190d2>] ebitmap_destroy+0x12/0x30
*pde = 00000000 
Oops: 0000 [#1] 
last sysfs file: /sys/devices/virtual/block/dm-2/range
Modules linked in: hangcheck_timer softdog ppdev lp ipv6 microcode ne
8390p ext2 snd_ens1371 snd_seq_midi snd_seq_midi_event snd_rawmidi
snd_ac97_codec ac97_bus snd_pcm snd_seq parport_pc snd_timer
snd_seq_device parport snd floppy soundcore pcspkr snd_page_alloc
i2c_piix4 sr_mod i2c_core cdrom sha256_generic aes_i586 aes_generic

Pid: 2858, comm: load_policy Not tainted (2.6.32.7 #1)  
EIP: 0060:[<c05190d2>] EFLAGS: 00010206 CPU: 0
EIP is at ebitmap_destroy+0x12/0x30
EAX: 000002ff EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: c7097cb8 EDI: c7097ca4 EBP: 00000000 ESP: c7097c60
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process load_policy (pid: 2858, ti=c7097000 task=c736c000
task.ti=c7097000)
Stack:
 00000000 00000000 c0521831 c107bbc0 c048c5ce 00000000 c0803734 c08034f8
<0> 00000020 ffffffff c3dde000 00000020 00000000 00000020 00000202
c219afc0
<0> 00000040 00000000 00000000 00000000 00000000 000001a0 000002ff
c7097ed8
Call Trace:
 [<c0521831>] ? convert_context+0x271/0x350
 [<c048c5ce>] ? __slab_alloc+0x24e/0x540
 [<c0519eb7>] ? sidtab_insert+0xb7/0x1a0
 [<c0520345>] ? security_load_policy+0x265/0x430
 [<c05215c0>] ? convert_context+0x0/0x350
 [<c0519bd0>] ? sidtab_map+0x40/0x70
 [<c05203eb>] ? security_load_policy+0x30b/0x430
 [<c0479c99>] ? __do_fault+0x1f9/0x360
 [<c047a4ba>] ? handle_mm_fault+0x13a/0x550
 [<c041c245>] ? do_page_fault+0xe5/0x2f0
 [<c0404b73>] ? do_IRQ+0x43/0xb0
 [<c041c160>] ? do_page_fault+0x0/0x2f0
 [<c0708506>] ? error_code+0x5e/0x64
 [<c051007b>] ? selinux_inode_rename+0x16b/0x1c0
 [<c051773d>] ? sel_write_load+0xbd/0x630
 [<c047cc4c>] ? vma_link+0x3c/0x50
 [<c0513637>] ? selinux_file_permission+0xe7/0x140
 [<c050a9ac>] ? security_file_permission+0xc/0x10
 [<c0490b24>] ? rw_verify_area+0x64/0xd0
 [<c0517680>] ? sel_write_load+0x0/0x630
 [<c0490c38>] ? vfs_write+0xa8/0x160
 [<c04913a1>] ? sys_write+0x41/0x70
 [<c0402ee4>] ? sysenter_do_call+0x12/0x22
Code: c0 5e c3 8d b6 00 00 00 00 8b 09 eb 9a 8d 74 26 00 5b 31 c0 5e c3
8d 76 00 56 85 c0 53 89 c6 74 22 8b 00 85 c0 75 04 eb 0d 89 d8 <8b> 18
e8 c7 31 f7 ff 85 db 75 f3 c7 46 04 00 00 00 00 c7 06 00 
EIP: [<c05190d2>] ebitmap_destroy+0x12/0x30 SS:ESP 0068:c7097c60
CR2: 00000000000002ff
---[ end trace 17c3aaaa15b3b444 ]---

I suspect, we'd better reintroduce some of my changes so that the
parameter struct policydb is passed when calling
[mls_,o]context_destroy() and sidtab_destroy()... In fact, it seems like
it isn't that safe to always execute mls_context_destroy() even for a
policy which isn't MLS/MCS !

At the end, it wasn't a bad idea to have more general functions (you
never know, in the future we might find them convenient for other
purposes and logically they are more correct, because those function
should be general for any policy, not necessarily the active policy).
You mentioned about the need to change all the family of functions to
accept that extra parameter, I think this is not necessary both from a
logical point of view and a coherency point of view: we can just change
the *context_destroy() and sidtab_destroy() functions and we'll have a
working patch and a more general set of functions.

The test above has been executed on kernel 2.6.32.7 although I am sure
things won't change much with the next branch of the 2.6 security tree.

Please let me know.

Regards,

Guido Trentalancia


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
