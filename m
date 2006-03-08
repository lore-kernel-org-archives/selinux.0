Subject: Re: libsepol/src/link.c:copy_avrule_list( )
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, SELinux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <440CE892.2060601@cornell.edu>
References: <20060306214139.GA7960@sergelap.austin.ibm.com>
	 <440CE892.2060601@cornell.edu>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 09:05:01 -0500
Message-Id: <1141826701.6157.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-06 at 20:57 -0500, Ivan Gyurdiev wrote:
> That reminds me...
> This is a bug I sent to Joshua.
> 
> ==10331== Invalid read of size 4
> ==10331==    at 0x4B3D12C: copy_avrule_list (link.c:876)
> ==10331==    by 0x4B3E061: copy_avrule_decl (link.c:1173)
> ==10331==    by 0x4B3E356: copy_avrule_block (link.c:1220)
> ==10331==    by 0x4B3E8FE: copy_module (link.c:1345)
> ==10331==    by 0x4B4073C: link_modules (link.c:1977)
> ==10331==    by 0x4B42F8D: sepol_link_packages (module.c:242)
> ==10331==    by 0x4C91D21: semanage_link_sandbox (in 
> /lib64/libsemanage.so.1)
> ==10331==    by 0x4C86BC1: semanage_direct_commit (in 
> /lib64/libsemanage.so.1)
> ==10331==    by 0x4C893A9: semanage_commit (in /lib64/libsemanage.so.1)
> ==10331==    by 0x401ACB: (within /usr/sbin/semodule)
> ==10331==    by 0x4DBE023: __libc_start_main (in /lib64/libc-2.3.90.so)
> ==10331==  Address 0xEC11728 is 0 bytes after a block of size 8 alloc'd
> ==10331==    at 0x4A1DA18: calloc (vg_replace_malloc.c:279)
> ==10331==    by 0x4B3A8D7: permission_copy_callback (link.c:157)
> ==10331==    by 0x4B37FAA: hashtab_map (hashtab.c:236)
> ==10331==    by 0x4B3AB96: class_copy_callback (link.c:189)
> ==10331==    by 0x4B37FAA: hashtab_map (hashtab.c:236)
> ==10331==    by 0x4B3D9C8: copy_identifiers (link.c:1057)
> ==10331==    by 0x4B3DC79: copy_module_identifiers (link.c:1102)
> ==10331==    by 0x4B3E84E: copy_module (link.c:1332)
> ==10331==    by 0x4B4073C: link_modules (link.c:1977)
> ==10331==    by 0x4B42F8D: sepol_link_packages (module.c:242)
> ==10331==    by 0x4C91D21: semanage_link_sandbox (in 
> /lib64/libsemanage.so.1)
> ==10331==    by 0x4C86BC1: semanage_direct_commit (in 
> /lib64/libsemanage.so.1)

What is your test case (i.e. what policy)?
The (i < 32) looks suspicious to me there; should it be (i <
module->perm_map_len[cur_perm->class - 1]), e.g.:

Index: libsepol/src/link.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
retrieving revision 1.16
diff -u -p -r1.16 link.c
--- libsepol/src/link.c	1 Feb 2006 13:59:19 -0000	1.16
+++ libsepol/src/link.c	8 Mar 2006 13:41:33 -0000
@@ -835,7 +835,7 @@ static int (*merge_callback_f[SYM_NUM]) 
 static int copy_avrule_list(avrule_t *list, avrule_t **dst,
                             policy_module_t *module, link_state_t *state)
 {
-        int i;
+        unsigned int i;
         avrule_t *cur, *new_rule = NULL, *tail;
         class_perm_node_t *cur_perm, *new_perm, *tail_perm = NULL;
 
@@ -870,7 +870,7 @@ static int copy_avrule_list(avrule_t *li
                         assert(new_perm->class);
 
                         if (new_rule->specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
-                                for (i = 0; i < 32; i++) {
+                                for (i = 0; i < module->perm_map_len[cur_perm->class - 1]; i++) {
                                         if (!(cur_perm->data & (1U << i)))
                                                 continue;
 					new_perm->data |=

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
