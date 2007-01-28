Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TK9Stf029170
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:09:28 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TKATF5018046
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 20:10:29 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l0TK5CHc005320
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:05:12 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l0TK5Cuq005319
	for selinux@tycho.nsa.gov; Mon, 29 Jan 2007 15:05:12 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, jmorris@namei.org
Subject: [PATCH] sysctl selinux: Don't look at table->de
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net>
	<20070127172410.2b041952.akpm@osdl.org>
	<1169972718.17469.164.camel@localhost.localdomain>
	<20070128003549.2ca38dc8.akpm@osdl.org>
	<20070128093358.GA2071@elte.hu> <20070128095712.GA6485@elte.hu>
	<20070128100627.GA8416@elte.hu>
	<20070128104548.a835d859.akpm@osdl.org>
Date: Sun, 28 Jan 2007 12:21:24 -0700
In-Reply-To: <20070128104548.a835d859.akpm@osdl.org> (Andrew Morton's message
	of "Sun, 28 Jan 2007 10:45:48 -0800")
Message-ID: <m1r6tfq7nv.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


With the sysctl cleanups sysctl is not really a part of proc
it just shows up there, and any path based approach will not
adequately describe the data as sysctl is essentially a
union mount underneath the covers.  As designed this mechanism
is viewer dependent so trying to be path based gets even worse.

However the permissions in sys_sysctl are currently immutable
and going through proc does not change the permission checks
when accessing sysctl.  So we might as well stick with the well
defined sysctl sid, as that is what selinux uses when proc is
not compiled in.

I.e.  I see no hope for salvaging the selinux_proc_get_sid call
in selinux_sysctl so I'm removing it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 security/selinux/hooks.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b38372..3a36057 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1438,12 +1438,8 @@ static int selinux_sysctl(ctl_table *table, int op)
 
 	tsec = current->security;
 
-	rc = selinux_proc_get_sid(table->de, (op == 001) ?
-	                          SECCLASS_DIR : SECCLASS_FILE, &tsid);
-	if (rc) {
-		/* Default to the well-defined sysctl SID. */
-		tsid = SECINITSID_SYSCTL;
-	}
+	/* Use the well-defined sysctl SID. */
+	tsid = SECINITSID_SYSCTL;
 
 	/* The op values are "defined" in sysctl.c, thereby creating
 	 * a bad coupling between this module and sysctl.c */
-- 
1.4.4.1.g278f

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
