Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6C9NAXC024266
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 05:23:11 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6C9OnGn004787
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 09:24:50 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 640D6180F1
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2010 19:22:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: clamav RWX
Date: Mon, 12 Jul 2010 19:22:47 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007121922.48247.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

cli_bytecode_init_jit() in libclamav/c++/bytecode2llvm.cpp in the clamav 
source tree has the following:

    sys::MemoryBlock B = sys::Memory::AllocateRWX(4096, NULL, &ErrMsg);
    if (B.base() == 0) {
        errs() << MODULE << ErrMsg << "\n";
#ifdef __linux__
        errs() << MODULE << "SELinux is preventing 'execmem' access. Run 
'setsebool -P clamd_use_jit on' to allow access\n";
#endif
        errs() << MODULE << "falling back to interpreter mode\n";
        return 0;
    } else {
        sys::Memory::ReleaseRWX(B);
    }

The fact that the developers assumed that SE Linux is the only mechanism that 
prevents RWX access is interesting.

Now the boolean in question only applies to the clamd_t domain not the 
freshclam_t domain, but for some reason freshclam uses the jit anyway.  Should 
we put in a dontaudit rule for freshclam_t or include it in the boolean 
section so that it gets execmem access if clamd_t gets it?

Also on my system the error message about SE Linux doesn't seem to get written 
to the log file, so I only found it by reading the source.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
