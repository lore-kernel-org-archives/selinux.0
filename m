Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E1BEB64D7
	for <selinux@archiver.kernel.org>; Fri, 30 Jun 2023 10:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjF3KBU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjF3KAx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jun 2023 06:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5811BE1
        for <selinux@vger.kernel.org>; Fri, 30 Jun 2023 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688119201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Je2ldVk+X/pAqkgSEV4HSArBXFKo4v4/rQ9P22ocW5o=;
        b=dGNtZ6TsaIBpTs25ww32CXHds1Eqb45IjguLOPAeAArVA/0chsctQ9yoFk/SJ3+U1Hryps
        O2WvDFS4vc6Lzq3a+9yKxnFLWreBW7KHElmjHxQKtm6r43wmpnnNzXBxuk/NOxwXszIfjS
        khK/FWF+AHFnwhH9eam74t5drFD6u+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-ZnF1gwQpOb6Pe495mlXtMg-1; Fri, 30 Jun 2023 05:59:59 -0400
X-MC-Unique: ZnF1gwQpOb6Pe495mlXtMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A8C2800B35;
        Fri, 30 Jun 2023 09:59:59 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48B4B492C13;
        Fri, 30 Jun 2023 09:59:59 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2] checkpolicy: add option to skip checking neverallow
 rules
In-Reply-To: <CAP+JOzTUSw7s0N5fqFUwCNmhrxpNLa4uA9y1r67Vx7_FkFd2pA@mail.gmail.com>
References: <20230331173442.101678-1-cgzones@googlemail.com>
 <20230512095749.59577-1-cgzones@googlemail.com>
 <CAP+JOzTUSw7s0N5fqFUwCNmhrxpNLa4uA9y1r67Vx7_FkFd2pA@mail.gmail.com>
Date:   Fri, 30 Jun 2023 11:59:58 +0200
Message-ID: <874jmp1d9d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, May 12, 2023 at 5:59=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> Add the command line argument `-N/--disable-neverallow`, similar to
>> secilc(8), to checkpolicy(8) and checkmodule(8) to skip the check of
>> neverallow rule violations.
>>
>> This is mainly useful in development, e.g. to quickly add rules to a
>> policy without fulfilling all neverallow rules or build policies with
>> known violations.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

merged, thanks


>> ---
>> v2:
>>    invert variable logic from check_neverallow to disable_neverallow
>> ---
>>  checkpolicy/checkmodule.8 |  5 ++++-
>>  checkpolicy/checkmodule.c | 13 +++++++++----
>>  checkpolicy/checkpolicy.8 |  5 ++++-
>>  checkpolicy/checkpolicy.c | 12 ++++++++----
>>  4 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
>> index 1061a6f2..ed9efd4c 100644
>> --- a/checkpolicy/checkmodule.8
>> +++ b/checkpolicy/checkmodule.8
>> @@ -3,7 +3,7 @@
>>  checkmodule \- SELinux policy module compiler
>>  .SH SYNOPSIS
>>  .B checkmodule
>> -.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-U handl=
e_unknown] [\-V] [\-o output_file] [input_file]"
>> +.I "[\-h] [\-b] [\-c policy_version] [\-C] [\-E] [\-m] [\-M] [\-N] [\-U=
 handle_unknown] [\-V] [\-o output_file] [input_file]"
>>  .SH "DESCRIPTION"
>>  This manual page describes the
>>  .BR checkmodule
>> @@ -43,6 +43,9 @@ Generate a non-base policy module.
>>  .B \-M,\-\-mls
>>  Enable the MLS/MCS support when checking and compiling the policy modul=
e.
>>  .TP
>> +.B \-N,\-\-disable-neverallow
>> +Do not check neverallow rules.
>> +.TP
>>  .B \-V,\-\-version
>>  Show policy versions created by this program.
>>  .TP
>> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
>> index 3432608b..14e6c891 100644
>> --- a/checkpolicy/checkmodule.c
>> +++ b/checkpolicy/checkmodule.c
>> @@ -123,7 +123,7 @@ static int write_binary_policy(policydb_t * p, FILE =
*outfp)
>>
>>  static __attribute__((__noreturn__)) void usage(const char *progname)
>>  {
>> -       printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] =
[-m] [-M] [-o FILE] [-c VERSION] [INPUT]\n", progname);
>> +       printf("usage:  %s [-h] [-V] [-b] [-C] [-E] [-U handle_unknown] =
[-m] [-M] [-N] [-o FILE] [-c VERSION] [INPUT]\n", progname);
>>         printf("Build base and policy modules.\n");
>>         printf("Options:\n");
>>         printf("  INPUT      build module from INPUT (else read from \"%=
s\")\n",
>> @@ -139,6 +139,7 @@ static __attribute__((__noreturn__)) void usage(cons=
t char *progname)
>>         printf("               allow: Allow unknown kernel checks\n");
>>         printf("  -m         build a policy module instead of a base mod=
ule\n");
>>         printf("  -M         enable MLS policy\n");
>> +       printf("  -N         do not check neverallow rules\n");
>>         printf("  -o FILE    write module to FILE (else just check synta=
x)\n");
>>         printf("  -c VERSION build a policy module targeting a modular p=
olicy version (%d-%d)\n",
>>                MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
>> @@ -148,7 +149,7 @@ static __attribute__((__noreturn__)) void usage(cons=
t char *progname)
>>  int main(int argc, char **argv)
>>  {
>>         const char *file =3D txtfile, *outfile =3D NULL;
>> -       unsigned int binary =3D 0, cil =3D 0;
>> +       unsigned int binary =3D 0, cil =3D 0, disable_neverallow =3D 0;
>>         int ch;
>>         int show_version =3D 0;
>>         policydb_t modpolicydb;
>> @@ -159,12 +160,13 @@ int main(int argc, char **argv)
>>                 {"version", no_argument, NULL, 'V'},
>>                 {"handle-unknown", required_argument, NULL, 'U'},
>>                 {"mls", no_argument, NULL, 'M'},
>> +               {"disable-neverallow", no_argument, NULL, 'N'},
>>                 {"cil", no_argument, NULL, 'C'},
>>                 {"werror", no_argument, NULL, 'E'},
>>                 {NULL, 0, NULL, 0}
>>         };
>>
>> -       while ((ch =3D getopt_long(argc, argv, "ho:bVEU:mMCc:", long_opt=
ions, NULL)) !=3D -1) {
>> +       while ((ch =3D getopt_long(argc, argv, "ho:bVEU:mMNCc:", long_op=
tions, NULL)) !=3D -1) {
>>                 switch (ch) {
>>                 case 'h':
>>                         usage(argv[0]);
>> @@ -202,6 +204,9 @@ int main(int argc, char **argv)
>>                 case 'M':
>>                         mlspol =3D 1;
>>                         break;
>> +               case 'N':
>> +                       disable_neverallow =3D 1;
>> +                       break;
>>                 case 'C':
>>                         cil =3D 1;
>>                         break;
>> @@ -317,7 +322,7 @@ int main(int argc, char **argv)
>>                         fprintf(stderr, "%s:  link modules failed\n", ar=
gv[0]);
>>                         exit(1);
>>                 }
>> -               if (expand_module(NULL, &modpolicydb, &kernpolicydb, 0, =
1)) {
>> +               if (expand_module(NULL, &modpolicydb, &kernpolicydb, /*v=
erbose=3D*/0, !disable_neverallow)) {
>>                         fprintf(stderr, "%s:  expand module failed\n", a=
rgv[0]);
>>                         exit(1);
>>                 }
>> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
>> index 2984c238..c66e084b 100644
>> --- a/checkpolicy/checkpolicy.8
>> +++ b/checkpolicy/checkpolicy.8
>> @@ -3,7 +3,7 @@
>>  checkpolicy \- SELinux policy compiler
>>  .SH SYNOPSIS
>>  .B checkpolicy
>> -.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M]=
 [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,=
xen)] [\-O] [\-E] [\-V] [input_file]"
>> +.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M]=
 [\-N] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (se=
linux,xen)] [\-O] [\-E] [\-V] [input_file]"
>>  .br
>>  .SH "DESCRIPTION"
>>  This manual page describes the
>> @@ -38,6 +38,9 @@ Specify how the kernel should handle unknown classes o=
r permissions (deny, allow
>>  .B \-M,\-\-mls
>>  Enable the MLS policy when checking and compiling the policy.
>>  .TP
>> +.B \-N,\-\-disable-neverallow
>> +Do not check neverallow rules.
>> +.TP
>>  .B \-c policyvers
>>  Specify the policy version, defaults to the latest.
>>  .TP
>> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
>> index 2485142d..623ba8b2 100644
>> --- a/checkpolicy/checkpolicy.c
>> +++ b/checkpolicy/checkpolicy.c
>> @@ -109,7 +109,7 @@ static __attribute__((__noreturn__)) void usage(cons=
t char *progname)
>>  {
>>         printf
>>             ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,den=
y,reject)] [-M] "
>> -            "[-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
>> +            "[-N] [-c policyvers (%d-%d)] [-o output_file|-] [-S] [-O] "
>>              "[-t target_platform (selinux,xen)] [-E] [-V] [input_file]\=
n",
>>              progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>>         exit(1);
>> @@ -393,7 +393,7 @@ int main(int argc, char **argv)
>>         size_t scontext_len, pathlen;
>>         unsigned int i;
>>         unsigned int protocol, port;
>> -       unsigned int binary =3D 0, debug =3D 0, sort =3D 0, cil =3D 0, c=
onf =3D 0, optimize =3D 0;
>> +       unsigned int binary =3D 0, debug =3D 0, sort =3D 0, cil =3D 0, c=
onf =3D 0, optimize =3D 0, disable_neverallow =3D 0;
>>         struct val_to_name v;
>>         int ret, ch, fd, target =3D SEPOL_TARGET_SELINUX;
>>         unsigned int nel, uret;
>> @@ -415,6 +415,7 @@ int main(int argc, char **argv)
>>                 {"version", no_argument, NULL, 'V'},
>>                 {"handle-unknown", required_argument, NULL, 'U'},
>>                 {"mls", no_argument, NULL, 'M'},
>> +               {"disable-neverallow", no_argument, NULL, 'N'},
>>                 {"cil", no_argument, NULL, 'C'},
>>                 {"conf",no_argument, NULL, 'F'},
>>                 {"sort", no_argument, NULL, 'S'},
>> @@ -424,7 +425,7 @@ int main(int argc, char **argv)
>>                 {NULL, 0, NULL, 0}
>>         };
>>
>> -       while ((ch =3D getopt_long(argc, argv, "o:t:dbU:MCFSVc:OEh", lon=
g_options, NULL)) !=3D -1) {
>> +       while ((ch =3D getopt_long(argc, argv, "o:t:dbU:MNCFSVc:OEh", lo=
ng_options, NULL)) !=3D -1) {
>>                 switch (ch) {
>>                 case 'o':
>>                         outfile =3D optarg;
>> @@ -473,6 +474,9 @@ int main(int argc, char **argv)
>>                 case 'M':
>>                         mlspol =3D 1;
>>                         break;
>> +               case 'N':
>> +                       disable_neverallow =3D 1;
>> +                       break;
>>                 case 'C':
>>                         cil =3D 1;
>>                         break;
>> @@ -630,7 +634,7 @@ int main(int argc, char **argv)
>>                                 fprintf(stderr, "%s:  policydb_init fail=
ed\n", argv[0]);
>>                                 exit(1);
>>                         }
>> -                       if (expand_module(NULL, policydbp, &policydb, 0,=
 1)) {
>> +                       if (expand_module(NULL, policydbp, &policydb, /*=
verbose=3D*/0, !disable_neverallow)) {
>>                                 fprintf(stderr, "Error while expanding p=
olicy\n");
>>                                 exit(1);
>>                         }
>> --
>> 2.40.1
>>

