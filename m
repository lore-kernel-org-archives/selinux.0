Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C991C84C1
	for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664890; cv=none; b=BpIP24OsP9vweAYuWXQ73AOOA+QCqcp+9twNE+YgcMlCVoqOY1CI84OnXOeuYFGunTNazom58wsY+1Hyl/M2iITHiY5Wm5BiSLkgus10pWdAcPQMM9p/gb+NUbgUO32sYoB+xBHbd5qS23m32aLL0q2rM3SAy/3cgy6iU/jkfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664890; c=relaxed/simple;
	bh=Xe7I5wSHwkMiiwcYQK6kge55C9UHnAVHaPmSJTDd51g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzwFlc5B4DQV4vMh8j1ythOx/As3s6huEbqtJkueqOgXJgtZu3epEMMio49W8ahcz2mN5A/KGllKg8NqJV+yKKXqKgc7Jx4DJOxp7IpsCfpMAkIMpDWVKtgWpAEjRJ8w91e0ZmDYPuaPqgHdQbWYTjFSiz8kgYRA/60Y5wZY0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAPY74/J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAPY74/J"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234e5347e2so17397035ad.1
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740664887; x=1741269687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7Hu3BV66wjQbsfzNuledgFxRVFyobHchfLu0mymx6Q=;
        b=BAPY74/JFHPnJW9EevLC7Mav6OF99d0prdsv7o7W24jRxELoJHLH/4RXFoUWQe7vR9
         uFWY9yPwsAc4ovJpeIfZRWqAGtCOT/fxt5wjaQjRYoSkz7p5pyZlPhZSs/Lv8TzCWQNK
         m413hZ5S2V68W75PHNMibnxrKYQaNn+YK/kNcw1LnwVevUsMbGZhKuANYwxMl1YVwWGY
         lKI3tDb3ZFOU98KVoacUslzamoNpV1aPpze+Jd0sc6ygz+7gvuxA6nAPTSzHxaf/ctqz
         XqA2fZmNQW8xVHVIxwIuu8NWqd8IS85DFVPEbZdbJBKkCd/3eyG1IEgu0+CALo9SzVzg
         rZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740664887; x=1741269687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7Hu3BV66wjQbsfzNuledgFxRVFyobHchfLu0mymx6Q=;
        b=RkQ9UN3O/ttjaOD6RpiGBZD09e2KPmH3ybzaKooSEC1RFFc6HDuyCZUR5r6fDQLCvb
         KnG0E+ogRLMWm6tacW4XzpHb9kZBndjVtXk7l8HFrLMva8ekFbxY9/ykogEbCrQ4hdmT
         d1bpRWoqKfOmK50u0aMrNsg39QxuaOz2eRExp8Af97P+SHSGd5nP9bYslcu6MeuQpQIt
         Pfsc3cKlUQjg5u/OhBhTXPYIjfK0inqKpPNoWOFdmQwvlu7EwgrtyIID7+nzOOd+/1vz
         2dzt8hIYHRpn15gl2h+gyOVMFU0IXmY5ux4u4mNJPgJJUwTapiWe0/twMmLJYpd0WmeO
         h/qA==
X-Gm-Message-State: AOJu0YyRojB+qkNtIfe+s28pT/KsufBFyVVIztZv77AgNdENoXIu5lrs
	4pHLsVsyv866SLy4NvObm6bZoIiQnPG3Efs1OEUgabH9+xB6VDpsReD//FbcNPUzz+0PMIe1uF1
	5WIC1erknRcXDGSZMGDDL4KERXJs=
X-Gm-Gg: ASbGncsDJfT1s83gpJZz7buRgpkM0W/+qWKg1gMB5StkyEfueYcasFe4rIvv8e0MEGZ
	+EyKt4QoANNqnyHRYnqRgOvmY90b6QM/WPCm5D3OvWgs6/oiYlts7SIqj1ugC5Boc9rYdlklxF7
	VAn5SfScE=
X-Google-Smtp-Source: AGHT+IGrUOfk51d9fZYacsCXzRaDl/4eIDDm4G0OU8yWvAVxPebwcHXIuMSp9TXkfXRwyDSTr0dagYNQGh6028pBjnQ=
X-Received: by 2002:a17:90b:2710:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2fe7e2e0f68mr10917500a91.6.1740664887034; Thu, 27 Feb 2025
 06:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205205940.19527-1-kippndavis.work@gmx.com>
In-Reply-To: <20250205205940.19527-1-kippndavis.work@gmx.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 27 Feb 2025 09:01:15 -0500
X-Gm-Features: AQ5f1JpEtFw7lLhzVRXcejvWurXb3F97TDSqajWlUpn56OsYzs9OKUS6CDYtBdo
Message-ID: <CAEjxPJ7=sBCN1PVwUwUCi6WNtdyd2eTECsTN2+Vv1OouBRh0iQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for new permissions for
 loading files/data
To: kippndavis.work@gmx.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 3:59=E2=80=AFPM <kippndavis.work@gmx.com> wrote:
>
> From: "Kipp N. Davis" <kippndavis.work@gmx.com>
>
> These tests exercise new SELinux hooks for firmware_load, kexec_image_loa=
d,
> kexec_initramfs_load, and policy_load alongside module_load. These tests
> depend on the corresponding kernel patch and updating the base policy to
> define the new system permissions. If the kernel does not support them,
> they will be skipped.
>
> For testing purposes, you can update the base policy by manually modifyin=
g
> your base module and tweaking /usr/share/selinux/devel (latter only requi=
red
> due to writing the test policy as a .te file rather than as a .cil in ord=
er
> to use the test macros) as follows:
>
>     sudo semodule -c -E base
>     sudo sed -i.orig \
>     "s/module_load/module_load firmware_load kexec_image_load \
>     kexec_initramfs_load policy_load x509_certificate_load/" base.cil
>     sudo semodule -i base.cil
>     sudo sed -i.orig \
>     "s/module_load/module_load firmware_load kexec_image_load \
>     kexec_initramfs_load policy_load x509_certificate_load/" \
>     /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can sudo semodule -r base to undo the module
> change and restore your all_perms.spt file from the saved .orig file.
>
> Note: The x509_certificate_load permission is newly added in the kernel
> but is not tested here due to no callers remaining after boot.
>
> Signed-off-by: Kipp Davis <kippndavis.work@gmx.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/Makefile                          |   8 ++
>  policy/test_file_load.te                 | 102 +++++++++++++++++++++++
>  tests/module_load/Makefile               |   2 +-
>  tests/module_load/setest_firmware_load.c |  29 +++++++
>  tests/module_load/test                   |  70 +++++++++++++++-
>  5 files changed, 209 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_file_load.te
>  create mode 100644 tests/module_load/setest_firmware_load.c
>
> diff --git a/policy/Makefile b/policy/Makefile
> index 46e51f3..fcc80f0 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -180,6 +180,14 @@ ifeq ($(shell [ $(POL_VERS) -ge 34 -a $(MAX_KERNEL_P=
OLICY) -ge 34 ] && echo true
>  TARGETS +=3D test_ioctl_cond_xperms.te
>  endif
>
> +ifeq ($(shell grep -q firmware_load $(POLDEV)/include/support/all_perms.=
spt && \
> +             grep -q kexec_image_load $(POLDEV)/include/support/all_perm=
s.spt && \
> +             grep -q kexec_initramfs_load $(POLDEV)/include/support/all_=
perms.spt && \
> +             grep -q policy_load $(POLDEV)/include/support/all_perms.spt=
 && \
> +             echo true),true)
> +TARGETS +=3D test_file_load.te
> +endif
> +
>  all: build
>
>  expand_check:
> diff --git a/policy/test_file_load.te b/policy/test_file_load.te
> new file mode 100644
> index 0000000..e98503a
> --- /dev/null
> +++ b/policy/test_file_load.te
> @@ -0,0 +1,102 @@
> +###################### Test file loading ###################
> +
> +require {
> +    type boot_t;
> +    type kdump_exec_t;
> +    type tmpfs_t;
> +    type user_tmp_t;
> +}
> +
> +###################### Allow sys kexec_image_load ######################
> +type test_kexec_allow_kexec_image_load_t;
> +testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t);
> +
> +files_search_boot(test_kexec_allow_kexec_image_load_t);
> +fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t);
> +exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kd=
ump_exec_t);
> +domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t);
> +allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
> +
> +allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_loa=
d;
> +allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_loa=
d;
> +
> +###################### Deny sys kexec_image_load ######################
> +type test_kexec_deny_kexec_image_load_t;
> +testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t);
> +
> +files_search_boot(test_kexec_deny_kexec_image_load_t);
> +fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t);
> +exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdu=
mp_exec_t);
> +domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t);
> +allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
> +
> +neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_image=
_load;
> +neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_image=
_load;
> +
> +###################### Allow sys kexec_initramfs_load ##################=
####
> +type test_kexec_allow_kexec_initramfs_load_t;
> +testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t);
> +
> +files_search_boot(test_kexec_allow_kexec_initramfs_load_t);
> +fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t);
> +domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t)=
;
> +allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boot;
> +
> +allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_im=
age_load kexec_initramfs_load } ;
> +allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_im=
age_load kexec_initramfs_load };
> +
> +###################### Deny sys kexec_initramfs_load ###################=
###
> +type test_kexec_deny_kexec_initramfs_load_t;
> +testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t);
> +
> +files_search_boot(test_kexec_deny_kexec_initramfs_load_t);
> +fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t);
> +domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t);
> +allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_image_=
load;
> +allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_image_=
load;
> +allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
> +
> +neverallow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_i=
nitramfs_load;
> +neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_i=
nitramfs_load;
> +
> +###################### Allow sys firmware_load ######################
> +type test_kmodule_allow_firmware_load_t;
> +testsuite_domain_type_minimal(test_kmodule_allow_firmware_load_t)
> +typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
> +
> +type firmware_allow_file_t;
> +files_type(firmware_allow_file_t);
> +
> +allow test_kmodule_allow_firmware_load_t self:capability sys_module;
> +allow test_kmodule_allow_firmware_load_t test_file_t:system module_load;
> +allow test_kmodule_allow_firmware_load_t self:system module_load;
> +allow kernel_t firmware_allow_file_t:system firmware_load;
> +
> +###################### Deny sys firmware_load ######################
> +type test_kmodule_deny_firmware_load_t;
> +testsuite_domain_type_minimal(test_kmodule_deny_firmware_load_t)
> +typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
> +
> +type firmware_deny_file_t;
> +files_type(firmware_deny_file_t);
> +
> +allow test_kmodule_deny_firmware_load_t self:capability { sys_module };
> +allow test_kmodule_deny_firmware_load_t test_file_t:system { module_load=
 };
> +allow test_kmodule_deny_firmware_load_t self:system { module_load };
> +neverallow kernel_t firmware_deny_file_t:system firmware_load;
> +
> +###################### Allow sys policy_load ######################
> +type test_policy_allow_policy_load_t;
> +testsuite_domain_type_minimal(test_policy_allow_policy_load_t);
> +
> +userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t);
> +userdom_write_user_tmp_files(test_policy_allow_policy_load_t);
> +allow test_policy_allow_policy_load_t user_tmp_t:system policy_load;
> +
> +###################### Deny sys policy_load ######################
> +type test_policy_deny_policy_load_t;
> +testsuite_domain_type_minimal(test_policy_deny_policy_load_t);
> +
> +userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t);
> +userdom_write_user_tmp_files(test_policy_deny_policy_load_t);
> +neverallow test_policy_deny_policy_load_t user_tmp_t:system policy_load;
> diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> index 0839532..fc93aec 100644
> --- a/tests/module_load/Makefile
> +++ b/tests/module_load/Makefile
> @@ -1,4 +1,4 @@
> -obj-m =3D setest_module_load.o setest_module_request.o
> +obj-m =3D setest_module_load.o setest_module_request.o setest_firmware_l=
oad.o
>
>  TARGETS =3D finit_load init_load
>  LDLIBS +=3D -lselinux
> diff --git a/tests/module_load/setest_firmware_load.c b/tests/module_load=
/setest_firmware_load.c
> new file mode 100644
> index 0000000..d67470b
> --- /dev/null
> +++ b/tests/module_load/setest_firmware_load.c
> @@ -0,0 +1,29 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/firmware.h>
> +
> +static int __init setest_firmware_request_init(void)
> +{
> +       const struct firmware *fw;
> +       int result;
> +
> +       pr_info("INIT - setest_firmware_request\n");
> +       result =3D request_firmware(&fw, "dummy-firmware", NULL);
> +       if (result) {
> +               pr_err("request_firmware failed: %d\n", result);
> +               return result;
> +       }
> +       pr_info("request_firmware succeeded\n");
> +       release_firmware(fw);
> +       return 0;
> +}
> +
> +static void __exit setest_firmware_request_exit(void)
> +{
> +       pr_info("EXIT - setest_firmware_request\n");
> +}
> +
> +module_init(setest_firmware_request_init);
> +module_exit(setest_firmware_request_exit);
> +MODULE_LICENSE("GPL");
> \ No newline at end of file
> diff --git a/tests/module_load/test b/tests/module_load/test
> index 524b333..98c5946 100755
> --- a/tests/module_load/test
> +++ b/tests/module_load/test
> @@ -16,7 +16,13 @@ BEGIN {
>          $v =3D " ";
>      }
>
> -    plan tests =3D> 8;
> +    $kexec_perm_file   =3D "/sys/fs/selinux/class/system/perms/kexec_ima=
ge_load";
> +    $kexec_load_exists =3D 0;
> +    if ( -f $kexec_perm_file ) {
> +        $kexec_load_exists =3D 1;
> +    }
> +
> +    plan tests =3D> 17;
>  }
>
>  print "Test finit_module(2)\n";
> @@ -59,4 +65,66 @@ $result =3D system
>  "runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $bas=
edir setest_module_request 2>&1";
>  ok( $result >> 8 eq 13 );
>
> +SKIP: {
> +    skip(
> +"Not all system permissions available; skipping kexec, initramfs, firmwa=
re and policy tests",
> +        9
> +    ) unless $kexec_load_exists;
> +
> +    $kver =3D `uname -r`;
> +    chomp($kver);
> +    $kernel =3D "/boot/vmlinuz-$kver";
> +    $initrd =3D "/boot/initramfs-$kver.img";
> +
> +    $result =3D
> +      system "runcon -t test_kexec_allow_kexec_image_load_t kexec -l $ke=
rnel";
> +    ok( $result eq 0 );
> +
> +    $result =3D system "runcon -t test_kexec_allow_kexec_image_load_t ke=
xec -u";
> +    ok( $result eq 0 );
> +
> +    # Deny system { kexec_image_load }
> +    $result =3D system
> +      "runcon -t test_kexec_deny_kexec_image_load_t kexec -l $kernel 2>&=
1";
> +    ok( $result >> 8 eq 255 );
> +
> +    $result =3D system
> +"runcon -t test_kexec_allow_kexec_initramfs_load_t kexec -l --initrd=3D$=
initrd $kernel";
> +    ok( $result eq 0 );
> +
> +    # Deny system { kexec_initramfs_load }
> +    $result =3D system
> +"runcon -t test_kexec_deny_kexec_initramfs_load_t kexec -l --initrd=3D$i=
nitrd $kernel 2>&1";
> +    ok( $result >> 8 eq 255 );
> +
> +    system("mkdir -p /usr/lib/firmware");
> +    system("echo 'Test firmware' > /usr/lib/firmware/dummy-firmware");
> +    system("chcon -t firmware_allow_file_t /usr/lib/firmware/dummy-firmw=
are");
> +
> +    $result =3D system
> +"runcon -t test_kmodule_allow_firmware_load_t $basedir/init_load $v $bas=
edir setest_firmware_load";
> +    ok( $result eq 0 );
> +
> +    system("chcon -t firmware_deny_file_t /usr/lib/firmware/dummy-firmwa=
re");
> +
> +    # Deny system { firmware_load } - EACCES
> +    $result =3D system
> +"runcon -t test_kmodule_deny_firmware_load_t $basedir/init_load $v $base=
dir setest_firmware_load 2>&1";
> +    ok( $result >> 8 eq 13 );
> +
> +    system("rm -f /usr/lib/firmware/dummy-firmware");
> +    system("echo 'measure func=3DBPRM_CHECK' > /tmp/test_ima_policy");
> +
> +    $result =3D system
> +qq(runcon -t test_policy_allow_policy_load_t bash -c "echo '/tmp/test_im=
a_policy' > /sys/kernel/security/ima/policy");
> +    ok( $result eq 0 );
> +
> +    # Deny system { policy_load } - EACCES
> +    $result =3D system
> +qq(runcon -t test_policy_deny_policy_load_t bash -c "echo '/tmp/test_ima=
_policy' > /sys/kernel/security/ima/policy 2>&1");
> +    ok( $result >> 8 eq 1 );
> +
> +    system("rm -f /tmp/test_ima_policy");
> +}
> +
>  exit;
> --
> 2.48.1
>
