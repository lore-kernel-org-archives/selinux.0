From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Subject: [PATCH 2/5] sysctl: Set the parent field in the root sysctl table
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net>
	<20070127172410.2b041952.akpm@osdl.org>
	<1169972718.17469.164.camel@localhost.localdomain>
	<20070128003549.2ca38dc8.akpm@osdl.org>
	<20070128093358.GA2071@elte.hu> <20070128095712.GA6485@elte.hu>
	<20070128100627.GA8416@elte.hu>
	<20070128104548.a835d859.akpm@osdl.org>
	<m1r6tfq7nv.fsf_-_@ebiederm.dsl.xmission.com>
	<1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil>
	<m17iuvrnpk.fsf_-_@ebiederm.dsl.xmission.com>
	<m13b5jrngt.fsf_-_@ebiederm.dsl.xmission.com>
	<1170872654.11912.87.camel@moss-spartans.epoch.ncsc.mil>
	<1170882738.11912.144.camel@moss-spartans.epoch.ncsc.mil>
	<m17iutmmwh.fsf@ebiederm.dsl.xmission.com>
	<1170946871.11912.250.camel@moss-spartans.epoch.ncsc.mil>
	<m14ppwa64j.fsf@ebiederm.dsl.xmission.com>
	<1170958404.11912.313.camel@moss-spartans.epoch.ncsc.mil>
	<m1mz3o8fbf.fsf@ebiederm.dsl.xmission.com>
	<m1abzo8dr0.fsf_-_@ebiederm.dsl.xmission.com>
	<m164ac8dnv.fsf_-_@ebiederm.dsl.xmission.com>
Date: Thu, 08 Feb 2007 15:54:35 -0700
In-Reply-To: <m164ac8dnv.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Thu, 08 Feb 2007 15:53:08 -0700")
Message-ID: <m11wl08dlg.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Oops I goofed and forgot to set the parent in the root sysctl table,
the rest are covered by register_sysctl_table.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/sysctl.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d3a84fc..aa7d69e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1296,6 +1296,14 @@ static void sysctl_set_parent(struct ctl_table *parent, struct ctl_table *table)
 	}
 }
 
+static __init int sysctl_init(void)
+{
+	sysctl_set_parent(NULL, root_table);
+	return 0;
+}
+
+core_initcall(sysctl_init);
+
 /**
  * register_sysctl_table - register a sysctl hierarchy
  * @table: the top-level table structure
-- 
1.4.4.1.g278f


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
