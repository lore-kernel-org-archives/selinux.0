Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA28434
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 22:37:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA07605
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 02:35:50 GMT
Received: from mail.servicemail123.com ([12.96.162.84])
        by jazzband.ncsc.mil  with ESMTP id CAA07601 for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 02:35:50 GMT
Received: from jw (unknown [65.166.138.2])
	by mail.servicemail123.com (Postfix on SuSE Linux 7.1 (i386)) with ESMTP id 02E9837F74
	for <selinux@tycho.nsa.gov>; Fri, 31 May 2002 21:37:09 -0500 (CDT)
Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: selinux@tycho.nsa.gov
Subject: How to go about mixing kernel patches...
Date: Fri, 31 May 2002 21:39:56 -0500
MIME-Version: 1.0
Message-Id: <200205312140.02418.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I hope no one minds to mposting this here, if you do, flame away.

My first difficulty it appling the SE Linux patch to the SuSE-patched kernel.

I applied lsm-2.4-2002050211.patch.gz to vanila 2.4.18 and they apply perfectly.

I applied it to linux-2.4.18-SuSE and got some errors, producing the following rejects:

linux-2.4.18.SuSE/fs/dquot.c.rej
linux-2.4.18.SuSE/fs/namei.c.rej
linux-2.4.18.SuSE/fs/inode.c.rej
linux-2.4.18.SuSE/mm/memory.c.rej
linux-2.4.18.SuSE/mm/mprotect.c.rej
linux-2.4.18.SuSE/mm/filemap.c.rej
linux-2.4.18.SuSE/net/socket.c.rej
linux-2.4.18.SuSE/arch/i386/kernel/entry.S.rej
linux-2.4.18.SuSE/arch/ia64/kernel/entry.S.rej
linux-2.4.18.SuSE/init/main.c.rej
linux-2.4.18.SuSE/kernel/fork.c.rej
linux-2.4.18.SuSE/kernel/sched.c.rej
linux-2.4.18.SuSE/Makefile.rej
linux-2.4.18.SuSE/include/linux/fs.h.rej

Or if this helps any:

jw:/work/dl/se_linux/se_build/linux-2.4.18.SuSE # zcat ../../opt5/all-opt-4-together/patches/lsm-2.4-2002050211.patch.gz | patch -s -p1
1 out of 3 hunks FAILED -- saving rejects to file Makefile.rej
1 out of 1 hunk FAILED -- saving rejects to file arch/i386/kernel/entry.S.rej
1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/kernel/entry.S.rej
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
1 out of 1 hunk ignored -- saving rejects to file fs/binfmt_elf.c.rej
1 out of 2 hunks FAILED -- saving rejects to file fs/dquot.c.rej
1 out of 3 hunks FAILED -- saving rejects to file fs/inode.c.rej
1 out of 22 hunks FAILED -- saving rejects to file fs/namei.c.rej
1 out of 6 hunks FAILED -- saving rejects to file include/linux/fs.h.rej
1 out of 2 hunks FAILED -- saving rejects to file init/main.c.rej
1 out of 4 hunks FAILED -- saving rejects to file kernel/fork.c.rej
1 out of 7 hunks FAILED -- saving rejects to file kernel/sched.c.rej
1 out of 3 hunks FAILED -- saving rejects to file mm/filemap.c.rej
1 out of 1 hunk FAILED -- saving rejects to file mm/memory.c.rej
1 out of 2 hunks FAILED -- saving rejects to file mm/mprotect.c.rej
1 out of 15 hunks FAILED -- saving rejects to file net/socket.c.rej


At this point I'm presuming the the correct course of action is to diff those files one at a time between the "good" patched {.c|.h} files and the "bad" suse-patched {.c|.h} files.

Would there be any benefit to try to do the opposite, i.e. apply the LSM patches first, and the SuSE patches second?

I'm a little worried since I have to mix 3 patches actually. I suppose there's not much chance of the actual se-linux patches applying to my mixed lsm/suse kernel?

Sorry to ask such basic questions, I've never had to do something like this before -- but I'm detirmined to do it right.

If any one has advise as far as how to go about this, I'd really appreciate hearing from you.

Thanks!

- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8+DQCQ5u80xXOLBcRAoBCAKC7v3Ta7boFkXltryIjtOj1wohx5ACfesN3
LLlU60flwIRnTs4Ylkon2RU=
=ALT7
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
