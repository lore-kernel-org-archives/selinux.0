Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E078480
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856451; cv=none; b=RPMwY3QI8/yPrqE++kxiv3Ca0QJ6ytj30Xt9Y61OjBtD4yGR94hAcw6K5PLRDShX/LeyVf9xyowf2bphIHyjCaWxOY7lOiqsWriTq5FtMbAU1ZBijyxm8SxtRStr3u3uqHemKHk7RsfLGnwK+ozmHEcVnNF1lMHbgm6ZvBkQLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856451; c=relaxed/simple;
	bh=7398yXkeUPg0VfvPr8kFkcXjut3ylNsO1oCZJUVBJfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEEgkim41eV47gvY8xmRdpgAz70ZTR65RniL/sINStCPh9M+TEX4x2DNXaL35l1LTawW9Nn+qFpB17EI3mMhhRPSO4jQlrN7Y2zWZopiF+UjrKhlZGxRzYyk+sLgGJllSri4K4a9dM38Oqds0JVrFvsklSOV5nsJkWlJOlFJROo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7yJfASm; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7yJfASm"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so2469864241.2
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856448; x=1708461248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w59gkHTBWWbQA+lbFaDooOKDkz74+59Y5OFnRWW++Y8=;
        b=W7yJfASmFBsK4FHgJarFP3gtARQydyzX1pnKV9bj0pePrTa8hlf2PfxDu4zQ+ScHKn
         Fcy1cC5Yc70ssSgzfKWeyJZgQaeifFiqtuIaCn2vddq5CA2Hi6C/JChLpZZC8JsycXe4
         0ynSEl0p/0guBALEzUP6o0LpIH3JmOtBdx749YTmaudylLqQgHU4JFjz+mzKRLbYsV8V
         U8yME8SOWEYMrYsL5z/q0n0MgzkCnYY7XgrLLRUHqsHV/ZIjZZcmeHt8wt8vdIiqYNPV
         0yz+jcEUQ0pQXzWaafqBNB4E9bW+CI0jbd2cLdCPBju9BWXa6B++IseDvHV8ZIOO1FMJ
         sM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856448; x=1708461248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w59gkHTBWWbQA+lbFaDooOKDkz74+59Y5OFnRWW++Y8=;
        b=Hro8SBNo8KsffDc0KDqs7SjsuLgcKR0tTkPxXAdjLB/GV303/JYKErjHqop4fZ6KX5
         Qm4kuNI7qYKG7RdFdOisCUd9rWlsU9z3kIWonavfxh20eW+V85A1q5PIO/xonGrtayok
         jF+5FVBfpEjk0irtugawOZOro8iIrsNiphlN2x9hqc/mOZGvohIEL4rqfxJdxjN7Rnko
         ry4sO0RaJ1KgBkAg6zURtIcdMIgyUchAN3t8juvmmdD/zJDolmq6lX2JJFRh2LNkSiOe
         F8zZtkPBE8sq8/aGj4deeHGuFilFzEDCt2rtlFqQL1ysJXxSWXE6e3qHA9AlfdJhYr9+
         lbaA==
X-Gm-Message-State: AOJu0Yw5Kii0JySwHcuNFCg/AYoHOWOKR/1Brl6zpxoYiuiulfD0N3FR
	C7n3PBA337asMkfvmkPBkM6VTVpkmSViYrIqaTNHIUokN0ZrN2soJNBJuvcznDyCPn8jLtE+dyd
	2zKflVjXF+50gHgpmSEwcRzqioq6Tg9u/hw4=
X-Google-Smtp-Source: AGHT+IEap3KaA/gd35FWPN/HnOmm2rp22aYTHxalYpBuABR8RoUEulZV9wA8WYijlV27L4Q94HRLmULzpy7LQPIBWNU=
X-Received: by 2002:a67:f3d7:0:b0:46d:6f8:2233 with SMTP id
 j23-20020a67f3d7000000b0046d06f82233mr687588vsn.19.1707856447997; Tue, 13 Feb
 2024 12:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:33:57 -0500
Message-ID: <CAP+JOzT5oAU+OpkEhmq1TTqpBDStQLq_vHaDdmWRBW0z1jQ7+w@mail.gmail.com>
Subject: Re: [PATCH 01/15] checkpolicy: add libfuzz based fuzzer
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce a libfuzz[1] based fuzzer testing the parsing and policy
> generation code used within checkpolicy(8) and checkmodule(8), similar
> to the fuzzer for secilc(8).
> The fuzzer will work on generated source policy input and try to parse,
> link, expand, optimize, sort and output it.
> This fuzzer will also ensure policy validation is not too strict by
> checking compilable source policies are valid.
>
> Build the fuzzer in the oss-fuzz script.
>
> [1]: https://llvm.org/docs/LibFuzzer.html
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/Makefile                     |   3 +
>  checkpolicy/fuzz/checkpolicy-fuzzer.c    | 274 +++++++++++++++++++++++
>  checkpolicy/fuzz/checkpolicy-fuzzer.dict | 101 +++++++++
>  checkpolicy/fuzz/min_pol.conf            |  60 +++++
>  checkpolicy/fuzz/min_pol.mls.conf        |  65 ++++++
>  checkpolicy/module_compiler.c            |  11 +
>  checkpolicy/module_compiler.h            |   4 +
>  checkpolicy/policy_scan.l                |   8 +
>  scripts/oss-fuzz.sh                      |  14 ++
>  9 files changed, 540 insertions(+)
>  create mode 100644 checkpolicy/fuzz/checkpolicy-fuzzer.c
>  create mode 100644 checkpolicy/fuzz/checkpolicy-fuzzer.dict
>  create mode 100644 checkpolicy/fuzz/min_pol.conf
>  create mode 100644 checkpolicy/fuzz/min_pol.mls.conf
>
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index 036ab905..6e8008e3 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -54,6 +54,9 @@ lex.yy.c: policy_scan.l y.tab.c
>  test: checkpolicy
>         ./tests/test_roundtrip.sh
>
> +# helper target for fuzzing
> +checkobjects: $(CHECKOBJS)
> +
>  install: all
>         -mkdir -p $(DESTDIR)$(BINDIR)
>         -mkdir -p $(DESTDIR)$(MANDIR)/man8
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> new file mode 100644
> index 00000000..0d749a02
> --- /dev/null
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -0,0 +1,274 @@
> +#include <assert.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +
> +#include <sepol/debug.h>
> +#include <sepol/kernel_to_cil.h>
> +#include <sepol/kernel_to_conf.h>
> +#include <sepol/module_to_cil.h>
> +#include <sepol/policydb/policydb.h>
> +#include <sepol/policydb/hierarchy.h>
> +#include <sepol/policydb/expand.h>
> +#include <sepol/policydb/link.h>
> +
> +#include "module_compiler.h"
> +#include "queue.h"
> +
> +extern int policydb_validate(sepol_handle_t *handle, const policydb_t *p=
);
> +extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +extern int mlspol;
> +extern policydb_t *policydbp;
> +extern queue_t id_queue;
> +extern unsigned int policydb_errors;
> +
> +extern int yynerrs;
> +extern FILE *yyin;
> +extern void init_parser(int);
> +extern int yyparse(void);
> +extern void yyrestart(FILE *);
> +extern int yylex_destroy(void);
> +extern void set_source_file(const char *name);
> +
> +
> +// Set to 1 for verbose libsepol logging
> +#define VERBOSE 0
> +
> +static ssize_t full_write(int fd, const void *buf, size_t count)
> +{
> +       ssize_t written =3D 0;
> +
> +       while (count > 0) {
> +               ssize_t ret =3D write(fd, buf, count);
> +               if (ret < 0) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +
> +                       return ret;
> +               }
> +
> +               if (ret =3D=3D 0)
> +                       break;
> +
> +               written +=3D ret;
> +               buf =3D (const unsigned char *)buf + (size_t)ret;
> +               count -=3D (size_t)ret;
> +       }
> +
> +       return written;
> +}
> +
> +static int read_source_policy(policydb_t *p, const uint8_t *data, size_t=
 size)
> +{
> +       int fd, rc;
> +       ssize_t wr;
> +
> +       fd =3D memfd_create("fuzz-input", MFD_CLOEXEC);
> +       if (fd < 0)
> +               return -1;
> +
> +       wr =3D full_write(fd, data, size);
> +       if (wr < 0 || (size_t)wr !=3D size) {
> +               close(fd);
> +               return -1;
> +       }
> +
> +       fsync(fd);
> +
> +       yynerrs =3D 0;
> +
> +       yyin =3D fdopen(fd, "r");
> +       if (!yyin) {
> +               close(fd);
> +               return -1;
> +       }
> +
> +       rewind(yyin);
> +
> +       set_source_file("fuzz-input");
> +
> +       id_queue =3D queue_create();
> +       if (id_queue =3D=3D NULL) {
> +               fclose(yyin);
> +               yylex_destroy();
> +               return -1;
> +       }
> +
> +       policydbp =3D p;
> +       mlspol =3D p->mls;
> +
> +       init_parser(1);
> +
> +       rc =3D yyparse();
> +       // TODO: drop global variable policydb_errors if proven to be red=
undant
> +       assert(rc || !policydb_errors);
> +       if (rc || policydb_errors) {
> +               queue_destroy(id_queue);
> +               fclose(yyin);
> +               yylex_destroy();
> +               return -1;
> +       }
> +
> +       rewind(yyin);
> +       init_parser(2);
> +       set_source_file("fuzz-input");
> +       yyrestart(yyin);
> +
> +       rc =3D yyparse();
> +       assert(rc || !policydb_errors);
> +       if (rc || policydb_errors) {
> +               queue_destroy(id_queue);
> +               fclose(yyin);
> +               yylex_destroy();
> +               return -1;
> +       }
> +
> +       queue_destroy(id_queue);
> +       fclose(yyin);
> +       yylex_destroy();
> +
> +       return 0;
> +}
> +
> +static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *a=
rg __attribute__ ((unused)))
> +{
> +       const level_datum_t *levdatum =3D (level_datum_t *) datum;
> +
> +       // TODO: drop member defined if proven to be always set
> +       if (!levdatum->isalias && !levdatum->defined) {
> +               fprintf(stderr,
> +                       "Error:  sensitivity %s was not used in a level d=
efinition!\n",
> +                       key);
> +               abort();
> +       }
> +
> +       return 0;
> +}
> +
> +static int write_binary_policy(FILE *outfp, policydb_t *p)
> +{
> +       struct policy_file pf;
> +
> +       policy_file_init(&pf);
> +       pf.type =3D PF_USE_STDIO;
> +       pf.fp =3D outfp;
> +       return policydb_write(p, &pf);
> +}
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +       policydb_t parsepolicydb =3D {};
> +       policydb_t kernpolicydb =3D {};
> +       policydb_t *finalpolicydb;
> +       sidtab_t sidtab =3D {};
> +       FILE *devnull =3D NULL;
> +       int mls, policyvers;
> +
> +       sepol_debug(VERBOSE);
> +
> +       /* Take the first byte whether to parse as MLS policy
> +       * and the second byte as policy version. */
> +       if (size < 2)
> +               return 0;
> +       switch (data[0]) {
> +       case '0':
> +               mls =3D 0;
> +               break;
> +       case '1':
> +               mls =3D 1;
> +               break;
> +       default:
> +               return 0;
> +       }
> +       static_assert(0x7F - 'A' >=3D POLICYDB_VERSION_MAX, "Max policy v=
ersion should be representable");
> +       policyvers =3D data[1] - 'A';
> +       if (policyvers < POLICYDB_VERSION_MIN || policyvers > POLICYDB_VE=
RSION_MAX)
> +               return 0;
> +       data +=3D 2;
> +       size -=3D 2;
> +
> +       if (policydb_init(&parsepolicydb))
> +               goto exit;
> +
> +       parsepolicydb.policy_type =3D POLICY_BASE;
> +       parsepolicydb.mls =3D mls;
> +       parsepolicydb.handle_unknown =3D DENY_UNKNOWN;
> +       policydb_set_target_platform(&parsepolicydb, SEPOL_TARGET_SELINUX=
);
> +
> +       if (read_source_policy(&parsepolicydb, data, size))
> +               goto exit;
> +
> +       (void) hashtab_map(parsepolicydb.p_levels.table, check_level, NUL=
L);
> +
> +       if (parsepolicydb.policy_type =3D=3D POLICY_BASE) {
> +               if (link_modules(NULL, &parsepolicydb, NULL, 0, VERBOSE))
> +                       goto exit;
> +
> +               if (policydb_init(&kernpolicydb))
> +                       goto exit;
> +
> +               if (expand_module(NULL, &parsepolicydb, &kernpolicydb, VE=
RBOSE, /*check_assertions=3D*/0))
> +                       goto exit;
> +
> +               (void) check_assertions(NULL, &kernpolicydb, kernpolicydb=
.global->branch_list->avrules);
> +               (void) hierarchy_check_constraints(NULL, &kernpolicydb);
> +
> +               kernpolicydb.policyvers =3D policyvers;
> +
> +               assert(kernpolicydb.policy_type    =3D=3D POLICY_KERN);
> +               assert(kernpolicydb.handle_unknown =3D=3D SEPOL_DENY_UNKN=
OWN);
> +               assert(kernpolicydb.mls            =3D=3D mls);
> +
> +               finalpolicydb =3D &kernpolicydb;
> +       } else {
> +               assert(parsepolicydb.policy_type    =3D=3D POLICY_MOD);
> +               assert(parsepolicydb.handle_unknown =3D=3D SEPOL_DENY_UNK=
NOWN);
> +               assert(parsepolicydb.mls            =3D=3D mls);
> +
> +               finalpolicydb =3D &parsepolicydb;
> +       }
> +
> +       if (policydb_load_isids(finalpolicydb, &sidtab))
> +               goto exit;
> +
> +       if (finalpolicydb->policy_type =3D=3D POLICY_KERN && policydb_opt=
imize(finalpolicydb))
> +               goto exit;
> +
> +       if (policydb_sort_ocontexts(finalpolicydb))
> +               goto exit;
> +
> +       if (policydb_validate(NULL, finalpolicydb))
> +               /* never generate an invalid policy */
> +               abort();
> +
> +       devnull =3D fopen("/dev/null", "we");
> +       if (devnull =3D=3D NULL)
> +               goto exit;
> +
> +       if (write_binary_policy(devnull, finalpolicydb))
> +               abort();
> +
> +       if (finalpolicydb->policy_type =3D=3D POLICY_KERN && sepol_kernel=
_policydb_to_conf(devnull, finalpolicydb))
> +               abort();
> +
> +       if (finalpolicydb->policy_type =3D=3D POLICY_KERN && sepol_kernel=
_policydb_to_cil(devnull, finalpolicydb))
> +               abort();
> +
> +       if (finalpolicydb->policy_type =3D=3D POLICY_MOD && sepol_module_=
policydb_to_cil(devnull, finalpolicydb, /*linked=3D*/0))
> +               abort();
> +
> +exit:
> +       if (devnull !=3D NULL)
> +               fclose(devnull);
> +
> +       sepol_sidtab_destroy(&sidtab);
> +       policydb_destroy(&kernpolicydb);
> +       policydb_destroy(&parsepolicydb);
> +
> +       id_queue =3D NULL;
> +       policydbp =3D NULL;
> +       module_compiler_reset();
> +
> +       /* Non-zero return values are reserved for future use. */
> +       return 0;
> +}
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.dict b/checkpolicy/fuzz/=
checkpolicy-fuzzer.dict
> new file mode 100644
> index 00000000..fb7e66c0
> --- /dev/null
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
> @@ -0,0 +1,101 @@
> +# Keyword dictionary
> +
> +"clone"
> +"common"
> +"class"
> +"constrain"
> +"validatetrans"
> +"inherits"
> +"sid"
> +"role"
> +"roles"
> +"roleattribute"
> +"attribute_role"
> +"types"
> +"typealias"
> +"typeattribute"
> +"typebounds"
> +"type"
> +"bool"
> +"tunable"
> +"if"
> +"else"
> +"alias"
> +"attribute"
> +"expandattribute"
> +"type_transition"
> +"type_member"
> +"type_change"
> +"role_transition"
> +"range_transition"
> +"sensitivity"
> +"dominance"
> +"category"
> +"level"
> +"range"
> +"mlsconstrain"
> +"mlsvalidatetrans"
> +"user"
> +"neverallow"
> +"allow"
> +"auditallow"
> +"auditdeny"
> +"dontaudit"
> +"allowxperm"
> +"auditallowxperm"
> +"dontauditxperm"
> +"neverallowxperm"
> +"source"
> +"target"
> +"sameuser"
> +"module"
> +"require"
> +"optional"
> +"or"
> +"and"
> +"not"
> +"xor"
> +"eq"
> +"true"
> +"false"
> +"dom"
> +"domby"
> +"incomp"
> +"fscon"
> +"ibpkeycon"
> +"ibendportcon"
> +"portcon"
> +"netifcon"
> +"nodecon"
> +"pirqcon"
> +"iomemcon"
> +"ioportcon"
> +"pcidevicecon"
> +"devicetreecon"
> +"fs_use_xattr"
> +"fs_use_task"
> +"fs_use_trans"
> +"genfscon"
> +"r1"
> +"r2"
> +"r3"
> +"u1"
> +"u2"
> +"u3"
> +"t1"
> +"t2"
> +"t3"
> +"l1"
> +"l2"
> +"h1"
> +"h2"
> +"policycap"
> +"permissive"
> +"default_user"
> +"default_role"
> +"default_type"
> +"default_range"
> +"low-high"
> +"high"
> +"low"
> +"glblub"
> diff --git a/checkpolicy/fuzz/min_pol.conf b/checkpolicy/fuzz/min_pol.con=
f
> new file mode 100644
> index 00000000..ff6d50e5
> --- /dev/null
> +++ b/checkpolicy/fuzz/min_pol.conf
> @@ -0,0 +1,60 @@
> +class process
> +class blk_file
> +class chr_file
> +class dir
> +class fifo_file
> +class file
> +class lnk_file
> +class sock_file
> +sid kernel
> +sid security
> +sid unlabeled
> +sid fs
> +sid file
> +sid file_labels
> +sid init
> +sid any_socket
> +sid port
> +sid netif
> +sid netmsg
> +sid node
> +sid igmp_packet
> +sid icmp_socket
> +sid tcp_socket
> +sid sysctl_modprobe
> +sid sysctl
> +sid sysctl_fs
> +sid sysctl_kernel
> +sid sysctl_net
> +sid sysctl_net_unix
> +sid sysctl_vm
> +sid sysctl_dev
> +sid kmod
> +sid policy
> +sid scmp_packet
> +sid devnull
> +class process { dyntransition transition }
> +default_role { blk_file } source;
> +default_role { chr_file } source;
> +default_role { dir } source;
> +default_role { fifo_file } source;
> +default_role { file } source;
> +default_role { lnk_file } source;
> +default_role { sock_file } source;
> +type sys_isid;
> +typealias sys_isid alias { dpkg_script_t rpm_script_t };
> +allow sys_isid self : process { dyntransition transition };
> +role sys_role;
> +role sys_role types { sys_isid };
> +user sys_user roles sys_role;
> +sid kernel sys_user:sys_role:sys_isid
> +sid security sys_user:sys_role:sys_isid
> +sid unlabeled sys_user:sys_role:sys_isid
> +sid file sys_user:sys_role:sys_isid
> +sid port sys_user:sys_role:sys_isid
> +sid netif sys_user:sys_role:sys_isid
> +sid netmsg sys_user:sys_role:sys_isid
> +sid node sys_user:sys_role:sys_isid
> +sid devnull sys_user:sys_role:sys_isid
> +fs_use_trans devpts sys_user:sys_role:sys_isid;
> +fs_use_trans devtmpfs sys_user:sys_role:sys_isid;
> diff --git a/checkpolicy/fuzz/min_pol.mls.conf b/checkpolicy/fuzz/min_pol=
.mls.conf
> new file mode 100644
> index 00000000..6d15846b
> --- /dev/null
> +++ b/checkpolicy/fuzz/min_pol.mls.conf
> @@ -0,0 +1,65 @@
> +class process
> +class blk_file
> +class chr_file
> +class dir
> +class fifo_file
> +class file
> +class lnk_file
> +class sock_file
> +sid kernel
> +sid security
> +sid unlabeled
> +sid fs
> +sid file
> +sid file_labels
> +sid init
> +sid any_socket
> +sid port
> +sid netif
> +sid netmsg
> +sid node
> +sid igmp_packet
> +sid icmp_socket
> +sid tcp_socket
> +sid sysctl_modprobe
> +sid sysctl
> +sid sysctl_fs
> +sid sysctl_kernel
> +sid sysctl_net
> +sid sysctl_net_unix
> +sid sysctl_vm
> +sid sysctl_dev
> +sid kmod
> +sid policy
> +sid scmp_packet
> +sid devnull
> +class process { dyntransition transition }
> +default_role { blk_file } source;
> +default_role { chr_file } source;
> +default_role { dir } source;
> +default_role { fifo_file } source;
> +default_role { file } source;
> +default_role { lnk_file } source;
> +default_role { sock_file } source;
> +sensitivity s0;
> +dominance { s0 }
> +category c0;
> +level s0:c0;
> +mlsconstrain process transition t1 eq t2;
> +type sys_isid;
> +typealias sys_isid alias { dpkg_script_t rpm_script_t };
> +allow sys_isid self : process { dyntransition transition };
> +role sys_role;
> +role sys_role types { sys_isid };
> +user sys_user roles sys_role level s0 range s0 - s0:c0;
> +sid kernel sys_user:sys_role:sys_isid:s0
> +sid security sys_user:sys_role:sys_isid:s0
> +sid unlabeled sys_user:sys_role:sys_isid:s0
> +sid file sys_user:sys_role:sys_isid:s0
> +sid port sys_user:sys_role:sys_isid:s0
> +sid netif sys_user:sys_role:sys_isid:s0
> +sid netmsg sys_user:sys_role:sys_isid:s0
> +sid node sys_user:sys_role:sys_isid:s0
> +sid devnull sys_user:sys_role:sys_isid:s0
> +fs_use_trans devpts sys_user:sys_role:sys_isid:s0;
> +fs_use_trans devtmpfs sys_user:sys_role:sys_isid:s0;
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 3188af89..74a9f93c 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -1492,3 +1492,14 @@ static void pop_stack(void)
>         free(stack_top);
>         stack_top =3D parent;
>  }
> +
> +#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> +void module_compiler_reset(void)
> +{
> +       while (stack_top)
> +               pop_stack();
> +
> +       last_block =3D NULL;
> +       next_decl_id =3D 1;
> +}
> +#endif
> diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.=
h
> index 29b824b4..e43bc6c0 100644
> --- a/checkpolicy/module_compiler.h
> +++ b/checkpolicy/module_compiler.h
> @@ -106,4 +106,8 @@ int begin_optional_else(int pass);
>   * return -1. */
>  int end_avrule_block(int pass);
>
> +#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> +void module_compiler_reset(void);
> +#endif
> +
>  #endif
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index c998ff8b..19c05a58 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -312,6 +312,7 @@ GLBLUB                              { return(GLBLUB);=
 }
>  %%
>  int yyerror(const char *msg)
>  {
> +#ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
>         if (source_file[0])
>                 fprintf(stderr, "%s:%lu:",
>                         source_file, source_lineno);
> @@ -322,6 +323,10 @@ int yyerror(const char *msg)
>                         yytext,
>                         policydb_lineno,
>                         linebuf[0], linebuf[1]);
> +#else
> +       (void)msg;
> +#endif
> +
>         policydb_errors++;
>         return -1;
>  }
> @@ -331,6 +336,7 @@ int yywarn(const char *msg)
>         if (werror)
>                 return yyerror(msg);
>
> +#ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
>         if (source_file[0])
>                 fprintf(stderr, "%s:%lu:",
>                         source_file, source_lineno);
> @@ -341,6 +347,8 @@ int yywarn(const char *msg)
>                         yytext,
>                         policydb_lineno,
>                         linebuf[0], linebuf[1]);
> +#endif
> +
>         return 0;
>  }
>
> diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
> index 72d275e8..069f130a 100755
> --- a/scripts/oss-fuzz.sh
> +++ b/scripts/oss-fuzz.sh
> @@ -70,3 +70,17 @@ $CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/bin=
policy-fuzzer.c
>  $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/lib/=
libsepol.a" -o "$OUT/binpolicy-fuzzer"
>
>  zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
> +
> +## checkpolicy fuzzer ##
> +
> +make -C checkpolicy clean
> +make -C checkpolicy V=3D1 -j"$(nproc)" checkobjects
> +# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepte=
d by
> +# the compiler/linker so they shouldn't be quoted
> +# shellcheck disable=3DSC2086
> +$CC $CFLAGS -Icheckpolicy/ -c -o checkpolicy-fuzzer.o checkpolicy/fuzz/c=
heckpolicy-fuzzer.c
> +# shellcheck disable=3DSC2086
> +$CXX $CXXFLAGS $LIB_FUZZING_ENGINE checkpolicy-fuzzer.o checkpolicy/*.o =
"$DESTDIR/usr/lib/libsepol.a" -o "$OUT/checkpolicy-fuzzer"
> +
> +zip -j "$OUT/checkpolicy-fuzzer_seed_corpus.zip" checkpolicy/fuzz/min_po=
l.mls.conf
> +cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
> --
> 2.43.0
>
>
