Message-ID: <4BEDAE6F.6010401@redhat.com>
Date: Fri, 14 May 2010 16:11:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        SELinux <selinux@tycho.nsa.gov>, Berrange@redhat.com
Subject: libvirt-selinux.patch
Content-Type: multipart/mixed;
 boundary="------------000506010506060407060804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000506010506060407060804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is my attempt at getting libvirt to work on an MLS machine.

This patch attempts to take the current context

libvirtcon = "system_u:system_r:virtd_t:SystemLow-SystemHigh"

The the label of the virtual machine

svirtcon = "system_u:system_r:virtd_t:TopSecret"

Create a new context

newcon = "system_u:system_r:virtd_t:TopSecret"

Then call setsockcreatecon(newcon)

Could you guys check the SELinux parts of this and make sure it matches
your expectations.

The patch does not work, because I think something is wrong with
libvirt, it does not call qemuConnectMonitor?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvtrm4ACgkQrlYvE4MpobOQ8gCcCeKTKyApgSUwZpfa4M/5XL7y
ucoAoONXiiG22C2oSekqLEnteusxwHsb
=NiF4
-----END PGP SIGNATURE-----

--------------000506010506060407060804
Content-Type: text/plain;
 name="libvirt-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libvirt-selinux.patch"

diff -up libvirt-0.8.1/src/qemu/qemu_driver.c~ libvirt-0.8.1/src/qemu/qemu_driver.c
--- libvirt-0.8.1/src/qemu/qemu_driver.c~	2010-04-30 11:45:43.000000000 -0400
+++ libvirt-0.8.1/src/qemu/qemu_driver.c	2010-05-14 11:48:38.000000000 -0400
@@ -1176,27 +1176,44 @@ static int
 qemuConnectMonitor(struct qemud_driver *driver, virDomainObjPtr vm)
 {
     qemuDomainObjPrivatePtr priv = vm->privateData;
-    int ret;
+    int ret = -1;
 
     /* Hold an extra reference because we can't allow 'vm' to be
      * deleted while the monitor is active */
     virDomainObjRef(vm);
 
+    if ((driver->securityDriver &&
+         driver->securityDriver->domainSetSecuritySocketLabel &&
+         driver->securityDriver->domainSetSecuritySocketLabel(driver->securityDriver,vm)) < 0) {
+        VIR_ERROR(_("Failed to set security context for monitor for %s"), vm->def->name);
+        goto error;
+    }
+    
     if ((priv->mon = qemuMonitorOpen(vm,
                                      priv->monConfig,
                                      priv->monJSON,
                                      &monitorCallbacks)) == NULL) {
         VIR_ERROR(_("Failed to connect monitor for %s"), vm->def->name);
-        return -1;
+        goto error;
     }
 
+    if ((driver->securityDriver &&
+         driver->securityDriver->domainClearSecuritySocketLabel &&
+         driver->securityDriver->domainClearSecuritySocketLabel(driver->securityDriver,vm)) < 0) {
+        VIR_ERROR(_("Failed to set security context for monitor for %s"), vm->def->name);
+        goto error;
+    }
+    
     qemuDomainObjEnterMonitorWithDriver(driver, vm);
     ret = qemuMonitorSetCapabilities(priv->mon);
     qemuDomainObjExitMonitorWithDriver(driver, vm);
 
+    ret = 0;
+error:
     if (ret < 0) {
         qemuMonitorClose(priv->mon);
         priv->mon = NULL;
+        virDomainObjUnref(vm);
     }
 
     return ret;
diff -up libvirt-0.8.1/src/qemu/qemu_monitor.c~ libvirt-0.8.1/src/qemu/qemu_monitor.c
diff -up libvirt-0.8.1/src/security/security_driver.h~ libvirt-0.8.1/src/security/security_driver.h
--- libvirt-0.8.1/src/security/security_driver.h~	2010-03-18 08:30:08.000000000 -0400
+++ libvirt-0.8.1/src/security/security_driver.h	2010-05-13 17:20:43.000000000 -0400
@@ -32,6 +32,10 @@ typedef virSecurityDriverStatus (*virSec
 typedef int (*virSecurityDriverOpen) (virSecurityDriverPtr drv);
 typedef int (*virSecurityDomainRestoreImageLabel) (virDomainObjPtr vm,
                                                    virDomainDiskDefPtr disk);
+typedef int (*virSecurityDomainSetSocketLabel) (virSecurityDriverPtr drv,
+                                                virDomainObjPtr vm);
+typedef int (*virSecurityDomainClearSocketLabel)(virSecurityDriverPtr drv,
+                                                virDomainObjPtr vm);
 typedef int (*virSecurityDomainSetImageLabel) (virDomainObjPtr vm,
                                                virDomainDiskDefPtr disk);
 typedef int (*virSecurityDomainRestoreHostdevLabel) (virDomainObjPtr vm,
@@ -59,6 +63,8 @@ struct _virSecurityDriver {
     virSecurityDriverOpen open;
     virSecurityDomainSecurityVerify domainSecurityVerify;
     virSecurityDomainRestoreImageLabel domainRestoreSecurityImageLabel;
+    virSecurityDomainSetSocketLabel domainSetSecuritySocketLabel;
+    virSecurityDomainClearSocketLabel domainClearSecuritySocketLabel;
     virSecurityDomainSetImageLabel domainSetSecurityImageLabel;
     virSecurityDomainGenLabel domainGenSecurityLabel;
     virSecurityDomainReserveLabel domainReserveSecurityLabel;
diff -up libvirt-0.8.1/src/security/security_selinux.c~ libvirt-0.8.1/src/security/security_selinux.c
--- libvirt-0.8.1/src/security/security_selinux.c~	2010-04-30 08:46:09.000000000 -0400
+++ libvirt-0.8.1/src/security/security_selinux.c	2010-05-14 11:47:38.000000000 -0400
@@ -730,6 +728,103 @@ SELinuxSetSecurityProcessLabel(virSecuri
 }
 
 static int
+SELinuxSetSecuritySocketLabel(virSecurityDriverPtr drv,
+                               virDomainObjPtr vm)
+{
+    /* TODO: verify DOI */
+    const virSecurityLabelDefPtr secdef = &vm->def->seclabel;
+    context_t execcon = NULL;
+    context_t proccon = NULL;
+    security_context_t scon = NULL;
+    int rc = -1;
+
+    if (vm->def->seclabel.label == NULL)
+        return 0;
+
+    if (!STREQ(drv->name, secdef->model)) {
+        virSecurityReportError(VIR_ERR_INTERNAL_ERROR,
+                               _("security label driver mismatch: "
+                                 "'%s' model configured for domain, but "
+                                 "hypervisor driver is '%s'."),
+                               secdef->model, drv->name);
+        goto done;
+    }
+
+    if ( !(execcon = context_new(secdef->label)) ) {
+        virReportSystemError(errno,
+                             _("unable to allocate socket security context '%s'"),
+                             secdef->label);
+        goto done;
+    }
+
+    if (getcon(&scon) == -1) {
+        virReportSystemError(errno,
+                             _("unable to get current process context '%s'"),
+                             secdef->label);
+        goto done;
+    }
+
+    if ( !(proccon = context_new(scon)) ) {
+        virReportSystemError(errno,
+                             _("unable to set socket security context '%s'"),
+                             secdef->label);
+        goto done;
+    }
+
+    if (context_range_set(proccon, context_range_get(execcon)) == -1) {
+        virReportSystemError(errno,
+                             _("unable to set socket security context range '%s'"),
+                             secdef->label);
+        goto done;
+    }
+
+    if (setsockcreatecon(context_str(proccon)) == -1) {
+        virReportSystemError(errno,
+                             _("unable to set socket security context '%s'"),
+                             context_str(proccon));
+        goto done;
+    }
+
+    rc = 0;
+done:
+    if (security_getenforce() != 1)
+        rc = 0;
+    if (execcon) context_free(execcon);
+    if (proccon) context_free(proccon);
+    freecon(scon);
+    return rc;
+}
+
+static int
+SELinuxClearSecuritySocketLabel(virSecurityDriverPtr drv,
+                                virDomainObjPtr vm)
+{
+    /* TODO: verify DOI */
+    const virSecurityLabelDefPtr secdef = &vm->def->seclabel;
+    if (vm->def->seclabel.label == NULL)
+        return 0;
+
+    if (!STREQ(drv->name, secdef->model)) {
+        virSecurityReportError(VIR_ERR_INTERNAL_ERROR,
+                               _("security label driver mismatch: "
+                                 "'%s' model configured for domain, but "
+                                 "hypervisor driver is '%s'."),
+                               secdef->model, drv->name);
+        if (security_getenforce() == 1)
+            return -1;
+    }
+
+    if (setsockcreatecon(NULL) == -1) {
+        virReportSystemError(errno,
+                             _("unable to clear socket security context '%s'"),
+                             secdef->label);
+        if (security_getenforce() == 1)
+            return -1;
+    }
+    return 0;
+}
+
+static int
 SELinuxSetSecurityAllLabel(virDomainObjPtr vm)
 {
     const virSecurityLabelDefPtr secdef = &vm->def->seclabel;
@@ -770,6 +865,8 @@ virSecurityDriver virSELinuxSecurityDriv
     .open                       = SELinuxSecurityDriverOpen,
     .domainSecurityVerify       = SELinuxSecurityVerify,
     .domainSetSecurityImageLabel = SELinuxSetSecurityImageLabel,
+    .domainSetSecuritySocketLabel     = SELinuxSetSecuritySocketLabel,
+    .domainClearSecuritySocketLabel     = SELinuxClearSecuritySocketLabel,
     .domainRestoreSecurityImageLabel = SELinuxRestoreSecurityImageLabel,
     .domainGenSecurityLabel     = SELinuxGenSecurityLabel,
     .domainReserveSecurityLabel     = SELinuxReserveSecurityLabel,

--------------000506010506060407060804
Content-Type: application/pgp-signature;
 name="libvirt-selinux.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libvirt-selinux.patch.sig"

iEYEABECAAYFAkvtrm8ACgkQrlYvE4MpobOL4gCgyZkVhWF8ixNXldMbg3jIMb+to2sAnRyY
8B80nuyyr3GSuQQ9d1uHKrcX
--------------000506010506060407060804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
