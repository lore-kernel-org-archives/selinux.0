Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F021A94F
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527859; cv=none; b=VH7wZZ3/KYG5w9RLD0KBp4XNmLTSZuxomqIY3+U8WJtWdTf5emB8uvjepLFYVQDfwYWxEMFb2yL96rjeaflccxmjIr8khZAXXZ0AffG95i+i0MKNw6w2he7kR4p4wmthD7QMxzT44mmE/9iKtrulDnmuuRZBo4plRCj+OZUxh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527859; c=relaxed/simple;
	bh=bf8+kCN6vHfcX1LZhiXuI18ORpVK1SeYs68LPsDyjhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7JOeJaobqCFCmT/k1hlU5+M458vu+eteFqFIosGbFAX5iYOEOmOdf2zdoCvWBRrGZRExcxPo1DHJ8hjxpGDhFcDIOr6V2s/LAsPq89DGrqhqSxcVANKzZfTJqTwoQdLOjfdp6fqXMyCwjCzIMO2fCrsu8BbRennwukKxkZJeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwWj+VSw; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwWj+VSw"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-333f8db5aedso30629291fa.0
        for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527855; x=1756132655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dndQhPuX1plXRpY6Hg6t5vxM8fZqkzUUnlWdRNBPnF0=;
        b=XwWj+VSw/lZJX7osugZGfEXU+xVERuyq1A4aVAoUDxRnMe5mQPnQu53sBQRtg+u7pH
         BJmwKcMWdH6OoUL4jUNpPgbpSRzFYisCOltOIZXIJZJs9goTWY9L7cRdxX9aQNGt6TMf
         HKc8kxyefW/KoWcp1XZMpjD08v1Ye6jO07Imus2cijxPlLCMMlIlL8O2M/GJ0Lw2kAmS
         eMGfYvxG9zpfHPBU2u74N1Z/IJ6i854pGJ5FkOMW26cFht5g8ABjOLt/0Pr+BftkjhHT
         h7xFD8TR6SyolHW68pEodmUAASpEf8NaUckdaFaX6INuknnbp9hYp3jbY4d52ENxshc+
         NWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527855; x=1756132655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dndQhPuX1plXRpY6Hg6t5vxM8fZqkzUUnlWdRNBPnF0=;
        b=hCYIh1MCir2TErWNpQqtMxWr7Fp1bpZSgiYUuiSx2mETfRNN6Vm8Va7MU/kgAzROjS
         ZnMtv90jg9Wr530lDSMNmLzllEkZ9ajVs3pyfTIBiJFa4KaDhvMmb5SYqs/w+scWvK27
         7dFeL7KMuz7zQ5B8OlRTVEbXcNEmENBg+W3CEUwex4LYCrZ0dxBoMz5oa0uIZmeOOauJ
         SZyGh5v9q1OrSMWta9Jyf1IDAi7F9IC6XCEXARPWRDUeB121dYrBvLrMyRFbn4AF+9+Q
         HEBg77VGNnVomYBOaZKmiJwoAwYFYQXFxWZXQ14SyeHdFKVxkRCkQrp8Or/kHteimbDj
         bhjw==
X-Gm-Message-State: AOJu0Yy0JVfN5ziy4+qD1VtuoqbnPLs83almgHQfgS8X10F1zFKGLpTL
	Ur9ufVvxJFkV4YBXIiB6Uhf9DMzUNF7+CzkFroKmecqlcPSoB28GKqbRL4c0xziEwmUMjkYjjdZ
	N0da6r2rizMyNdAGJcURHpgL074VsQXk=
X-Gm-Gg: ASbGnctzBfNg7XO4V6zmrV9oMq5vkC4+uK5JXDt2MfkDnVHaZo/WpbfZMJEYp36lLPB
	7Zb8U4GFu7kLFvSLPpMEx0p/iA6/WMP324WKt+LZiDp02FeN8aorCBvRAlgMGMMMoJtvKrG3JQl
	jYs17OI+wEIqudsCBvOj1+65M3IWJGlPLuoExvVphD41aYjAjAb2dGvrTOHHbPUEPVkSjwL4hxV
	sfztWoHsPtu0MIy7g==
X-Google-Smtp-Source: AGHT+IFUR0H0OrHgXtbs0Nb2Ei8IaVqxS59Ee1FQYdUbp5L2b5YHvOjRVktrAcwGHnHWcaybBMXbIc9oEGwnpWsTMCw=
X-Received: by 2002:a2e:be21:0:b0:332:8187:f837 with SMTP id
 38308e7fff4ca-3340995c150mr33127191fa.27.1755527854662; Mon, 18 Aug 2025
 07:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817191031.1150-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250817191031.1150-1-ericsu@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Mon, 18 Aug 2025 10:37:21 -0400
X-Gm-Features: Ac12FXy4L5rhYS_JImYKtcVIvTHYTarOQElvEWwsIvVKvDkybH_3-6e4WjwDxYk
Message-ID: <CAKrb_fGsWid=-muzOorRR6gQ8onf3EZ6z93ocQaM4SZ8-9Pxaw@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 3:10=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.micro=
soft.com/
>
> Four new tests are added to cover both positive and negative scenarios,
> ensuring that the SELinux policy enforcement on BPF token usage behaves
> as expected.
>   - Successful map_create and prog_load when SELinux permissions are
>     granted.
>   - Enforcement of SELinux policy restrictions when access is denied.
>
> For testing purposes, you can update the base policy by manually
> modifying your base module and tweaking /usr/share/selinux/devel as
> follows:
>   sudo semodule -c -E base
>   sudo cp base.sil base.sil.orig
>   sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>   sudo semodule -i base.cil
>   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>   sudo semodule -i bpf_token_perms.cil
>   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>       /usr/share/selinux/devel/include/support/all_perms.spt.orig
>   sudo sed -i "s/"map_create/map_create map_create_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base bpf_token_perms to
> undo the two module changes and restore your all_perms.spt file from
> the saved .orig file.
>
> Changes in v2:
> - Removed allow rule for 'kernel_t' in test_bpf.te which was added due
>   to a bug in the kernel
> - Cleaned up other unnecessary rules in test_bpf.te
> - Added token_test.c which was missing from previous patch
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  policy/test_bpf.te     |  39 +++
>  tests/bpf/Makefile     |   5 +-
>  tests/bpf/bpf_common.h |  10 +
>  tests/bpf/bpf_test.c   |  59 +++--
>  tests/bpf/test         |  21 +-
>  tests/bpf/token_test.c | 538 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 653 insertions(+), 19 deletions(-)
>  create mode 100644 tests/bpf/token_test.c
>
> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
> index 5eab0bd..45da852 100644
> --- a/policy/test_bpf.te
> +++ b/policy/test_bpf.te
> @@ -57,3 +57,42 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
>  allow test_bpf_deny_prog_run_t self:process { setrlimit };
>  allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin =
};
>  allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write =
prog_load };
> +
> +################### Allow map_create_as and prog_load_as ###############=
####
> +fs_list_bpf_dirs(test_bpf_t)
> +allow test_bpf_t bpf_t:filesystem mount;
> +allow test_bpf_t root_t:dir mounton;
> +allow test_bpf_t self:bpf { map_create_as prog_load_as };
> +allow test_bpf_t self:cap2_userns { bpf perfmon };
> +allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin };
> +allow test_bpf_t self:user_namespace create;
> +
> +############################ Deny map_create_as ########################=
####
> +type test_bpf_deny_map_create_as_t;
> +testsuite_domain_type(test_bpf_deny_map_create_as_t)
> +typeattribute test_bpf_deny_map_create_as_t bpfdomain;
> +allow test_bpf_deny_map_create_as_t self:process { setrlimit };
> +allow test_bpf_deny_map_create_as_t self:capability { sys_resource sys_a=
dmin };
> +
> +fs_list_bpf_dirs(test_bpf_deny_map_create_as_t)
> +allow test_bpf_deny_map_create_as_t bpf_t:filesystem mount;
> +allow test_bpf_deny_map_create_as_t root_t:dir mounton;
> +allow test_bpf_deny_map_create_as_t self:bpf { map_create map_read map_w=
rite prog_load prog_load_as };
> +allow test_bpf_deny_map_create_as_t self:cap2_userns { bpf };
> +allow test_bpf_deny_map_create_as_t self:cap_userns { setgid setuid sys_=
admin };
> +allow test_bpf_deny_map_create_as_t self:user_namespace create;
> +
> +############################ Deny prog_load_as #########################=
####
> +type test_bpf_deny_prog_load_as_t;
> +testsuite_domain_type(test_bpf_deny_prog_load_as_t)
> +typeattribute test_bpf_deny_prog_load_as_t bpfdomain;
> +allow test_bpf_deny_prog_load_as_t self:process { setrlimit };
> +allow test_bpf_deny_prog_load_as_t self:capability { sys_resource sys_ad=
min };
> +
> +fs_list_bpf_dirs(test_bpf_deny_prog_load_as_t)
> +allow test_bpf_deny_prog_load_as_t bpf_t:filesystem mount;
> +allow test_bpf_deny_prog_load_as_t root_t:dir mounton;
> +allow test_bpf_deny_prog_load_as_t self:bpf { map_create map_create_as m=
ap_read map_write prog_load };
> +allow test_bpf_deny_prog_load_as_t self:cap2_userns { bpf perfmon };
> +allow test_bpf_deny_prog_load_as_t self:cap_userns { net_admin setgid se=
tuid sys_admin };
> +allow test_bpf_deny_prog_load_as_t self:user_namespace create;
> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> index 1ae8ce9..cacefbe 100644
> --- a/tests/bpf/Makefile
> +++ b/tests/bpf/Makefile
> @@ -1,5 +1,5 @@
>  TARGETS =3D bpf_test
> -DEPS =3D bpf_common.c bpf_common.h
> +SRCS =3D bpf_test.c bpf_common.c token_test.c
>  LDLIBS +=3D -lselinux -lbpf
>
>  # export so that BPF_ENABLED entries get built correctly on local build
> @@ -14,4 +14,5 @@ clean:
>         rm -f $(TARGETS) test_sock flag *_flag
>         @set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
>
> -$(TARGETS): $(DEPS)
> +$(TARGETS): $(SRCS)
> +       $(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
> \ No newline at end of file
> diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
> index 44ac28f..adba522 100644
> --- a/tests/bpf/bpf_common.h
> +++ b/tests/bpf/bpf_common.h
> @@ -12,6 +12,8 @@
>  extern int create_bpf_map(void);
>  extern int create_bpf_prog(void);
>  extern void bpf_setrlimit(void);
> +extern int test_bpf_map_create(void);
> +extern int test_bpf_prog_load(void);
>
>  /* edited eBPF instruction library */
>  /* Short form of mov, dst_reg =3D imm32 */
> @@ -32,3 +34,11 @@ extern void bpf_setrlimit(void);
>                                                .off   =3D 0,             =
         \
>                                                         .imm   =3D 0 })
>
> +/* Raw code statement block */
> +#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)                 \
> +       ((struct bpf_insn) {                                    \
> +               .code  =3D CODE,                                  \
> +                       .dst_reg =3D DST,                                =
 \
> +                               .src_reg =3D SRC,                        =
         \
> +                                       .off   =3D OFF,                  =
                 \
> +                                               .imm   =3D IMM })
> diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
> index 3c6a29c..a8dc383 100644
> --- a/tests/bpf/bpf_test.c
> +++ b/tests/bpf/bpf_test.c
> @@ -1,28 +1,38 @@
>  #include "bpf_common.h"
>
> +#define write_verbose(verbose, fmt, ...) \
> +       do { \
> +               if (verbose) \
> +                       printf(fmt "\n", ##__VA_ARGS__); \
> +       } while (0)
> +
>  static void usage(char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s -m|-p [-v]\n"
> +               "usage:  %s -m|-p|-c|-l [-v]\n"
>                 "Where:\n\t"
>                 "-m    Create BPF map fd\n\t"
>                 "-p    Create BPF prog fd\n\t"
> +               "-c    Test BPF token map create\n\t"
> +               "-l    Test BPF token program load\n\t"
>                 "-v Print information.\n", progname);
>         exit(-1);
>  }
>
>  int main(int argc, char *argv[])
>  {
> -       int opt, result, fd;
> -       bool verbose =3D false;
> +       int opt, result, ret;
> +       bool verbose =3D false, is_fd =3D true;
>         char *context;
>
>         enum {
>                 MAP_FD =3D 1,
> -               PROG_FD
> +               PROG_FD,
> +               MAP_CREATE,
> +               PROG_LOAD,
>         } bpf_fd_type;
>
> -       while ((opt =3D getopt(argc, argv, "mpv")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "mpclv")) !=3D -1) {
>                 switch (opt) {
>                 case 'm':
>                         bpf_fd_type =3D MAP_FD;
> @@ -30,6 +40,12 @@ int main(int argc, char *argv[])
>                 case 'p':
>                         bpf_fd_type =3D PROG_FD;
>                         break;
> +               case 'c':
> +                       bpf_fd_type =3D MAP_CREATE;
> +                       break;
> +               case 'l':
> +                       bpf_fd_type =3D PROG_LOAD;
> +                       break;
>                 case 'v':
>                         verbose =3D true;
>                         break;
> @@ -44,8 +60,7 @@ int main(int argc, char *argv[])
>                 exit(-1);
>         }
>
> -       if (verbose)
> -               printf("Process context:\n\t%s\n", context);
> +       write_verbose(verbose, "Process context:\n\n%s", context);
>
>         free(context);
>
> @@ -54,24 +69,36 @@ int main(int argc, char *argv[])
>
>         switch (bpf_fd_type) {
>         case MAP_FD:
> -               if (verbose)
> -                       printf("Creating BPF map\n");
> +               write_verbose(verbose, "Creating BPF map");
>
> -               fd =3D create_bpf_map();
> +               ret =3D create_bpf_map();
>                 break;
>         case PROG_FD:
> -               if (verbose)
> -                       printf("Creating BPF prog\n");
> +               write_verbose(verbose, "Creating BPF prog");
> +
> +               ret =3D create_bpf_prog();
> +               break;
> +       case MAP_CREATE:
> +               is_fd =3D false;
> +               write_verbose(verbose, "Testing BPF map create");
> +
> +               ret =3D test_bpf_map_create();
> +               break;
> +       case PROG_LOAD:
> +               is_fd =3D false;
> +               write_verbose(verbose, "Testing BPF prog load");
>
> -               fd =3D create_bpf_prog();
> +               ret =3D test_bpf_prog_load();
>                 break;
>         default:
>                 usage(argv[0]);
>         }
>
> -       if (fd < 0)
> -               return fd;
> +       if (ret < 0)
> +               return ret;
> +
> +       if (is_fd)
> +               close(ret);
>
> -       close(fd);
>         return 0;
>  }
> diff --git a/tests/bpf/test b/tests/bpf/test
> index a3fd856..14bda32 100755
> --- a/tests/bpf/test
> +++ b/tests/bpf/test
> @@ -9,8 +9,10 @@ BEGIN {
>
>      $test_bpf_count       =3D 7;
>      $test_fdreceive_count =3D 4;
> +    $test_bpf_token_count =3D 4;
>
> -    $test_count =3D $test_bpf_count + $test_fdreceive_count;
> +    $test_count =3D
> +      $test_bpf_count + $test_fdreceive_count + $test_bpf_token_count;
>
>      # allow info to be shown during tests
>      $v =3D $ARGV[0];
> @@ -67,6 +69,13 @@ ok( $result eq 0 );
>  $result =3D system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
>  ok( $result eq 0 );
>
> +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
> +ok( $result eq 0 );
> +
> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
> +ok( $result eq 0 );
> +
>  # Deny map_create permission
>  $result =3D
>    system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2=
>&1";
> @@ -92,6 +101,16 @@ $result =3D
>    system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&=
1";
>  ok($result);
>
> +# BPF token - deny BPF_MAP_CREATE_AS
> +$result =3D
> +  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test -c $=
v 2>&1";
> +ok($result);
> +
> +# BPF token - deny BPF_PROG_LOAD_AS
> +$result =3D
> +  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -l $v=
 2>&1";
> +ok($result);
> +
>  #
>  ################ BPF Tests for fdreceive #######################
>  #
> diff --git a/tests/bpf/token_test.c b/tests/bpf/token_test.c
> new file mode 100644
> index 0000000..eb1e3da
> --- /dev/null
> +++ b/tests/bpf/token_test.c
> @@ -0,0 +1,538 @@
> +#include "bpf_common.h"
> +#include "signal.h"
> +#include "linux/mount.h"
> +#include <linux/unistd.h>
> +#include "sys/wait.h"
> +#include "sys/socket.h"
> +#include "fcntl.h"
> +#include "sched.h"
> +#include <bpf/btf.h>
> +
> +#define bit(n) (1ULL << (n))
> +
> +#define zclose(fd) do { if (fd >=3D 0) close(fd); fd =3D -1; } while (0)
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +#define _CHECK(condition, format...) ({    \
> +       int __ret =3D !!(condition); \
> +       int __save_errno =3D errno;   \
> +       if (__ret) {    \
> +               fprintf(stderr, ##format);   \
> +       }   \
> +       errno =3D __save_errno;   \
> +       __ret;  \
> +})
> +
> +#define ASSERT_OK(res, name) ({     \
> +       long long ___res =3D (res);       \
> +       bool ___ok =3D ___res =3D=3D 0;       \
> +       _CHECK(!___ok, \
> +                       "%s failed. unexpected error: %lld (errno %d)\n",=
  \
> +                        name, ___res, errno);  \
> +       ___ok;                          \
> +})
> +
> +#define ASSERT_GT(actual, expected, name) ({    \
> +       typeof(actual) ___act =3D (actual);   \
> +       typeof(expected) ___exp =3D (expected);   \
> +       bool ___ok =3D ___act > ___exp;       \
> +       _CHECK(!___ok,  \
> +                       "unexpected %s: actual %lld <=3D expected %lld (e=
rrno %d)\n",   \
> +                       (name), (long long)(___act), (long long)(___exp),=
 errno);  \
> +       ___ok;  \
> +})
> +
> +#define ASSERT_GE(actual, expected, name) ({    \
> +       typeof(actual) ___act =3D (actual);       \
> +       typeof(expected) ___exp =3D (expected);   \
> +       bool ___ok =3D ___act >=3D ___exp;          \
> +       _CHECK(!___ok,  \
> +                       "unexpected %s: actual %lld < expected %lld (errn=
o %d)\n",   \
> +                       (name), (long long)(___act), (long long)(___exp),=
 errno);          \
> +       ___ok;  \
> +})
> +
> +#define ASSERT_EQ(actual, expected, name) ({    \
> +       typeof(actual) ___act =3D (actual);           \
> +       typeof(expected) ___exp =3D (expected);       \
> +       bool ___ok =3D ___act =3D=3D ___exp;              \
> +       _CHECK(!___ok,   \
> +                       "unexpected %s: actual %lld !=3D expected %lld (e=
rrno %d)\n",   \
> +                       (name), (long long)(___act), (long long)(___exp),=
 errno);          \
> +       ___ok;  \
> +})
> +
> +#define ASSERT_OK_PTR(ptr, name) ({     \
> +       const void *___res =3D (ptr);         \
> +       int ___err =3D libbpf_get_error(___res);  \
> +       bool ___ok =3D ___err =3D=3D 0;           \
> +       _CHECK(!___ok,  \
> +                       "%s unexpected error: %d\n", name, ___err);  \
> +       ___ok;      \
> +})
> +
> +struct bpffs_opts {
> +       __u64 cmds;
> +       __u64 maps;
> +       __u64 progs;
> +       __u64 attachs;
> +       const char *cmds_str;
> +       const char *maps_str;
> +       const char *progs_str;
> +       const char *attachs_str;
> +};
> +
> +typedef int (*child_callback_fn)(int bpffs_fd);
> +
> +static inline int sys_mount(const char *dev_name, const char *dir_name,
> +                           const char *type, unsigned long flags,
> +                           const void *data)
> +{
> +       return syscall(__NR_mount, dev_name, dir_name, type, flags, data)=
;
> +}
> +
> +static inline int sys_fsopen(const char *fsname, unsigned int flags)
> +{
> +       return syscall(__NR_fsopen, fsname, flags);
> +}
> +
> +static inline int sys_fsconfig(int fs_fd, unsigned int cmd, const char *=
key,
> +                              const void *val, int aux)
> +{
> +       return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
> +}
> +
> +static inline int sys_fsmount(int fs_fd, unsigned int flags,
> +                             unsigned int ms_flags)
> +{
> +       return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
> +}

It looks like you are using code heavily derived from elsewhere in the
kernel (tools/testing/selftests/bpf/prog_tests/token.c). It is
probably worth adding a note and including the original license at the
top of your file. I did this in my own token test suite patch if you
want an example.
