Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D41F4CB7
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799349; cv=none; b=R92K39bdw7Xju2CTnkUYLqUip9D+CpWAiWGRNZIGIa7pmsOLFu88etm6XyfFFKNY6ck3XEqSneOt9eoAGudHuUrEYmI5eLZIG+pb0A/Uvx4uu/r/IVPd/N+zzFftnom2mAsfn00HoH0tH0uxgReAaoWIPTR2D+pIrG1B0/0zGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799349; c=relaxed/simple;
	bh=s7l3b6psakqoImF2BJSUO9rnd75LtbhbNHtHmfJUUgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMctYuy+T4/10Bhuew7eEs4H2Y6qDJ3QsZP1EqMBB78DO/DBEZ+X0dujqjv3VOw1EW/pQkoW80WzwD0D5RxGUauEmi88VR5VK34blpehuLMZxO5KKD85ahedU1EM2RjdeOi6b2e6b7BcGjHgpSrV/LNhtjJIifoGT9/gC5yiKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itKHAocK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itKHAocK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso2331215ad.3
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741799347; x=1742404147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEEtUdQVDqfElwWyybQWAW1tp3uF1GmjycDqd/g2a2w=;
        b=itKHAocKJ2eBWxGNFdl1ysFXoAOPTOIDRM8ZT6R9sSP3+PE65pjgdl0VoaCXnMsoMB
         ZejtcWx/b3wzpwiQRChFVViKTM/INNsj35hOW6p3xM+VaKBUy4VcYuVI0JGO6q3oNbes
         6q5tBot7+iTjO0dQNArbaox/5cEKkMX/xEZLn5bWUYKU3phduR7ou4VXzddN7+bBJsRi
         KpW6IORMZlqrFcVkc11HXyvwnD3ZGbCmUtDnG1xDFSJF/6Zsez5ZL33JcGK8UGDsPaV0
         X+JX9iX4O0tInVFVBnpVn0cGIC6zCKgzLd0hhseHx03pinJNb6eF1F315DBqBxcnAgcq
         +UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741799347; x=1742404147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEEtUdQVDqfElwWyybQWAW1tp3uF1GmjycDqd/g2a2w=;
        b=b2hEiQ9zVl1RR4/z/aY5KYioY56AS5mifTrk6azLce4fPe7opI4etveHrFQTTNcpUU
         ctpum1kRy548ywFqsqdgfWtfHegAmMJIfM8jLwBHNrMbpgNDeNgEVSAvxjzVAT+e/s9r
         bLSOf1mAc4jyoP8W0GR4XOP3+oOkD1GP5aB1Hl9EUIWMCe58QoKriX8XrO2Yfe1HjoT2
         lh1LPQd/X1jlOHk8I8iM2EWflD/U5HXYq3tsJ1mq8hwXAlfv4vteTsC47KGclRyNLbYV
         lLH53KWyx+cRBHlpz1b9JHB9sN/i29oyqKLJf1j7slRII3X9avrCa6/6r9VwFRMWz0Al
         V5RA==
X-Gm-Message-State: AOJu0Yx098mmNPp9Crmr9HiiVAkxtKEPtCF5P1/QiLiu/8mJcyFqut2R
	VVT/WVQRAjjdEu7XYTg6HrbLr1n4Ho4jC8GyhVGnE7JNr0/RtNwb6FnMIKIWDAjU/WlzVrFajJF
	4k5QmD9MSCHbdz48HnNkNeuBbw5A=
X-Gm-Gg: ASbGnctTIYof7im0kJFHJTY9QR9coQyG+fc/T3SgrXoESkss+U2L9B+/oFpQPFzQWB1
	dYotiIpeDBPW2ccv5nRw/+9gbZ6is3Xa28tcT8G3mR3yB8Yxnxg4mxaVlUNMmfhv5UvWEU1x/Ho
	uHl+JWqmp5ab6Mm8MTThVdht2aig==
X-Google-Smtp-Source: AGHT+IElFpnISA2jek+GLQQa/GPOMts01J5QlL3kQXyig0zTuB8js+U1NSXRHw07kKBEdIylQMosnoWFieufU8qBeYk=
X-Received: by 2002:a17:902:cf07:b0:223:5ace:eccf with SMTP id
 d9443c01a7336-22428a8cdbcmr356899425ad.25.1741799346613; Wed, 12 Mar 2025
 10:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205205940.19527-1-kippndavis.work@gmx.com> <CAEjxPJ7=sBCN1PVwUwUCi6WNtdyd2eTECsTN2+Vv1OouBRh0iQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7=sBCN1PVwUwUCi6WNtdyd2eTECsTN2+Vv1OouBRh0iQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Mar 2025 13:08:54 -0400
X-Gm-Features: AQ5f1Jp1lC7CIVHEhEveOUhO_z2LDnEwW4vwqFtV5TwnRIQCmvt3rrikHIU95eg
Message-ID: <CAEjxPJ7gqtHfpRQgu5oEv1Pafdc_EQn2EsewOg-2e3OJTrKHNw@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for new permissions for
 loading files/data
To: kippndavis.work@gmx.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Feb 5, 2025 at 3:59=E2=80=AFPM <kippndavis.work@gmx.com> wrote:
> >
> > From: "Kipp N. Davis" <kippndavis.work@gmx.com>
> >
> > These tests exercise new SELinux hooks for firmware_load, kexec_image_l=
oad,
> > kexec_initramfs_load, and policy_load alongside module_load. These test=
s
> > depend on the corresponding kernel patch and updating the base policy t=
o
> > define the new system permissions. If the kernel does not support them,
> > they will be skipped.
> >
> > For testing purposes, you can update the base policy by manually modify=
ing
> > your base module and tweaking /usr/share/selinux/devel (latter only req=
uired
> > due to writing the test policy as a .te file rather than as a .cil in o=
rder
> > to use the test macros) as follows:
> >
> >     sudo semodule -c -E base
> >     sudo sed -i.orig \
> >     "s/module_load/module_load firmware_load kexec_image_load \
> >     kexec_initramfs_load policy_load x509_certificate_load/" base.cil
> >     sudo semodule -i base.cil
> >     sudo sed -i.orig \
> >     "s/module_load/module_load firmware_load kexec_image_load \
> >     kexec_initramfs_load policy_load x509_certificate_load/" \
> >     /usr/share/selinux/devel/include/support/all_perms.spt
> >
> > When finished testing, you can sudo semodule -r base to undo the module
> > change and restore your all_perms.spt file from the saved .orig file.
> >
> > Note: The x509_certificate_load permission is newly added in the kernel
> > but is not tested here due to no callers remaining after boot.
> >
> > Signed-off-by: Kipp Davis <kippndavis.work@gmx.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.

>
> > ---
> >  policy/Makefile                          |   8 ++
> >  policy/test_file_load.te                 | 102 +++++++++++++++++++++++
> >  tests/module_load/Makefile               |   2 +-
> >  tests/module_load/setest_firmware_load.c |  29 +++++++
> >  tests/module_load/test                   |  70 +++++++++++++++-
> >  5 files changed, 209 insertions(+), 2 deletions(-)
> >  create mode 100644 policy/test_file_load.te
> >  create mode 100644 tests/module_load/setest_firmware_load.c
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 46e51f3..fcc80f0 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -180,6 +180,14 @@ ifeq ($(shell [ $(POL_VERS) -ge 34 -a $(MAX_KERNEL=
_POLICY) -ge 34 ] && echo true
> >  TARGETS +=3D test_ioctl_cond_xperms.te
> >  endif
> >
> > +ifeq ($(shell grep -q firmware_load $(POLDEV)/include/support/all_perm=
s.spt && \
> > +             grep -q kexec_image_load $(POLDEV)/include/support/all_pe=
rms.spt && \
> > +             grep -q kexec_initramfs_load $(POLDEV)/include/support/al=
l_perms.spt && \
> > +             grep -q policy_load $(POLDEV)/include/support/all_perms.s=
pt && \
> > +             echo true),true)
> > +TARGETS +=3D test_file_load.te
> > +endif
> > +
> >  all: build
> >
> >  expand_check:
> > diff --git a/policy/test_file_load.te b/policy/test_file_load.te
> > new file mode 100644
> > index 0000000..e98503a
> > --- /dev/null
> > +++ b/policy/test_file_load.te
> > @@ -0,0 +1,102 @@
> > +###################### Test file loading ###################
> > +
> > +require {
> > +    type boot_t;
> > +    type kdump_exec_t;
> > +    type tmpfs_t;
> > +    type user_tmp_t;
> > +}
> > +
> > +###################### Allow sys kexec_image_load ####################=
##
> > +type test_kexec_allow_kexec_image_load_t;
> > +testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t);
> > +
> > +files_search_boot(test_kexec_allow_kexec_image_load_t);
> > +fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t);
> > +exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, =
kdump_exec_t);
> > +domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t);
> > +allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
> > +
> > +allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_l=
oad;
> > +allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_l=
oad;
> > +
> > +###################### Deny sys kexec_image_load #####################=
#
> > +type test_kexec_deny_kexec_image_load_t;
> > +testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t);
> > +
> > +files_search_boot(test_kexec_deny_kexec_image_load_t);
> > +fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t);
> > +exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, k=
dump_exec_t);
> > +domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t);
> > +allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
> > +
> > +neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_ima=
ge_load;
> > +neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_ima=
ge_load;
> > +
> > +###################### Allow sys kexec_initramfs_load ################=
######
> > +type test_kexec_allow_kexec_initramfs_load_t;
> > +testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t)=
;
> > +
> > +files_search_boot(test_kexec_allow_kexec_initramfs_load_t);
> > +fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t);
> > +domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_=
t);
> > +allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boo=
t;
> > +
> > +allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_=
image_load kexec_initramfs_load } ;
> > +allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_=
image_load kexec_initramfs_load };
> > +
> > +###################### Deny sys kexec_initramfs_load #################=
#####
> > +type test_kexec_deny_kexec_initramfs_load_t;
> > +testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t);
> > +
> > +files_search_boot(test_kexec_deny_kexec_initramfs_load_t);
> > +fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t);
> > +domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t=
);
> > +allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_imag=
e_load;
> > +allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_imag=
e_load;
> > +allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
> > +
> > +neverallow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec=
_initramfs_load;
> > +neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec=
_initramfs_load;
> > +
> > +###################### Allow sys firmware_load ######################
> > +type test_kmodule_allow_firmware_load_t;
> > +testsuite_domain_type_minimal(test_kmodule_allow_firmware_load_t)
> > +typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
> > +
> > +type firmware_allow_file_t;
> > +files_type(firmware_allow_file_t);
> > +
> > +allow test_kmodule_allow_firmware_load_t self:capability sys_module;
> > +allow test_kmodule_allow_firmware_load_t test_file_t:system module_loa=
d;
> > +allow test_kmodule_allow_firmware_load_t self:system module_load;
> > +allow kernel_t firmware_allow_file_t:system firmware_load;
> > +
> > +###################### Deny sys firmware_load ######################
> > +type test_kmodule_deny_firmware_load_t;
> > +testsuite_domain_type_minimal(test_kmodule_deny_firmware_load_t)
> > +typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
> > +
> > +type firmware_deny_file_t;
> > +files_type(firmware_deny_file_t);
> > +
> > +allow test_kmodule_deny_firmware_load_t self:capability { sys_module }=
;
> > +allow test_kmodule_deny_firmware_load_t test_file_t:system { module_lo=
ad };
> > +allow test_kmodule_deny_firmware_load_t self:system { module_load };
> > +neverallow kernel_t firmware_deny_file_t:system firmware_load;
> > +
> > +###################### Allow sys policy_load ######################
> > +type test_policy_allow_policy_load_t;
> > +testsuite_domain_type_minimal(test_policy_allow_policy_load_t);
> > +
> > +userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t)=
;
> > +userdom_write_user_tmp_files(test_policy_allow_policy_load_t);
> > +allow test_policy_allow_policy_load_t user_tmp_t:system policy_load;
> > +
> > +###################### Deny sys policy_load ######################
> > +type test_policy_deny_policy_load_t;
> > +testsuite_domain_type_minimal(test_policy_deny_policy_load_t);
> > +
> > +userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t);
> > +userdom_write_user_tmp_files(test_policy_deny_policy_load_t);
> > +neverallow test_policy_deny_policy_load_t user_tmp_t:system policy_loa=
d;
> > diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> > index 0839532..fc93aec 100644
> > --- a/tests/module_load/Makefile
> > +++ b/tests/module_load/Makefile
> > @@ -1,4 +1,4 @@
> > -obj-m =3D setest_module_load.o setest_module_request.o
> > +obj-m =3D setest_module_load.o setest_module_request.o setest_firmware=
_load.o
> >
> >  TARGETS =3D finit_load init_load
> >  LDLIBS +=3D -lselinux
> > diff --git a/tests/module_load/setest_firmware_load.c b/tests/module_lo=
ad/setest_firmware_load.c
> > new file mode 100644
> > index 0000000..d67470b
> > --- /dev/null
> > +++ b/tests/module_load/setest_firmware_load.c
> > @@ -0,0 +1,29 @@
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/firmware.h>
> > +
> > +static int __init setest_firmware_request_init(void)
> > +{
> > +       const struct firmware *fw;
> > +       int result;
> > +
> > +       pr_info("INIT - setest_firmware_request\n");
> > +       result =3D request_firmware(&fw, "dummy-firmware", NULL);
> > +       if (result) {
> > +               pr_err("request_firmware failed: %d\n", result);
> > +               return result;
> > +       }
> > +       pr_info("request_firmware succeeded\n");
> > +       release_firmware(fw);
> > +       return 0;
> > +}
> > +
> > +static void __exit setest_firmware_request_exit(void)
> > +{
> > +       pr_info("EXIT - setest_firmware_request\n");
> > +}
> > +
> > +module_init(setest_firmware_request_init);
> > +module_exit(setest_firmware_request_exit);
> > +MODULE_LICENSE("GPL");
> > \ No newline at end of file
> > diff --git a/tests/module_load/test b/tests/module_load/test
> > index 524b333..98c5946 100755
> > --- a/tests/module_load/test
> > +++ b/tests/module_load/test
> > @@ -16,7 +16,13 @@ BEGIN {
> >          $v =3D " ";
> >      }
> >
> > -    plan tests =3D> 8;
> > +    $kexec_perm_file   =3D "/sys/fs/selinux/class/system/perms/kexec_i=
mage_load";
> > +    $kexec_load_exists =3D 0;
> > +    if ( -f $kexec_perm_file ) {
> > +        $kexec_load_exists =3D 1;
> > +    }
> > +
> > +    plan tests =3D> 17;
> >  }
> >
> >  print "Test finit_module(2)\n";
> > @@ -59,4 +65,66 @@ $result =3D system
> >  "runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $b=
asedir setest_module_request 2>&1";
> >  ok( $result >> 8 eq 13 );
> >
> > +SKIP: {
> > +    skip(
> > +"Not all system permissions available; skipping kexec, initramfs, firm=
ware and policy tests",
> > +        9
> > +    ) unless $kexec_load_exists;
> > +
> > +    $kver =3D `uname -r`;
> > +    chomp($kver);
> > +    $kernel =3D "/boot/vmlinuz-$kver";
> > +    $initrd =3D "/boot/initramfs-$kver.img";
> > +
> > +    $result =3D
> > +      system "runcon -t test_kexec_allow_kexec_image_load_t kexec -l $=
kernel";
> > +    ok( $result eq 0 );
> > +
> > +    $result =3D system "runcon -t test_kexec_allow_kexec_image_load_t =
kexec -u";
> > +    ok( $result eq 0 );
> > +
> > +    # Deny system { kexec_image_load }
> > +    $result =3D system
> > +      "runcon -t test_kexec_deny_kexec_image_load_t kexec -l $kernel 2=
>&1";
> > +    ok( $result >> 8 eq 255 );
> > +
> > +    $result =3D system
> > +"runcon -t test_kexec_allow_kexec_initramfs_load_t kexec -l --initrd=
=3D$initrd $kernel";
> > +    ok( $result eq 0 );
> > +
> > +    # Deny system { kexec_initramfs_load }
> > +    $result =3D system
> > +"runcon -t test_kexec_deny_kexec_initramfs_load_t kexec -l --initrd=3D=
$initrd $kernel 2>&1";
> > +    ok( $result >> 8 eq 255 );
> > +
> > +    system("mkdir -p /usr/lib/firmware");
> > +    system("echo 'Test firmware' > /usr/lib/firmware/dummy-firmware");
> > +    system("chcon -t firmware_allow_file_t /usr/lib/firmware/dummy-fir=
mware");
> > +
> > +    $result =3D system
> > +"runcon -t test_kmodule_allow_firmware_load_t $basedir/init_load $v $b=
asedir setest_firmware_load";
> > +    ok( $result eq 0 );
> > +
> > +    system("chcon -t firmware_deny_file_t /usr/lib/firmware/dummy-firm=
ware");
> > +
> > +    # Deny system { firmware_load } - EACCES
> > +    $result =3D system
> > +"runcon -t test_kmodule_deny_firmware_load_t $basedir/init_load $v $ba=
sedir setest_firmware_load 2>&1";
> > +    ok( $result >> 8 eq 13 );
> > +
> > +    system("rm -f /usr/lib/firmware/dummy-firmware");
> > +    system("echo 'measure func=3DBPRM_CHECK' > /tmp/test_ima_policy");
> > +
> > +    $result =3D system
> > +qq(runcon -t test_policy_allow_policy_load_t bash -c "echo '/tmp/test_=
ima_policy' > /sys/kernel/security/ima/policy");
> > +    ok( $result eq 0 );
> > +
> > +    # Deny system { policy_load } - EACCES
> > +    $result =3D system
> > +qq(runcon -t test_policy_deny_policy_load_t bash -c "echo '/tmp/test_i=
ma_policy' > /sys/kernel/security/ima/policy 2>&1");
> > +    ok( $result >> 8 eq 1 );
> > +
> > +    system("rm -f /tmp/test_ima_policy");
> > +}
> > +
> >  exit;
> > --
> > 2.48.1
> >
