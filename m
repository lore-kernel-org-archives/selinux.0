Subject: Re: [SEMANAGE] Use the paths array
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43F24788.6060601@cornell.edu>
References: <43F24788.6060601@cornell.edu>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 09:42:25 -0500
Message-Id: <1140014545.14253.373.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 16:11 -0500, Ivan Gyurdiev wrote:
> Joshua's complained about my non-use of the store path array.
> Correct this issue.

It appears that users.local and users_extra.local are in the wrong order
in the path array, or in the enumerated type - take your pick.

diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2006-02-13 10:13:22.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2006-02-14 15:51:01.000000000 -0500
@@ -96,6 +96,14 @@ static const char *semanage_sandbox_path
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
+	"/ports.local",
+	"/interfaces.local",
+	"/nodes.local",
+	"/booleans.local",
+	"/file_contexts.local",
+	"/seusers",
+	"/users_extra.local",
+	"/users.local",
 	"/seusers.final",
 	"/users_extra",
 };

diff -Naurp --exclude-from excludes old/libsemanage/src/semanage_store.h new/libsemanage/src/semanage_store.h
--- old/libsemanage/src/semanage_store.h	2006-02-07 09:20:42.000000000 -0500
+++ new/libsemanage/src/semanage_store.h	2006-02-14 15:06:19.000000000 -0500
@@ -45,8 +45,16 @@ enum semanage_sandbox_defs {
 	SEMANAGE_HOMEDIR_TMPL,
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
+	SEMANAGE_PORTS_LOCAL,
+	SEMANAGE_INTERFACES_LOCAL,
+	SEMANAGE_NODES_LOCAL,
+	SEMANAGE_BOOLEANS_LOCAL,
+	SEMANAGE_FC_LOCAL,
+	SEMANAGE_SEUSERS_LOCAL,
+	SEMANAGE_USERS_BASE_LOCAL,
+	SEMANAGE_USERS_EXTRA_LOCAL,
 	SEMANAGE_SEUSERS,
-	SEMANAGE_USER_EXTRA,
+	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_STORE_NUM_PATHS
 };
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
