Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAIgUSf005288
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 13:42:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAAIg61W024884
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:42:06 GMT
Received: from zurdle.zonnet.net (zurdle.zonnet.net [62.58.50.80])
	by jazzswing.ncsc.mil  with ESMTP id hAAIg55e024874
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:42:05 GMT
Received: from rosso.dwerryhouse.com.au (localhost [127.0.0.1])
	by zurdle.zonnet.net (Postfix) with ESMTP id 68E3D16644
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 19:42:22 +0100 (CET)
Date: Mon, 10 Nov 2003 19:42:21 +0100
From: Paul Dwerryhouse <paul@dwerryhouse.com.au>
To: selinux@tycho.nsa.gov
Subject: Oops in old SELinux + 2.4.21
Message-ID: <20031110184221.GA27862@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi all,

We have a fairly heavily loaded machine running the "old" SELinux, patched
against a vanilla 2.4.21 kernel, which is periodically oopsing and then locking
up. I don't know an awful lot about oops messages, but since it mentions
selinux_d_instantiate in there, I guess it has something to do with
SELinux.

I've printed the oops message below. Anyone have any idea what might be 
causing this?

We're running reiserfs, so moving to the new SELinux would be problematic
at this stage.

Cheers,

Paul


==============================================================================
 Unable to handle kernel NULL pointer dereference at virtual address 00000014
  printing eip:
 c0199e04
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[procfs_set_sid+236/260]    Not tainted
 EFLAGS: 00010286
 eax: 00000000   ebx: 00004567   ecx: dcc72000   edx: 00000001
 esi: ee5e4c61   edi: d6e49a00   ebp: cecdffef   esp: c8e59e40
 ds: 0018   es: 0018   ss: 0018
 Process ps (pid: 17768, stackpage=c8e59000)
 Stack: d6e49a00 00000000 c0255d92 c019a21a cde7aa80 ee5e4c00 ee5e4c30 cde7aa80 
        ee5e4c00 ee5e4c00 d6e49a24 ee5e4c00 cecdf000 c3c70d80 dcc72000 000000da 
        c019e297 cde7aa80 ee5e4c00 c014b4ca ee5e4c00 cde7aa80 cde7aa80 dcc72000 
 Call Trace:    [inode_doinit_with_dentry+1022/1084] [selinux_d_instantiate+19/24] [d_instantiate+42/96] [proc_pid_lookup+436/464] [proc_root_lookup+57/72]
   [real_lookup+122/268] [link_path_walk+748/2508] [path_walk+26/28] [path_lookup+27/36] [open_namei+137/1632] [filp_open+59/92]
   [sys_open+54/156] [system_call+51/56]
 
 Code: 8b 40 14 89 47 14 c6 47 38 01 89 c8 e8 17 6b f9 ff 5b 5e 5f 
==============================================================================
  

-- 
Paul Dwerryhouse						| PGP Key ID: 
Amsterdam, The Netherlands (X) <-> Melbourne, Australia ( )	| 0x6B91B584

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
