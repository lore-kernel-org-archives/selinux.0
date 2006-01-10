Message-ID: <43C34AAE.1060908@cornell.edu>
Date: Mon, 09 Jan 2006 22:48:30 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] User extra data (part 1)
References: <43C33ECB.2020608@cornell.edu>
In-Reply-To: <43C33ECB.2020608@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------010402010608030300080606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010402010608030300080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bugfix for modified flags attached. I need to write support for re-using 
the linked policy from the last run - none of the file backed components 
needs to relink every time. Otherwise those modified flags aren't very 
useful - they only do something for the case of active booleans (prevent 
overwrite by policy booleans).

--------------010402010608030300080606
Content-Type: text/x-patch;
 name="libsemanage.users_extra_modified.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.users_extra_modified.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-09 22:41:55.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-09 22:39:18.000000000 -0700
@@ -368,6 +368,7 @@ static int semanage_direct_commit(semana
 	/* Check if anything was changed */
 	int modified = sh->modules_modified;
 	dbase_config_t* users = semanage_user_dbase_local(sh);
+	dbase_config_t* users_extra = semanage_user_extra_dbase_local(sh);
 	dbase_config_t* ports = semanage_port_dbase_local(sh);
 	dbase_config_t* bools = semanage_bool_dbase_local(sh);
 	dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
@@ -375,15 +376,17 @@ static int semanage_direct_commit(semana
 	dbase_config_t* seusers = semanage_seuser_dbase(sh);
 	int fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
 	int seusers_modified = seusers->dtable->is_modified(seusers->dbase);
+	int users_extra_modified = users_extra->dtable->is_modified(users_extra->dbase);
 	modified |= users->dtable->is_modified(users->dbase);
 	modified |= ports->dtable->is_modified(ports->dbase);
 	modified |= bools->dtable->is_modified(bools->dbase);
-	modified |= fcontexts_modified;
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 
-	/* FIXME: get rid of this, once we support loading the existing policy,
-	 * instead of rebuilding it for seusers */
+	/* FIXME: get rid of these, once we support loading the existing policy,
+	 * instead of rebuilding it */
 	modified |= seusers_modified;
+	modified |= fcontexts_modified;
+	modified |= users_extra_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {

--------------010402010608030300080606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
