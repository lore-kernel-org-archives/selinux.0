Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l44JdnKs029647
	for <selinux@tycho.nsa.gov>; Fri, 4 May 2007 15:39:49 -0400
Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single
	program
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 May 2007 15:39:47 -0400
Message-Id: <1178307587.677.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 15:19 -0400, Stephen Smalley wrote:
> restorecon started life as a much simpler program, but has gradually
> grown to being largely a duplicate of setfiles, only differing in its
> interface and default behaviors.  Meanwhile, people keep adding features
> and options to both programs, leading to inconsistencies.
> 
> This patch coalesces setfiles and restorecon into a single program
> presenting different interfaces and default behaviors depending on
> basename(argv[0]), making restorecon a symlink to setfiles.
> 
> Unresolved issue: Current policy defines separate domains for the two
> programs.  We need to either coalesce the domains as well, or if there
> is legitimate reason for separating them, restorecon could remain a
> separate binary (either a complete separate copy or a wrapper) even if
> the sources are coalesced.
> 
> Comments?
> 

Grr...bug fix patch below, applies on top of the original one.

diff -u trunk/policycoreutils/setfiles/setfiles.c trunk/policycoreutils/setfiles/setfiles.c
--- trunk/policycoreutils/setfiles/setfiles.c	(working copy)
+++ trunk/policycoreutils/setfiles/setfiles.c	(working copy)
@@ -541,6 +541,7 @@
 			exit(0);
 		}
 		/* Parent:  Check and label the files. */
+		rc = 0;
 		close(pipe_fds[1]);
 		if (nftw(name, apply_spec, 1024, nftw_flags)) {
 			fprintf(stderr,

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
