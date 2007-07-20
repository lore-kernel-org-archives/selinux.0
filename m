Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NDtnYH013111
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 09:55:49 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NDtlSG029735
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 13:55:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l6NDtGxN016157
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 09:55:16 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l6NDtGGF016156
	for selinux@tycho.nsa.gov; Mon, 23 Jul 2007 09:55:16 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KJbDS7019924
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 15:37:13 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6KJbCKP009705
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 19:37:12 GMT
Date: Fri, 20 Jul 2007 15:32:18 -0400
Subject: [RFC][PATCH 01/01]qemu: add SELinux hook for loading virtual hard
 disk
From: David Windsor <dwindsor@tresys.com>
To: selinux <selinux@tycho.nsa.gov>,
        kvm-devel <kvm-devel@lists.sourceforge.net>
CC: Joshua Brindle <jbrindle@tresys.com>
Message-ID: <C2C68602.366E%dwindsor@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add infrastructure to qemu to make it an SELinux object manager.  Currently,
the AVC is not being used, since only one permission is currently being
checked.


Index: src/kvm-userspace/qemu/vl.c
===================================================================
--- src.orig/kvm-userspace/qemu/vl.c
+++ src/kvm-userspace/qemu/vl.c
@@ -92,6 +92,8 @@
 #include "qemu-kvm.h"
 #endif
 
+#include "selinux.h"
+
 #define DEFAULT_NETWORK_SCRIPT "/etc/qemu-ifup"
 #ifdef __sun__
 #define SMBD_COMMAND "/usr/sfw/sbin/smbd"
@@ -7522,6 +7524,14 @@ int main(int argc, char **argv)
     }
 #endif
 
+#ifdef CONFIG_VM_SECURITY
+    /* Initialize SELinux */
+    if (selinux_init()) {
+       fprintf(stderr, "Could not initialize SELinux\n");
+       exit(1);
+    }
+#endif
+
     /* we always create the cdrom drive, even if no disk is there */
     bdrv_init();
     if (cdrom_index >= 0) {
@@ -7537,6 +7547,14 @@ int main(int argc, char **argv)
                 snprintf(buf, sizeof(buf), "hd%c", i + 'a');
                 bs_table[i] = bdrv_new(buf);
             }
+
+#ifdef CONFIG_VM_SECURITY
+           if (selinux_vm_use_block_device(hd_filename[i])) {
+               fprintf(stderr, "qemu: SELinux denied access to hard disk
image '%s'\n", hd_filename[i]);
+               exit(1);
+           }
+#endif
+
             if (bdrv_open(bs_table[i], hd_filename[i], snapshot ?
BDRV_O_SNAPSHOT : 0) < 0) {
                 fprintf(stderr, "qemu: could not open hard disk image
'%s'\n",
                         hd_filename[i]);
Index: src/kvm-userspace/qemu/configure
===================================================================
--- src.orig/kvm-userspace/qemu/configure
+++ src/kvm-userspace/qemu/configure
@@ -90,6 +90,7 @@ bsd="no"
 linux="no"
 kqemu="no"
 kvm="no"
+vm_security="no"
 profiler="no"
 kernel_path=""
 cocoa="no"
@@ -238,6 +239,8 @@ for opt do
   ;;
   --enable-kvm) kvm="yes"
   ;;
+  --enable-vm-security) vm_security="yes"
+  ;;
   --enable-profiler) profiler="yes"
   ;;
   --kernel-path=*) kernel_path="$optarg"
@@ -287,6 +290,7 @@ echo "kqemu kernel acceleration support:
 echo "  --disable-kqemu          disable kqemu support"
 echo "  --kernel-path=PATH       set the kernel path (configure probes it)"
 echo "  --enable-kvm             enable kernel virtual machine support"
+echo "  --enable-vm-security     enable SELinux enforcement hooks"
 echo ""
 echo "Advanced options (experts only):"
 echo "  --source-path=PATH       path of source code [$source_path]"
@@ -868,13 +872,18 @@ bflt="no"
 interp_prefix1=`echo "$interp_prefix" | sed "s/%M/$target_cpu/g"`
 echo "#define CONFIG_QEMU_PREFIX \"$interp_prefix1\"" >> $config_h
 
+if test $vm_security = "yes" ; then
+       echo "#define CONFIG_VM_SECURITY 1" >> $config_h
+       echo "CONFIG_VM_SECURITY=yes" >> $config_mak
+fi
+
 configure_kvm() {
   if test $kvm = "yes" -a "$target_softmmu" = "yes" -a \
           \( "$cpu" = "i386" -o "$cpu" = "x86_64" \); then
     echo "#define USE_KVM 1" >> $config_h
     echo "CONFIG_KVM_KERNEL_INC=$kernel_path/include" >> $config_mak
   fi
-}
+  }
 
 if test "$target_cpu" = "i386" ; then
   echo "TARGET_ARCH=i386" >> $config_mak
Index: src/kvm-userspace/configure
===================================================================
--- src.orig/kvm-userspace/configure
+++ src/kvm-userspace/configure
@@ -5,6 +5,7 @@ kerneldir=/lib/modules/$(uname -r)/build
 want_module=1
 qemu_cc=$(ls /usr/bin/gcc3* /usr/bin/gcc-3* 2>/dev/null | tail -n1)
 disable_gcc_check=
+enable_vm_security=
 
 usage() {
     cat <<-EOF
@@ -18,6 +19,7 @@ usage() {
            --qemu-cc="$qemu_cc"   compiler for qemu (needs gcc3.x)
($qemu_cc)
            --disable-gcc-check    don't insist on gcc-3.x
                                    - this will break running without kvm
+           --enable-vm-security   enable SELinux security enforcement
 EOF
     exit 1
 }
@@ -53,6 +55,9 @@ while [[ "$1" = -* ]]; do
        --disable-gcc-check)
            disable_gcc_check=1
            ;;
+       --enable-vm-security)
+           enable_vm_security=1
+           ;;
        --help)
            usage
            ;;
@@ -87,6 +92,7 @@ target_cpu() {
     --enable-kvm --kernel-path="$libkvm_kerneldir" \
     --enable-alsa \
     ${disable_gcc_check:+"--disable-gcc-check"} \
+    ${enable_vm_security:+"--enable-vm-security"}\
     --prefix="$prefix"
 )
 
Index: src/kvm-userspace/qemu/Makefile.target
===================================================================
--- src.orig/kvm-userspace/qemu/Makefile.target
+++ src/kvm-userspace/qemu/Makefile.target
@@ -232,7 +232,7 @@ OBJS+= libqemu.a
 
 # cpu emulator library
 LIBOBJS=exec.o kqemu.o qemu-kvm.o translate-op.o translate-all.o
cpu-exec.o\
-        translate.o op.o
+        translate.o op.o selinux.o
 ifdef CONFIG_SOFTFLOAT
 LIBOBJS+=fpu/softfloat.o
 else
@@ -364,6 +364,9 @@ CFLAGS += -I $(CONFIG_KVM_KERNEL_INC)
 LIBS += -lkvm
 DEPLIBS += ../user/libkvm.a
 endif
+ifdef CONFIG_VM_SECURITY
+LIBS += -lselinux
+endif
 
 # SCSI layer
 VL_OBJS+= scsi-disk.o cdrom.o lsi53c895a.o
Index: src/kvm-userspace/qemu/selinux.h
===================================================================
--- /dev/null
+++ src/kvm-userspace/qemu/selinux.h
@@ -0,0 +1,24 @@
+#ifndef _QEMU_SELINUX_H_
+#define _QEMU_SELINUX_H_
+
+/*
+ * Initialize qemu's SELinux subsystem.
+ *
+ * Returns 0 on success, non-zero on error.
+ * This function will only return non-zero when SELinux is
+ * enabled in the running kernel and is in enforcing mode.
+ */
+int selinux_init(void);
+
+/*
+ * Check the SELinux policy as to whether the current process is allowed
+ * to load a virtual disk into a virtual machine.
+ * This function should only be called after calling selinux_init.
+ *
+ * Returns 0 if the operation is allowed, non-zero if the operation is
denied.
+ * This function will only return non-zero if SELinux is enabled
+ * in the running kernel and is in enforcing mode.
+ */
+int selinux_vm_use_block_device(const char *hd_filename);
+
+#endif
Index: src/kvm-userspace/qemu/selinux.c
===================================================================
--- /dev/null
+++ src/kvm-userspace/qemu/selinux.c
@@ -0,0 +1,114 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>
+#include <selinux/selinux.h>
+
+#include "selinux.h"
+
+static int qemu_selinux_enabled = 0;
+
+/*
+ * Initialize qemu's SELinux subsystem.
+ *
+ * Returns 0 on success, non-zero on error.
+ * This function will return non-zero only when SELinux is
+ * enabled in the running kernel and is in enforcing mode.
+ */
+int selinux_init(void)
+{
+       int retval = -1;
+       struct security_class_mapping map[] = {
+                { "vm",
+                        { "entrypoint", NULL }},
+                { NULL }
+        };
+
+       if (qemu_selinux_enabled) {
+               retval = 0;
+               goto out;
+       }
+
+       retval = is_selinux_enabled();
+       if (!retval)
+               goto out;
+
+       /* Create userspace object class and permission mappings */
+       retval = selinux_set_mapping(map);
+        if (retval < 0) {
+                printf("SELinux: failed to set up security class
mapping\n");
+                goto out;
+        }
+
+       qemu_selinux_enabled = 1;
+out:
+       if (retval != 0 && !security_getenforce())
+               retval = 0;
+       return retval;
+}
+
+/*
+ * Check the SELinux policy as to whether the current process is
+ * allowed to load a virtual disk into a virtual machine.
+ * This function should only be called after calling selinux_init.
+ *
+ * Returns 0 if the operation is allowed, non-zero if the operation is
denied.
+ * This function will only return non-zero if SELinux is enabled
+ * in the running kernel and is in enforcing mode.
+ */
+int selinux_vm_use_block_device(const char *hd_filename)
+{
+        security_context_t scon;
+        security_context_t tcon;
+        security_class_t vm_class;
+        access_vector_t vm_perms;
+        struct av_decision avd;
+        int retval = -1;
+        
+        retval = is_selinux_enabled();
+        if (!retval) {
+                retval = 0;
+                goto out;
+        }
+
+        vm_class = string_to_security_class("vm");
+        if (!vm_class) {
+                       retval = -1;
+               goto out;
+       }
+
+        vm_perms = string_to_av_perm(vm_class, "entrypoint");
+        if (!vm_perms) {
+                retval = -1;
+                goto out;
+        }
+
+        /* The context of the VM is the context of the current process */
+        retval = getcon(&scon);
+        if (retval)
+                goto out;
+
+        /* Get the context of the virtual disk */
+        retval = getfilecon(hd_filename, &tcon);
+        if (retval < 0) {
+                freecon(scon);
+                goto out;
+        }
+
+        retval = security_compute_av(scon, tcon, vm_class,
+                                     vm_perms, &avd);
+        freecon(scon);
+        freecon(tcon);
+        if (!retval && ((vm_perms & avd.allowed) == vm_perms)) {
+                goto out;
+        } else {
+                /* Access is denied */
+                retval = 1;
+                goto out;
+        }
+
+out:
+        if (retval != 0 && !security_getenforce())
+                retval = 0;
+        return retval;
+}




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
