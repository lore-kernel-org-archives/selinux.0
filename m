Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s83F6hqg016436
 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2014 11:06:46 -0400
Message-ID: <1409756627.13112.YahooMailNeo@web87905.mail.ir2.yahoo.com>
Date: Wed, 3 Sep 2014 16:03:47 +0100
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: CIL policy for Android
To: seandroid <seandroid-list@tycho.nsa.gov>,
 selinux list <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've produced a CIL version of the external/sepolicy if anyone wants to
try it. It has been built as a new device that is a copy of the AOSP
emulator as it seems more versatile than just patching the current source.

There is a README included that is shown below.

The tarball is available from:
http://taiga.selinuxproject.org/~rhaines/Android/cil_device.tar.gz

I've sent to both lists as there could be some CIL fans who are not on the
Android list.

Richard

        ############# Android CIL Policy README ################
INTRODUCTION
=============
Built and tested using AOSP master branch 31st Aug '14

For info on CIL see https://github.com/SELinuxProject/cil/wiki

This cil_device will build 'almost' the same as that in
out/target/product/generic when using "lunch aosp_arm-eng" for use with the
emulator. See the "BUILDING THE CIL_DEVICE" section on how to build this.

The "almost" covers the following additions that can be seen in the
cil_device.mk file:

1) Use a policy written using CIL language that makes use of namespaces.
   This has been converted from the original TE version suppiled by AOSP
   on 31st August. The conversion is 'thought' to be a replica as it builds
   with the same number of allow, dontaudit, auditallow and typetransition
   rules as in the TE version. See the "CIL POLICY OVERVIEW" section for
   more info.

2) Build the CIL compiler 'secilc'.

3) Update the relevant policy configuration files to support CIL versions:
     sepolicy, seapp_contexts, property_contexts, cil_service_contexts and
     cil_selinux_version.

4) The locale is set to: en_GB and date format set to: dd-MM-yyyy

5) Added animation at startup (rotating safe penguin), see animation dir.

6) Configured six user limit using an overlay to the frameworks config.xml
  file to test different users.


BUILDING THE CIL_DEVICE
=========================
This section explains how to install on Android (AOSP and seandroid)

1)  Set up the environment:

        PATH=/path/to/android/bin:$PATH
        export PREFIX=/path/to/android/project
        cd $PREFIX

2)  Copy the cil_device.tar.gz tarball to $PREFIX and then install the
    new demo_vendor/cil_device files over as follows:

        tar -xf cil_device.tar.gz

3)  Now build the device by running:

        source build/envsetup.sh
        lunch cil_device-eng
        make

    Once built, do the following to ensure that the CIL policy is installed
    correctly (as the original TE policy and file_contexts will still be
    installed - to be fixed one day):

      a) rm $PREFIX/out/target/product/cil_device/ramdisk.img

      b) rm -rf $PREFIX/out/target/product/cil_device/obj/ETC/cil_sepolicy_intermediates

      c) make

  Then run the emulator using:
      emulator -show-kernel


CIL POLICY OVERVIEW
====================
The CIL policy has been built from the original kernel policy language/m4
macro version by hand. The format has remained much the same except that
each *.te module has been converted to CIL with the namespace being the
module name as shown in the "EXAMPLES" section for the bootanim.te and
bootanim.cil policy modules.

The TE and CIL policy builds were checked to see if they matched for a
default build by running the 1-TE-build and 1-CIL-build scripts to build
the policies, then using sedispol to get dumps of all the AV rules by:

  sedispol <policy>
  select 'f' option to output to a file.
  select '1' to dump AVTAB
  select 'q' to quit

Then check outputs by sorting etc. with the following results for both
policies:
   allow rules           = 23,829
   auditallow rules      = 596
   dontaudit rules       = 47
   type_transition rules = 89

Then randomly check that the class/permissions were the same.
Also checked that the same denials were in the TE emulator version as the
CIL emulator version on initial load using "emulator -show-kernel"

There is one additional type 'kernel.unlabeled' that is assigned to
various initial SIDs in initial_sid_contexts.cil. This was done to
distinguish between file.unlabeled and those assigned by the kernel for
sockets etc. - seemed like a good idea at the time !!!

The size of the default TE version is 116,583 and the default CIL version
94,212. It was expected that the CIL version would be larger due to
namespaces, however as the CIL compiler deletes unused attributes,
it makes it smaller. Thowing away the unused attributes (as they have no
associated rules) makes sense but when looking for them with apol - there
they are, gone !!

There is still work to be done to make the CIL policy modules self contained
by moving declarations (for example) from file.cil to their respective
modules (see dumpstate.cil where the socket declaration has been changed
from dumpstate_socket to dumpstate.socket). Also moving the
file_contexts.cil entries to their respective modules and sorting out some
naming conventions.

The result of using namespaces is as follows:

   For example ps -Z would give:
      LABEL                        USER   PID  PPID  NAME
      u:r:kernel.process:s0        root   2     0    kthreadd
      u:r:system_server.process:s0 system 836  63    system_server
      u:r:untrusted_app.process:s0 u0_a32 594  62    com.android.inputmethod.latin

   and from /data/data directory using ls -Z command:
     drwxr-x--x u0_a0     u0_a0     u:object_r:file.app_data_file:s0 com.android.backupconfirm
     drwxr-x--x bluetooth bluetooth u:object_r:file.bluetooth_data_file:s0 com.android.bluetooth
     drwxr-x--x u0_a18    u0_a18    u:object_r:file.app_data_file:s0 com.android.browser

   and from /dev directory using ls -Z command:
     -r--r--r-- root     root   u:object_r:device.properties_device:s0 __properties__
     crw-rw-r-- system   radio  u:object_r:device.alarm_device:s0 alarm
     crw-rw-rw- root     root   u:object_r:device.ashmem_device:s0 ashmem
     crw-rw-rw- system   system u:object_r:qemud.device:s0 qemu_pipe
Note that the qemud.device has been moved to a namespace but not the others.
These could be moved, for example device.properties_device could be moved
to the (block property ..) namespace and would then be 'property.device'.

As can be seen processes are <namespace>.process, some devices are
<namespace>.device, sockets  <namespace>.socket etc.


WHAT HAS CHANGED
=================
1)  All *.te modules converted to CIL.
2)  The security_classes, access_vectors etc. have been converted to
    CIL versions. Note that only the kernel classes and Android classes
    have been implemented as no use for X Windows, database etc.
3)  All main CIL modules are in cil_device/external/cil_policy with an
    Android.mk file.
4)  Converted the build/target/board/generic/sepolicy files to CIL format
    and placed in cil_device/cil_sepolicy
5)  Modified the system/core/rootdir/init.rc file to support the namespace
    context (e.g. setcon u:r:init.process:s0). The updated file is:
    cil_device/cil_init.rc and added via the cil_device.mk file.
6)  Added the CIL compiler with an Android.mk file in
    cil_device/external/secilc
7)  Modifed the property_contexts, service_contexts, seapp_contexts and
    file_contexts files to support CIL. These are installed via the
    cil_device/external/cil_sepolicy/Android.mk file.
See the cil_device/cil_device.mk and
cil_device/external/cil_sepolicy/Android.mk files for more detail.


EXAMPLES
=========
The original bootanim.te and the resulting bootanim.cil policy module:

TE version:
------------
# bootanimation oneshot service
type bootanim, domain;
type bootanim_exec, exec_type, file_type;

init_daemon_domain(bootanim)

binder_use(bootanim)
binder_call(bootanim, surfaceflinger)

allow bootanim gpu_device:chr_file rw_file_perms;

# /oem access
allow bootanim oemfs:dir search;

# Audited locally.
service_manager_local_audit_domain(bootanim)
auditallow bootanim { service_manager_type -surfaceflinger_service }:service_manager find;

CIL version
------------
; bootanimation oneshot service

(block bootanim
    (type process)
    (typeattributeset domain (process))

    (type exec)
    (typeattributeset exec_type (exec))
    (typeattributeset file_type (exec))
    (roletype object_r exec)
    (context exec_context (u object_r exec low_low))

    (call init_daemon_domain (process exec))

    (call binder_use (process))
    (call binder_call (process surfaceflinger.process))

    (allow process device.gpu_device (chr_file_set (rw_file_perms)))

    ; /oem access
    (allow process file.oemfs (dir (search)))

    ; Audited locally.
    (call service_manager_local_audit_domain (process))

    (typeattribute auditallow_sm)
    (typeattributeset auditallow_sm
        (and
            (service_manager_type)
               (not (service.surfaceflinger_service))
        )
    )
    (auditallow process auditallow_sm (service_manager (find)))
)
