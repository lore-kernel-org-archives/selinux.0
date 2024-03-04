Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101948CC7
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579807; cv=none; b=mksqDRHgHVn910o/yilX/nc8EtUkAt4oWse1UuJfUu9jtF5HKpC0XDhouym8BM5QBpL169AeWqEKJS02lk8BJQZEyjQsmRVNQ1zHU1xTtKx4NdwuFxevg/h/gODTXk009gDe12yf8rpCZLST3V05usXqvAmkQcUH08cCoR11WKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579807; c=relaxed/simple;
	bh=i+09zj2ja6FNjFaxvP2omaFnkcGVjibmAMIronJGxeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChG1pInAt1GGwH1ElXbSzEwGx/4DO/PrfXNvHkWMMa5Fr1AoWA1t5TQWgihw1EMT6Alj9arsXGithXsjOO792gzJP4lemCplfV6il/IWDY3slhVsmleuFAdyDRmMQmxbnqunthXaHzuELDe2F0ZIEz+PVfXgFFi1KNWnWObE+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcthSQ05; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcthSQ05"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19dd9ade5so3011237b6e.3
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579805; x=1710184605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReA6sDTwPP/tpcsbbU4F6yt6kJL4w7SugrSJrsomdjw=;
        b=jcthSQ05VClHnIaqi0taXKAj3FU6JFRa8MH8b9mCNdOw/2erw0XYmw52Snn4ml84AF
         8sWKYcsQKVMQ6aB9+QCWqPygwaLYqF0Tai5iSbTDyaCqQOMus6WFV60KEIMcFt44AR1O
         XHUpewF78PZagZWCCFVBEAfZS6Vt451mb4CXa6OV8X9uFjvjCPWzLBM3+MYAAFTUe2/C
         MzMoEI/CwOMwss5uSa3ZDe4NahufY7VpLYif5HUEw3fkv5ZF6zsoqxhOW2wMBYUs+/E5
         VxrB/UxYoA7FaiMG+TRQQ1XmVj5ilmMTDHwLh2P3Fh04bsrkpHD3ThrBStXA/hAzbjCB
         ifYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579805; x=1710184605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReA6sDTwPP/tpcsbbU4F6yt6kJL4w7SugrSJrsomdjw=;
        b=A1A359pysoFkkiroQYPCiMj2GI4WX12My72jBoI15vkvgnxDJpqFlZplEYvNZa2H0K
         rzxaA64H6sGjco4mlBjJZmanINY+zM2BLET3FJhWy6Vjk3XkhXvc+tzhsunuRL09l2nF
         5/EY1owysNg9Jcr5dw6uO4tzAs4yAgP510HkYWBstSsiuoaT3duE5v1jq8L8jokwtmUU
         ZgflEwUyCEKCVADatK8PKufnQ89kYZ2psdD0we3cAbRLLfdmhwrHaVQ8zQwPtpP7ydAD
         2QivqcwWrX5MX6hLaRrR7qDxgGOKYS+GABhcBGfR4jSa9zfuexN9u6OxlVjnA6Eymf2/
         gRsQ==
X-Gm-Message-State: AOJu0YxjEshIjNDdnrbfO1lMrAZzi7erEvshTrobaFQaVEp0eokHv/Bs
	bZMrCDJrgf5eevQXx6QLLJu6M5VJvzJctcOLSriNMAHAm4VxKz8tL7mQTaVunycoRbYeW3HtD0G
	VVhUN7T1nwPIUtKWDlN7Th03E60xLVKQ/
X-Google-Smtp-Source: AGHT+IGSV5MlhNFMBsFI4jO8c/l5ibzVI2y+Oth2t8h4HL5eKuQ+fRFUC04mf/sAmtPtQNMpXsnn632cuohJ71A4hlA=
X-Received: by 2002:a05:6808:23d4:b0:3c1:bcab:c1bf with SMTP id
 bq20-20020a05680823d400b003c1bcabc1bfmr12089112oib.22.1709579804758; Mon, 04
 Mar 2024 11:16:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <CAP+JOzT5oAU+OpkEhmq1TTqpBDStQLq_vHaDdmWRBW0z1jQ7+w@mail.gmail.com>
In-Reply-To: <CAP+JOzT5oAU+OpkEhmq1TTqpBDStQLq_vHaDdmWRBW0z1jQ7+w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:16:33 -0500
Message-ID: <CAP+JOzSrpSqQ1O6Si5XA+ENVCszLJw2EZBatwTOzht7xKp7+pQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] checkpolicy: add libfuzz based fuzzer
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:33=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Introduce a libfuzz[1] based fuzzer testing the parsing and policy
> > generation code used within checkpolicy(8) and checkmodule(8), similar
> > to the fuzzer for secilc(8).
> > The fuzzer will work on generated source policy input and try to parse,
> > link, expand, optimize, sort and output it.
> > This fuzzer will also ensure policy validation is not too strict by
> > checking compilable source policies are valid.
> >
> > Build the fuzzer in the oss-fuzz script.
> >
> > [1]: https://llvm.org/docs/LibFuzzer.html
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  checkpolicy/Makefile                     |   3 +
> >  checkpolicy/fuzz/checkpolicy-fuzzer.c    | 274 +++++++++++++++++++++++
> >  checkpolicy/fuzz/checkpolicy-fuzzer.dict | 101 +++++++++
> >  checkpolicy/fuzz/min_pol.conf            |  60 +++++
> >  checkpolicy/fuzz/min_pol.mls.conf        |  65 ++++++
> >  checkpolicy/module_compiler.c            |  11 +
> >  checkpolicy/module_compiler.h            |   4 +
> >  checkpolicy/policy_scan.l                |   8 +
> >  scripts/oss-fuzz.sh                      |  14 ++
> >  9 files changed, 540 insertions(+)
> >  create mode 100644 checkpolicy/fuzz/checkpolicy-fuzzer.c
> >  create mode 100644 checkpolicy/fuzz/checkpolicy-fuzzer.dict
> >  create mode 100644 checkpolicy/fuzz/min_pol.conf
> >  create mode 100644 checkpolicy/fuzz/min_pol.mls.conf
> >
> > diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> > index 036ab905..6e8008e3 100644
> > --- a/checkpolicy/Makefile
> > +++ b/checkpolicy/Makefile
> > @@ -54,6 +54,9 @@ lex.yy.c: policy_scan.l y.tab.c
> >  test: checkpolicy
> >         ./tests/test_roundtrip.sh
> >
> > +# helper target for fuzzing
> > +checkobjects: $(CHECKOBJS)
> > +
> >  install: all
> >         -mkdir -p $(DESTDIR)$(BINDIR)
> >         -mkdir -p $(DESTDIR)$(MANDIR)/man8
> > diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/c=
heckpolicy-fuzzer.c
> > new file mode 100644
> > index 00000000..0d749a02
> > --- /dev/null
> > +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > @@ -0,0 +1,274 @@
> > +#include <assert.h>
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +
> > +#include <sepol/debug.h>
> > +#include <sepol/kernel_to_cil.h>
> > +#include <sepol/kernel_to_conf.h>
> > +#include <sepol/module_to_cil.h>
> > +#include <sepol/policydb/policydb.h>
> > +#include <sepol/policydb/hierarchy.h>
> > +#include <sepol/policydb/expand.h>
> > +#include <sepol/policydb/link.h>
> > +
> > +#include "module_compiler.h"
> > +#include "queue.h"
> > +
> > +extern int policydb_validate(sepol_handle_t *handle, const policydb_t =
*p);
> > +extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> > +
> > +extern int mlspol;
> > +extern policydb_t *policydbp;
> > +extern queue_t id_queue;
> > +extern unsigned int policydb_errors;
> > +
> > +extern int yynerrs;
> > +extern FILE *yyin;
> > +extern void init_parser(int);
> > +extern int yyparse(void);
> > +extern void yyrestart(FILE *);
> > +extern int yylex_destroy(void);
> > +extern void set_source_file(const char *name);
> > +
> > +
> > +// Set to 1 for verbose libsepol logging
> > +#define VERBOSE 0
> > +
> > +static ssize_t full_write(int fd, const void *buf, size_t count)
> > +{
> > +       ssize_t written =3D 0;
> > +
> > +       while (count > 0) {
> > +               ssize_t ret =3D write(fd, buf, count);
> > +               if (ret < 0) {
> > +                       if (errno =3D=3D EINTR)
> > +                               continue;
> > +
> > +                       return ret;
> > +               }
> > +
> > +               if (ret =3D=3D 0)
> > +                       break;
> > +
> > +               written +=3D ret;
> > +               buf =3D (const unsigned char *)buf + (size_t)ret;
> > +               count -=3D (size_t)ret;
> > +       }
> > +
> > +       return written;
> > +}
> > +
> > +static int read_source_policy(policydb_t *p, const uint8_t *data, size=
_t size)
> > +{
> > +       int fd, rc;
> > +       ssize_t wr;
> > +
> > +       fd =3D memfd_create("fuzz-input", MFD_CLOEXEC);
> > +       if (fd < 0)
> > +               return -1;
> > +
> > +       wr =3D full_write(fd, data, size);
> > +       if (wr < 0 || (size_t)wr !=3D size) {
> > +               close(fd);
> > +               return -1;
> > +       }
> > +
> > +       fsync(fd);
> > +
> > +       yynerrs =3D 0;
> > +
> > +       yyin =3D fdopen(fd, "r");
> > +       if (!yyin) {
> > +               close(fd);
> > +               return -1;
> > +       }
> > +
> > +       rewind(yyin);
> > +
> > +       set_source_file("fuzz-input");
> > +
> > +       id_queue =3D queue_create();
> > +       if (id_queue =3D=3D NULL) {
> > +               fclose(yyin);
> > +               yylex_destroy();
> > +               return -1;
> > +       }
> > +
> > +       policydbp =3D p;
> > +       mlspol =3D p->mls;
> > +
> > +       init_parser(1);
> > +
> > +       rc =3D yyparse();
> > +       // TODO: drop global variable policydb_errors if proven to be r=
edundant
> > +       assert(rc || !policydb_errors);
> > +       if (rc || policydb_errors) {
> > +               queue_destroy(id_queue);
> > +               fclose(yyin);
> > +               yylex_destroy();
> > +               return -1;
> > +       }
> > +
> > +       rewind(yyin);
> > +       init_parser(2);
> > +       set_source_file("fuzz-input");
> > +       yyrestart(yyin);
> > +
> > +       rc =3D yyparse();
> > +       assert(rc || !policydb_errors);
> > +       if (rc || policydb_errors) {
> > +               queue_destroy(id_queue);
> > +               fclose(yyin);
> > +               yylex_destroy();
> > +               return -1;
> > +       }
> > +
> > +       queue_destroy(id_queue);
> > +       fclose(yyin);
> > +       yylex_destroy();
> > +
> > +       return 0;
> > +}
> > +
> > +static int check_level(hashtab_key_t key, hashtab_datum_t datum, void =
*arg __attribute__ ((unused)))
> > +{
> > +       const level_datum_t *levdatum =3D (level_datum_t *) datum;
> > +
> > +       // TODO: drop member defined if proven to be always set
> > +       if (!levdatum->isalias && !levdatum->defined) {
> > +               fprintf(stderr,
> > +                       "Error:  sensitivity %s was not used in a level=
 definition!\n",
> > +                       key);
> > +               abort();
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int write_binary_policy(FILE *outfp, policydb_t *p)
> > +{
> > +       struct policy_file pf;
> > +
> > +       policy_file_init(&pf);
> > +       pf.type =3D PF_USE_STDIO;
> > +       pf.fp =3D outfp;
> > +       return policydb_write(p, &pf);
> > +}
> > +
> > +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> > +{
> > +       policydb_t parsepolicydb =3D {};
> > +       policydb_t kernpolicydb =3D {};
> > +       policydb_t *finalpolicydb;
> > +       sidtab_t sidtab =3D {};
> > +       FILE *devnull =3D NULL;
> > +       int mls, policyvers;
> > +
> > +       sepol_debug(VERBOSE);
> > +
> > +       /* Take the first byte whether to parse as MLS policy
> > +       * and the second byte as policy version. */
> > +       if (size < 2)
> > +               return 0;
> > +       switch (data[0]) {
> > +       case '0':
> > +               mls =3D 0;
> > +               break;
> > +       case '1':
> > +               mls =3D 1;
> > +               break;
> > +       default:
> > +               return 0;
> > +       }
> > +       static_assert(0x7F - 'A' >=3D POLICYDB_VERSION_MAX, "Max policy=
 version should be representable");
> > +       policyvers =3D data[1] - 'A';
> > +       if (policyvers < POLICYDB_VERSION_MIN || policyvers > POLICYDB_=
VERSION_MAX)
> > +               return 0;
> > +       data +=3D 2;
> > +       size -=3D 2;
> > +
> > +       if (policydb_init(&parsepolicydb))
> > +               goto exit;
> > +
> > +       parsepolicydb.policy_type =3D POLICY_BASE;
> > +       parsepolicydb.mls =3D mls;
> > +       parsepolicydb.handle_unknown =3D DENY_UNKNOWN;
> > +       policydb_set_target_platform(&parsepolicydb, SEPOL_TARGET_SELIN=
UX);
> > +
> > +       if (read_source_policy(&parsepolicydb, data, size))
> > +               goto exit;
> > +
> > +       (void) hashtab_map(parsepolicydb.p_levels.table, check_level, N=
ULL);
> > +
> > +       if (parsepolicydb.policy_type =3D=3D POLICY_BASE) {
> > +               if (link_modules(NULL, &parsepolicydb, NULL, 0, VERBOSE=
))
> > +                       goto exit;
> > +
> > +               if (policydb_init(&kernpolicydb))
> > +                       goto exit;
> > +
> > +               if (expand_module(NULL, &parsepolicydb, &kernpolicydb, =
VERBOSE, /*check_assertions=3D*/0))
> > +                       goto exit;
> > +
> > +               (void) check_assertions(NULL, &kernpolicydb, kernpolicy=
db.global->branch_list->avrules);
> > +               (void) hierarchy_check_constraints(NULL, &kernpolicydb)=
;
> > +
> > +               kernpolicydb.policyvers =3D policyvers;
> > +
> > +               assert(kernpolicydb.policy_type    =3D=3D POLICY_KERN);
> > +               assert(kernpolicydb.handle_unknown =3D=3D SEPOL_DENY_UN=
KNOWN);
> > +               assert(kernpolicydb.mls            =3D=3D mls);
> > +
> > +               finalpolicydb =3D &kernpolicydb;
> > +       } else {
> > +               assert(parsepolicydb.policy_type    =3D=3D POLICY_MOD);
> > +               assert(parsepolicydb.handle_unknown =3D=3D SEPOL_DENY_U=
NKNOWN);
> > +               assert(parsepolicydb.mls            =3D=3D mls);
> > +
> > +               finalpolicydb =3D &parsepolicydb;
> > +       }
> > +
> > +       if (policydb_load_isids(finalpolicydb, &sidtab))
> > +               goto exit;
> > +
> > +       if (finalpolicydb->policy_type =3D=3D POLICY_KERN && policydb_o=
ptimize(finalpolicydb))
> > +               goto exit;
> > +
> > +       if (policydb_sort_ocontexts(finalpolicydb))
> > +               goto exit;
> > +
> > +       if (policydb_validate(NULL, finalpolicydb))
> > +               /* never generate an invalid policy */
> > +               abort();
> > +
> > +       devnull =3D fopen("/dev/null", "we");
> > +       if (devnull =3D=3D NULL)
> > +               goto exit;
> > +
> > +       if (write_binary_policy(devnull, finalpolicydb))
> > +               abort();
> > +
> > +       if (finalpolicydb->policy_type =3D=3D POLICY_KERN && sepol_kern=
el_policydb_to_conf(devnull, finalpolicydb))
> > +               abort();
> > +
> > +       if (finalpolicydb->policy_type =3D=3D POLICY_KERN && sepol_kern=
el_policydb_to_cil(devnull, finalpolicydb))
> > +               abort();
> > +
> > +       if (finalpolicydb->policy_type =3D=3D POLICY_MOD && sepol_modul=
e_policydb_to_cil(devnull, finalpolicydb, /*linked=3D*/0))
> > +               abort();
> > +
> > +exit:
> > +       if (devnull !=3D NULL)
> > +               fclose(devnull);
> > +
> > +       sepol_sidtab_destroy(&sidtab);
> > +       policydb_destroy(&kernpolicydb);
> > +       policydb_destroy(&parsepolicydb);
> > +
> > +       id_queue =3D NULL;
> > +       policydbp =3D NULL;
> > +       module_compiler_reset();
> > +
> > +       /* Non-zero return values are reserved for future use. */
> > +       return 0;
> > +}
> > diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.dict b/checkpolicy/fuz=
z/checkpolicy-fuzzer.dict
> > new file mode 100644
> > index 00000000..fb7e66c0
> > --- /dev/null
> > +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
> > @@ -0,0 +1,101 @@
> > +# Keyword dictionary
> > +
> > +"clone"
> > +"common"
> > +"class"
> > +"constrain"
> > +"validatetrans"
> > +"inherits"
> > +"sid"
> > +"role"
> > +"roles"
> > +"roleattribute"
> > +"attribute_role"
> > +"types"
> > +"typealias"
> > +"typeattribute"
> > +"typebounds"
> > +"type"
> > +"bool"
> > +"tunable"
> > +"if"
> > +"else"
> > +"alias"
> > +"attribute"
> > +"expandattribute"
> > +"type_transition"
> > +"type_member"
> > +"type_change"
> > +"role_transition"
> > +"range_transition"
> > +"sensitivity"
> > +"dominance"
> > +"category"
> > +"level"
> > +"range"
> > +"mlsconstrain"
> > +"mlsvalidatetrans"
> > +"user"
> > +"neverallow"
> > +"allow"
> > +"auditallow"
> > +"auditdeny"
> > +"dontaudit"
> > +"allowxperm"
> > +"auditallowxperm"
> > +"dontauditxperm"
> > +"neverallowxperm"
> > +"source"
> > +"target"
> > +"sameuser"
> > +"module"
> > +"require"
> > +"optional"
> > +"or"
> > +"and"
> > +"not"
> > +"xor"
> > +"eq"
> > +"true"
> > +"false"
> > +"dom"
> > +"domby"
> > +"incomp"
> > +"fscon"
> > +"ibpkeycon"
> > +"ibendportcon"
> > +"portcon"
> > +"netifcon"
> > +"nodecon"
> > +"pirqcon"
> > +"iomemcon"
> > +"ioportcon"
> > +"pcidevicecon"
> > +"devicetreecon"
> > +"fs_use_xattr"
> > +"fs_use_task"
> > +"fs_use_trans"
> > +"genfscon"
> > +"r1"
> > +"r2"
> > +"r3"
> > +"u1"
> > +"u2"
> > +"u3"
> > +"t1"
> > +"t2"
> > +"t3"
> > +"l1"
> > +"l2"
> > +"h1"
> > +"h2"
> > +"policycap"
> > +"permissive"
> > +"default_user"
> > +"default_role"
> > +"default_type"
> > +"default_range"
> > +"low-high"
> > +"high"
> > +"low"
> > +"glblub"
> > diff --git a/checkpolicy/fuzz/min_pol.conf b/checkpolicy/fuzz/min_pol.c=
onf
> > new file mode 100644
> > index 00000000..ff6d50e5
> > --- /dev/null
> > +++ b/checkpolicy/fuzz/min_pol.conf
> > @@ -0,0 +1,60 @@
> > +class process
> > +class blk_file
> > +class chr_file
> > +class dir
> > +class fifo_file
> > +class file
> > +class lnk_file
> > +class sock_file
> > +sid kernel
> > +sid security
> > +sid unlabeled
> > +sid fs
> > +sid file
> > +sid file_labels
> > +sid init
> > +sid any_socket
> > +sid port
> > +sid netif
> > +sid netmsg
> > +sid node
> > +sid igmp_packet
> > +sid icmp_socket
> > +sid tcp_socket
> > +sid sysctl_modprobe
> > +sid sysctl
> > +sid sysctl_fs
> > +sid sysctl_kernel
> > +sid sysctl_net
> > +sid sysctl_net_unix
> > +sid sysctl_vm
> > +sid sysctl_dev
> > +sid kmod
> > +sid policy
> > +sid scmp_packet
> > +sid devnull
> > +class process { dyntransition transition }
> > +default_role { blk_file } source;
> > +default_role { chr_file } source;
> > +default_role { dir } source;
> > +default_role { fifo_file } source;
> > +default_role { file } source;
> > +default_role { lnk_file } source;
> > +default_role { sock_file } source;
> > +type sys_isid;
> > +typealias sys_isid alias { dpkg_script_t rpm_script_t };
> > +allow sys_isid self : process { dyntransition transition };
> > +role sys_role;
> > +role sys_role types { sys_isid };
> > +user sys_user roles sys_role;
> > +sid kernel sys_user:sys_role:sys_isid
> > +sid security sys_user:sys_role:sys_isid
> > +sid unlabeled sys_user:sys_role:sys_isid
> > +sid file sys_user:sys_role:sys_isid
> > +sid port sys_user:sys_role:sys_isid
> > +sid netif sys_user:sys_role:sys_isid
> > +sid netmsg sys_user:sys_role:sys_isid
> > +sid node sys_user:sys_role:sys_isid
> > +sid devnull sys_user:sys_role:sys_isid
> > +fs_use_trans devpts sys_user:sys_role:sys_isid;
> > +fs_use_trans devtmpfs sys_user:sys_role:sys_isid;
> > diff --git a/checkpolicy/fuzz/min_pol.mls.conf b/checkpolicy/fuzz/min_p=
ol.mls.conf
> > new file mode 100644
> > index 00000000..6d15846b
> > --- /dev/null
> > +++ b/checkpolicy/fuzz/min_pol.mls.conf
> > @@ -0,0 +1,65 @@
> > +class process
> > +class blk_file
> > +class chr_file
> > +class dir
> > +class fifo_file
> > +class file
> > +class lnk_file
> > +class sock_file
> > +sid kernel
> > +sid security
> > +sid unlabeled
> > +sid fs
> > +sid file
> > +sid file_labels
> > +sid init
> > +sid any_socket
> > +sid port
> > +sid netif
> > +sid netmsg
> > +sid node
> > +sid igmp_packet
> > +sid icmp_socket
> > +sid tcp_socket
> > +sid sysctl_modprobe
> > +sid sysctl
> > +sid sysctl_fs
> > +sid sysctl_kernel
> > +sid sysctl_net
> > +sid sysctl_net_unix
> > +sid sysctl_vm
> > +sid sysctl_dev
> > +sid kmod
> > +sid policy
> > +sid scmp_packet
> > +sid devnull
> > +class process { dyntransition transition }
> > +default_role { blk_file } source;
> > +default_role { chr_file } source;
> > +default_role { dir } source;
> > +default_role { fifo_file } source;
> > +default_role { file } source;
> > +default_role { lnk_file } source;
> > +default_role { sock_file } source;
> > +sensitivity s0;
> > +dominance { s0 }
> > +category c0;
> > +level s0:c0;
> > +mlsconstrain process transition t1 eq t2;
> > +type sys_isid;
> > +typealias sys_isid alias { dpkg_script_t rpm_script_t };
> > +allow sys_isid self : process { dyntransition transition };
> > +role sys_role;
> > +role sys_role types { sys_isid };
> > +user sys_user roles sys_role level s0 range s0 - s0:c0;
> > +sid kernel sys_user:sys_role:sys_isid:s0
> > +sid security sys_user:sys_role:sys_isid:s0
> > +sid unlabeled sys_user:sys_role:sys_isid:s0
> > +sid file sys_user:sys_role:sys_isid:s0
> > +sid port sys_user:sys_role:sys_isid:s0
> > +sid netif sys_user:sys_role:sys_isid:s0
> > +sid netmsg sys_user:sys_role:sys_isid:s0
> > +sid node sys_user:sys_role:sys_isid:s0
> > +sid devnull sys_user:sys_role:sys_isid:s0
> > +fs_use_trans devpts sys_user:sys_role:sys_isid:s0;
> > +fs_use_trans devtmpfs sys_user:sys_role:sys_isid:s0;
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 3188af89..74a9f93c 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -1492,3 +1492,14 @@ static void pop_stack(void)
> >         free(stack_top);
> >         stack_top =3D parent;
> >  }
> > +
> > +#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> > +void module_compiler_reset(void)
> > +{
> > +       while (stack_top)
> > +               pop_stack();
> > +
> > +       last_block =3D NULL;
> > +       next_decl_id =3D 1;
> > +}
> > +#endif
> > diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compile=
r.h
> > index 29b824b4..e43bc6c0 100644
> > --- a/checkpolicy/module_compiler.h
> > +++ b/checkpolicy/module_compiler.h
> > @@ -106,4 +106,8 @@ int begin_optional_else(int pass);
> >   * return -1. */
> >  int end_avrule_block(int pass);
> >
> > +#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> > +void module_compiler_reset(void);
> > +#endif
> > +
> >  #endif
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index c998ff8b..19c05a58 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -312,6 +312,7 @@ GLBLUB                              { return(GLBLUB=
); }
> >  %%
> >  int yyerror(const char *msg)
> >  {
> > +#ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> >         if (source_file[0])
> >                 fprintf(stderr, "%s:%lu:",
> >                         source_file, source_lineno);
> > @@ -322,6 +323,10 @@ int yyerror(const char *msg)
> >                         yytext,
> >                         policydb_lineno,
> >                         linebuf[0], linebuf[1]);
> > +#else
> > +       (void)msg;
> > +#endif
> > +
> >         policydb_errors++;
> >         return -1;
> >  }
> > @@ -331,6 +336,7 @@ int yywarn(const char *msg)
> >         if (werror)
> >                 return yyerror(msg);
> >
> > +#ifndef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> >         if (source_file[0])
> >                 fprintf(stderr, "%s:%lu:",
> >                         source_file, source_lineno);
> > @@ -341,6 +347,8 @@ int yywarn(const char *msg)
> >                         yytext,
> >                         policydb_lineno,
> >                         linebuf[0], linebuf[1]);
> > +#endif
> > +
> >         return 0;
> >  }
> >
> > diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
> > index 72d275e8..069f130a 100755
> > --- a/scripts/oss-fuzz.sh
> > +++ b/scripts/oss-fuzz.sh
> > @@ -70,3 +70,17 @@ $CC $CFLAGS -c -o binpolicy-fuzzer.o libsepol/fuzz/b=
inpolicy-fuzzer.c
> >  $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o "$DESTDIR/usr/li=
b/libsepol.a" -o "$OUT/binpolicy-fuzzer"
> >
> >  zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bi=
n
> > +
> > +## checkpolicy fuzzer ##
> > +
> > +make -C checkpolicy clean
> > +make -C checkpolicy V=3D1 -j"$(nproc)" checkobjects
> > +# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accep=
ted by
> > +# the compiler/linker so they shouldn't be quoted
> > +# shellcheck disable=3DSC2086
> > +$CC $CFLAGS -Icheckpolicy/ -c -o checkpolicy-fuzzer.o checkpolicy/fuzz=
/checkpolicy-fuzzer.c
> > +# shellcheck disable=3DSC2086
> > +$CXX $CXXFLAGS $LIB_FUZZING_ENGINE checkpolicy-fuzzer.o checkpolicy/*.=
o "$DESTDIR/usr/lib/libsepol.a" -o "$OUT/checkpolicy-fuzzer"
> > +
> > +zip -j "$OUT/checkpolicy-fuzzer_seed_corpus.zip" checkpolicy/fuzz/min_=
pol.mls.conf
> > +cp checkpolicy/fuzz/checkpolicy-fuzzer.dict "$OUT/"
> > --
> > 2.43.0
> >
> >
