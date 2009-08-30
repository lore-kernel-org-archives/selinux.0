Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7UFWbm3018141
	for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 11:32:37 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7UFW0Wh007115
	for <selinux@tycho.nsa.gov>; Sun, 30 Aug 2009 15:32:00 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 543915-forwarded@bugs.debian.org, Max Kellermann <max@duempel.org>
Subject: [libsepol] Unchecked input leades to integer underflow
Date: Sun, 30 Aug 2009 10:19:33 -0500
Message-ID: <878wh1jpmi.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        This bug was discovered, and the analysis done, buy Max
 Kellermann. I have never been able to replicate the problem, so I can't
 help debug this error.

 Strace:
--8<---------------cut here---------------start------------->8---
brk(0x3233000)                          = 0x3233000
mmap(NULL, 18446744073703178240, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)
mmap(NULL, 18446744073703313408, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)
mmap(NULL, 134217728, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x7fdfda316000
--8<---------------cut here---------------end--------------->8---

> 0xffffffffff9ec000 == 18446744073703178240 (the size of the first
> large allocation).  It's also equal to -6373376.  This just looks like
> an integer underflow, doesn't it?

--8<---------------cut here---------------start------------->8---
 Breakpoint 4, 0x00007f9bc4c05400 in mmap64 () from /lib/libc.so.6
 (gdb) p $rsi
 $25 = -6373376
 (gdb) bt
 #0  0x00007f9bc4c05400 in mmap64 () from /lib/libc.so.6
 #1  0x00007f9bc4baf6bb in _int_malloc () from /lib/libc.so.6
 #2  0x00007f9bc4bb0a78 in malloc () from /lib/libc.so.6
 #3  0x00007f9bc5301a8e in sepol_module_package_read (mod=0xb1d170, spf=0xb202e0, verbose=0) at module.c:533
 #4  0x00007f9bc4ea7838 in ?? () from /lib/libsemanage.so.1

 (gdb) frame 3
 #3  0x00007f9bc5301a8e in sepol_module_package_read (mod=0xb1d170, spf=0xb202e0, verbose=0) at module.c:533
 533     module.c: No such file or directory.
         in module.c
 (gdb) p len
 $26 = 18446744073703176358
 (gdb) p i
 $27 = 3
 (gdb) p nsec
 $30 = 4
 (gdb) p offsets[i+1] 
 $28 = 8192
 (gdb) p offsets[i]
 $29 = 6383450
--8<---------------cut here---------------end--------------->8---

> line 456:
> len = offsets[i + 1] - offsets[i];

> Voila, integer underflow.  The function module_package_read_offsets()
> reads the offsets from the input file, but does not verify them.
>         off[nsec] = policy_file_length(file);
> Here, the check is missing.

        We should probably have:
--8<---------------cut here---------------start------------->8---
	off[nsec] = policy_file_length(file);
        if (off[nsec] < off[nsec-1]) {
		ERR(file->handle, "file size smaller than previous offset (at %u, "
		    "offset %zu -> %zu", nsec, off[nsec - 1],
		    off[nsec]);
		return -1;
	}
--8<---------------cut here---------------end--------------->8---

> But why is the file length 8192?  My base.pp has 6383597 bytes
> (compressed), not 8192.  Let's break in policy_file_length():

--8<---------------cut here---------------start------------->8---
 (gdb) p prev_offset 
 $4 = 28
 (gdb) p end_offset 
 $5 = 8192
 (gdb) p fp->fp
 $6 = (FILE *) 0x1c42350
 $7 = -1
--8<---------------cut here---------------end--------------->8---

> But why is the file descriptor negative?  sepol_module_package_read()
> is called by semanage_load_module(), which bunzips the file, closes
> it, reopens it with fmemopen().

        I don't understand this part. Upon successful completion
 fmemopen() returns a FILE pointer.  Otherwise, NULL is returned, and
 that is checked for in In semanage_store.c:
--8<---------------cut here---------------start------------->8---
	ssize_t size;
	char *data = NULL;

	if ((size = bunzip(sh, fp, &data)) > 0) {
		fclose(fp);
		fp = fmemopen(data, size, "rb");
		if (!fp) {
			ERR(sh, "Out of memory!");
			goto cleanup;
		}
	}
--8<---------------cut here---------------end--------------->8---

         According to the man page, ever since glibc 2.9, the letter 'b'
 may be specified as the second character in mode.  This provides
 "binary" mode: writes don't implicitly add a terminating null byte, and
 fseek(3) SEEK_END is relative to the end of the buffer (i.e., the value
 specified by the size argument), rather than the current string length.

        Anyway, I think that adding a defensive check when we set
 off[nsec] seems to be in order, and would not harm anything; and would
 have prevented the huge memory allocation issue, and perhaps given a
 better error message.

        manoj

-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
