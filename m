From: "Roberts, William C" <william.c.roberts@intel.com>
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, "'Nick Kralevich'" <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: CIL Typepermissive Symbol not inside parenthesis
Date: Thu, 26 Jan 2017 19:16:56 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC562304D16E@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Roberts, William C
> Sent: Thursday, January 26, 2017 10:39 AM
> To: seandroid-list@tycho.nsa.gov
> Cc: 'Stephen Smalley' <sds@tycho.nsa.gov>; 'Nick Kralevich' <nnk@google.com>;
> selinux@tycho.nsa.gov
> Subject: CIL Typepermissive Symbol not inside parenthesis
> 
> Building for Hikey (Android) with a type permissive statement on hci_attach,
> yields this error:
> 
> /bin/bash -c "(out/host/linux-x86/bin/secilc -M true -c 30
> out/target/product/hikey/obj/ETC/plat_sepolicy.cil_intermediates/plat_policy_n
> vr.cil
> out/target/product/hikey/obj/ETC/mapping_sepolicy.cil_intermediates/mapping
> /current.cil
> out/target/product/hikey/obj/ETC/nonplat_sepolicy.cil_intermediates/nonplat_
> policy_nvr.cil  -o
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.tmp ) &&
> (out/host/linux-x86/bin/sepolicy-analyze
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.tmp
> permissive >
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.permissived
> omains ) && (if [ \"userdebug\" = \"user\" -a -s
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.permissived
> omains ]; then 		echo \"==========\" 1>&2; 		echo \"ERROR:
> permissive domains not allowed in user builds\" 1>&2; 		echo \"List of
> invalid domains:\" 1>&2; 		cat
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.permissived
> omains 1>&2; 		exit 1; 		fi ) && (mv
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.tmp
> out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy )"
> Symbol not inside parenthesis at line 1239 of
> out/target/product/hikey/obj/ETC/nonplat_sepolicy.cil_intermediates/nonplat_
> policy_nvr.cil
> 
> To reproduce apply this patch to device/linaro/hikey:
> diff --git a/sepolicy/hci_attach.te b/sepolicy/hci_attach.te index
> d87f444..1990d54 100644
> --- a/sepolicy/hci_attach.te
> +++ b/sepolicy/hci_attach.te
> @@ -1,6 +1,8 @@
>  type hci_attach, domain;
>  type hci_attach_exec, exec_type, file_type;
> 
> +permissive hci_attach;
> +
>  init_daemon_domain(hci_attach)
> 
>  allow hci_attach kernel:system module_request;
> 
> and build sepolicy
> 
> make -j4 sepolicy
> 
> I have no idea what's hgappening, but the statement looks different than all the
> other CIL statements:
> 
> Failing CIL snippet:
> 
> (type hci_attach)
> (roletype object_r hci_attach)
> CIL_TYPEPERMISSIVE (type hci_attach_exec) (roletype object_r hci_attach_exec)
> (type hci_attach_tmpfs)
> 
> 

Some of things call routines like cil_write_roletype() in write_ast.c, but some just frpintf(CIL_<CAPS>). Are these features not implemented?

If I apply this hack it works:
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 4ebda6a..8a25680 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1255,7 +1255,7 @@ int __cil_write_node_helper(struct cil_tree_node *node, uint32_t *finished, void
                fprintf(cil_out, "CIL_TYPEBOUNDS ");
                break;
        case CIL_TYPEPERMISSIVE:
-               fprintf(cil_out, "CIL_TYPEPERMISSIVE ");
+               fprintf(cil_out, "(typepermissive hci_attach)\n");
                break;
        case CIL_TYPEATTRIBUTE:

The output looks ok from sepolicy-analyze:

$ sepolicy-analyze $OUT/root/sepolicy permissive
crash_dump
su
hci_attach
