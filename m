From: "Roberts, William C" <william.c.roberts@intel.com>
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, "'Nick Kralevich'" <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: CIL Typepermissive Symbol not inside parenthesis
Date: Thu, 26 Jan 2017 18:39:19 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC562304D05F@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Building for Hikey (Android) with a type permissive statement on hci_attach, yields this error:

/bin/bash -c "(out/host/linux-x86/bin/secilc -M true -c 30 out/target/product/hikey/obj/ETC/plat_sepolicy.cil_intermediates/plat_policy_nvr.cil out/target/product/hikey/obj/ETC/mapping_sepolicy.cil_intermediates/mapping/current.cil out/target/product/hikey/obj/ETC/nonplat_sepolicy.cil_intermediates/nonplat_policy_nvr.cil  -o out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.tmp ) && (out/host/linux-x86/bin/sepolicy-analyze out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.tmp permissive > out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.permissivedomains ) && (if [ \"userdebug\" = \"user\" -a -s out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.permissivedomains ]; then 		echo \"==========\" 1>&2; 		echo \"ERROR: permissive domains not allowed in user builds\" 1>&2; 		echo \"List of invalid domains:\" 1>&2; 		cat out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.permissivedomains 1>&2; 		exit 1; 		fi ) && (mv out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy.tmp out/target/product/hikey/obj/ETC/sepolicy_intermediates/sepolicy )"
Symbol not inside parenthesis at line 1239 of out/target/product/hikey/obj/ETC/nonplat_sepolicy.cil_intermediates/nonplat_policy_nvr.cil

To reproduce apply this patch to device/linaro/hikey:
diff --git a/sepolicy/hci_attach.te b/sepolicy/hci_attach.te
index d87f444..1990d54 100644
--- a/sepolicy/hci_attach.te
+++ b/sepolicy/hci_attach.te
@@ -1,6 +1,8 @@
 type hci_attach, domain;
 type hci_attach_exec, exec_type, file_type;
 
+permissive hci_attach;
+
 init_daemon_domain(hci_attach)
 
 allow hci_attach kernel:system module_request;

and build sepolicy

make -j4 sepolicy

I have no idea what's hgappening, but the statement looks different than all the other CIL statements:

Failing CIL snippet:

(type hci_attach)
(roletype object_r hci_attach)
CIL_TYPEPERMISSIVE (type hci_attach_exec)
(roletype object_r hci_attach_exec)
(type hci_attach_tmpfs)
