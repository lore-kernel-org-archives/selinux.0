Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEV03b016413
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:31:00 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEUxZc017705
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:30:59 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/9] LSM: Install the new credentials earlier in the exec
 procedure
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:30:54 +0100
Message-ID: <20110421143054.31318.38952.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Install the new credentials earlier in the exec procedure, immediately after
setup_new_exec() rather than after mapping the executable and interpreter into
the new VM space.

This has the possibility that it will now fail because of security_file_mmap()
disallowing it, though Fedora 13 on my test box still boots okay and the
SELinux testsuite completes okay.

This is in preparation for a subsequent patch whereby the executable file is
reopened in the new context in prepare_binprm()and the interpreter file is
opened with the new context in open_exec().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf.c       |    2 +-
 fs/binfmt_elf_fdpic.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 303983f..5dd78d1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -726,6 +726,7 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
+	install_exec_creds(bprm);
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
@@ -925,7 +926,6 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 	}
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	install_exec_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
 	retval = create_elf_tables(bprm, &loc->elf_ex,
 			  load_addr, interp_load_addr);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 63039ed..a7ddd4e 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -351,6 +351,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 	}
 #endif
 
+	install_exec_creds(bprm);
+
 	/* load the executable and interpreter into memory */
 	retval = elf_fdpic_map_file(&exec_params, bprm->file, current->mm,
 				    "executable");
@@ -413,7 +415,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 	current->mm->start_stack = current->mm->start_brk + stack_size;
 #endif
 
-	install_exec_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
 	if (create_elf_fdpic_tables(bprm, current->mm,
 				    &exec_params, &interp_params) < 0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
