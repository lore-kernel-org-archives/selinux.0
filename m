Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RL5wrT022960
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 17:05:58 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RL5voM002413
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:05:57 GMT
Subject: Re: more policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200408241937.04958.russell@coker.com.au>
References: <200408241937.04958.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093640718.24188.37.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 17:05:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

In policy/types/file.te, I have made sambafs_t as an alias for cifs_t
instead of the otherway around.


I also, didn't merge the following:

diff -ru /usr/src/se/policy/file_contexts/program/initrc.fc
./file_contexts/program/initrc.fc
--- /usr/src/se/policy/file_contexts/program/initrc.fc  2004-07-15
10:22:53.000000000 +1000
+++ ./file_contexts/program/initrc.fc   2004-07-08 21:22:51.000000000
+1000
@@ -16,5 +16,3 @@
 /usr/sbin/open_init_pty        --      system_u:object_r:initrc_exec_t
 /etc/nologin.*         --      system_u:object_r:etc_runtime_t
 /etc/nohotplug         --      system_u:object_r:etc_runtime_t
-/halt                  --      system_u:object_r:etc_runtime_t
-/\.autofsck            --      system_u:object_r:etc_runtime_t

Why remove these?


On Tue, 2004-08-24 at 05:37, Russell Coker wrote:
> The attached patch removes some more bogus access to devpts_t:chr_file.
> 
> prelink_t is not permitted to create sym-links of type bin_t or lib_t, so it 
> makes no sense to allow it to unlink them AFAIK.  If for some strange reason 
> this is not a silly thing to do then we need a comment in the policy to 
> explain it.
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=120620
> The above URL shows the resolution to the allow procmail_t mqueue_spool_t 
> issue.  The user had stuffed up their procmail configuration.  It is quite 
> fortunate for them that SE Linux revealed this error to them and allowed them 
> to fix it.
> 
> Added a dontaudit in rpcd.te to stop "ls -l /etc" filling the logs with 
> entries about exports_t.
> 
> Removed can_exec_any from xdm.te.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
