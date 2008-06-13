Subject: Re: libsepol segfault when module requires a user not in base
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, method@manicmethod.com
In-Reply-To: <1213305675.3029.18.camel@localhost.localdomain>
References: <1213305675.3029.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 10:11:06 -0400
Message-Id: <1213366266.17842.335.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 17:21 -0400, Eric Paris wrote:
> checkpolicy-2.0.16-2.fc10.x86_64
> libsepol-2.0.30-1.fc10.x86_64
> 
> Program terminated with signal 11, Segmentation fault.
> [New process 6347]
> #0  0x000000000041a155 in mls_semantic_level_expand ()
> (gdb) bt
> #0  0x000000000041a155 in mls_semantic_level_expand ()
> #1  0x000000000041a3f9 in mls_semantic_range_expand ()
> #2  0x000000000040dd0d in policydb_user_cache ()
> #3  0x000000000040417e in hashtab_map ()
> #4  0x000000000040d829 in policydb_index_others ()
> #5  0x00000000004082e1 in link_modules ()
> #6  0x00000000004036a7 in main (argc=<value optimized out>, argv=0x7fffe894e178) at dismod.c:761
> (gdb) quit
> 
> base.conf:
> **********
> class class1
> sid sid1
> class class1
> {
>         perm1
>         perm2
> }
> sensitivity s0;
> dominance { s0 }
> category c0; category c1; category c2; category c3;
> category c4; category c5; category c6; category c7;
> category c8; category c9; category c10; category c11;
> category c12; category c13; category c14; category c15;
> category c16; category c17; category c18; category c19;
> category c20; category c21; category c22; category c23;
> level s0:c0.c23;
> mlsconstrain class1 { perm1 perm2 }
>         ( h1 dom h2 );
> attribute attr1;
> type type1_t;
> type type2_t;
> role role1_r types { type1_t type2_t };
> role role2_r types { type1_t type2_t };
> allow type1_t type2_t: class1 { perm1 };
> allow role1_r role2_r;
> bool bool1 true;
> user user1_u roles { role1_r } level s0 range s0 - s0:c0.c23;
> sid sid1        user1_u:role1_r:type1_t:s0
> fs_use_xattr ext2 user1_u:role1_r:type1_t:s0;
> genfscon proc /         user1_u:role1_r:type1_t:s0
> nodecon ::1 FFFF:FFFF:FFFF:FFFF:: user1_u:role1_r:type1_t:s0
> 
> badmodule.te:
> *************
> module badmodule 1.0.0;
> require {
> 	user baduser_u;
> 	type type2_t;
> 	type type1_t;
> 	class class1 perm1;
> }
> 
> allow type1_t type2_t : class1 perm1;
> 
> ************
> checkmodule -M -o base.mod base.conf
> checkmodule -M -m -o badmodule.mod badmodule.te
> sedismod base.mod
>    #l
>    #badmodule.mod
> 
> ***BOOM***

Interestingly doesn't occur on F9 for me, so likely a side effect of the
user/role remapping support leading to earlier indexing/caching.

Seems like the same issue as we had with mls_level_convert() in link.
Patch below restores the correct behavior.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/src/expand.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk/libsepol/src/expand.c	(revision 2908)
+++ trunk/libsepol/src/expand.c	(working copy)
@@ -656,6 +656,10 @@
 	if (!p->mls)
 		return 0;
 
+	/* Required not declared. */
+	if (!sl->sens)
+		return 0;
+
 	l->sens = sl->sens;
 	levdatum = (level_datum_t *) hashtab_search(p->p_levels.table,
 						    p->p_sens_val_to_name[l->



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
