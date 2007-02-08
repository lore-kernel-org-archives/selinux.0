From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
Subject: [PATCH 0/5] sysctl cleanup selinux fixes
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
Date: Thu, 08 Feb 2007 15:51:15 -0700
In-Reply-To: <m1mz3o8fbf.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Thu, 08 Feb 2007 15:17:24 -0700")
Message-ID: <m1abzo8dr0.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Andrew these are a set up simple fixes against the rollup you
sent me last night that should leave selinux working and should
close out the last of the outstanding issue with my sysctl cleanup.

Knowing how you organize I expect you will want to file most of
these as fix patches.

Patch 1 sysctl: Remove declaration of nonexistent sysctl_init
This is a small fix against "sysctl: Reimplement the sysctl proc support"
where I remove sysctl_init() but forgot to remove it's prototype in
sysctl.h


Patch 2 sysctl: Set the parent field in the root sysctl table
This is a small fix against 
"sysctl: Add a parent entry to ctl_table and set the parent entry."
where I forgot to call sysctl_set_parent on the root sysctl table.


Patch 3: sysctl: Fix selinux_sysctl_getsid
This is a small fix against
"sysctl: Restore the old selinux sysctl handling."

Patch 4: selinux: Enhance selinux to always ignore private inodes
Patch 5: sysctl: Hide the sysctl proc inodes from selinux

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
