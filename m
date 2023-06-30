Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B68EEB64D7
	for <selinux@archiver.kernel.org>; Fri, 30 Jun 2023 08:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjF3Idf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjF3IdV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jun 2023 04:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6E170E
        for <selinux@vger.kernel.org>; Fri, 30 Jun 2023 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688113950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2V1+o/RW0xWfHIDJrfxlywJIYGx4EaiDvD3vXaWStaU=;
        b=KdSQs971wq9p0Rd7U/e7bScr1KJ+QvFy802BjBSFVY1GiMkl8M4vn57SySmFy+tOZRqO89
        jdfhwCUnV3yD8DGU59sj/XOBGjFqflaGEVXpaQbvwwl/1JJauENRkcNusaUnO+s724cXuw
        Q/jrnu/M5fWbAHJ1fvgup++KSLrRDbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-OHyCGwaIPJmESaxeowNwcw-1; Fri, 30 Jun 2023 04:32:27 -0400
X-MC-Unique: OHyCGwaIPJmESaxeowNwcw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2651881B26;
        Fri, 30 Jun 2023 08:32:26 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74535492C13;
        Fri, 30 Jun 2023 08:32:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH userspace 1/2] libsepol: stop translating deprecated
 intial SIDs to strings
In-Reply-To: <CAP+JOzRBA3wfcm7oeMpisyS+KEMenNTfUq4Z=JGEm3qD1VXc6w@mail.gmail.com>
References: <20230612093107.1066410-1-omosnace@redhat.com>
 <20230612093107.1066410-2-omosnace@redhat.com>
 <CAP+JOzRBA3wfcm7oeMpisyS+KEMenNTfUq4Z=JGEm3qD1VXc6w@mail.gmail.com>
Date:   Fri, 30 Jun 2023 10:32:25 +0200
Message-ID: <87cz1d1hba.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Mon, Jun 12, 2023 at 5:50=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
>>
>> Many of the initial SIDs are no longer used by the kernel, so
>> translating them to the legacy names doesn't bring much value. Clear the
>> legacy names from the table and let the code translate them to the
>> fallback "unknown" names instead.
>>
>> Note that this only affects the generated text output when converting
>> policies from binary to text form. The text policy languages let the
>> policy define its own names for the initial SIDs based on the order in
>> which they are declared, so the table is never used to convert from name
>> to SID. Thus this is just a cosmetic change and has no functional
>> impact.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Both merged. Thanks!


>> ---
>>  libsepol/src/kernel_to_cil.c    |  4 ++--
>>  libsepol/src/kernel_to_common.h | 36 ++++++++++++++++-----------------
>>  libsepol/src/kernel_to_conf.c   |  4 ++--
>>  libsepol/src/module_to_cil.c    |  2 +-
>>  4 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index e9cd89c2..bd04c087 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -567,7 +567,7 @@ static int write_sids_to_cil(FILE *out, const char *=
const *sid_to_str,
>>
>>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>>                 i =3D isid->sid[0];
>> -               if (i < num_sids) {
>> +               if (i < num_sids && sid_to_str[i]) {
>>                         sid =3D (char *)sid_to_str[i];
>>                 } else {
>>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
>> @@ -2577,7 +2577,7 @@ static int write_sid_context_rules_to_cil(FILE *ou=
t, struct policydb *pdb, const
>>
>>         for (isid =3D pdb->ocontexts[0]; isid !=3D NULL; isid =3D isid->=
next) {
>>                 i =3D isid->sid[0];
>> -               if (i < num_sids) {
>> +               if (i < num_sids && sid_to_str[i]) {
>>                         sid =3D (char *)sid_to_str[i];
>>                 } else {
>>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
>> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_co=
mmon.h
>> index 159c4289..6073ff3a 100644
>> --- a/libsepol/src/kernel_to_common.h
>> +++ b/libsepol/src/kernel_to_common.h
>> @@ -13,33 +13,33 @@
>>  // initial sid names aren't actually stored in the pp files, need to a =
have
>>  // a mapping, taken from the linux kernel
>>  static const char * const selinux_sid_to_str[] =3D {
>> -       "null",
>> +       NULL,
>>         "kernel",
>>         "security",
>>         "unlabeled",
>> -       "fs",
>> +       NULL,
>>         "file",
>> -       "file_labels",
>> -       "init",
>> +       NULL,
>> +       NULL,
>>         "any_socket",
>>         "port",
>>         "netif",
>>         "netmsg",
>>         "node",
>> -       "igmp_packet",
>> -       "icmp_socket",
>> -       "tcp_socket",
>> -       "sysctl_modprobe",
>> -       "sysctl",
>> -       "sysctl_fs",
>> -       "sysctl_kernel",
>> -       "sysctl_net",
>> -       "sysctl_net_unix",
>> -       "sysctl_vm",
>> -       "sysctl_dev",
>> -       "kmod",
>> -       "policy",
>> -       "scmp_packet",
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>> +       NULL,
>>         "devnull",
>>  };
>>
>> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf=
.c
>> index c48a7114..3be87184 100644
>> --- a/libsepol/src/kernel_to_conf.c
>> +++ b/libsepol/src/kernel_to_conf.c
>> @@ -464,7 +464,7 @@ static int write_sids_to_conf(FILE *out, const char =
*const *sid_to_str,
>>
>>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>>                 i =3D isid->sid[0];
>> -               if (i < num_sids) {
>> +               if (i < num_sids && sid_to_str[i]) {
>>                         sid =3D (char *)sid_to_str[i];
>>                 } else {
>>                         snprintf(unknown, sizeof(unknown), "%s%u", "UNKN=
OWN", i);
>> @@ -2445,7 +2445,7 @@ static int write_sid_context_rules_to_conf(FILE *o=
ut, struct policydb *pdb, cons
>>
>>         for (isid =3D pdb->ocontexts[0]; isid !=3D NULL; isid =3D isid->=
next) {
>>                 i =3D isid->sid[0];
>> -               if (i < num_sids) {
>> +               if (i < num_sids && sid_to_str[i]) {
>>                         sid =3D (char *)sid_to_str[i];
>>                 } else {
>>                         snprintf(unknown, sizeof(unknown), "%s%u", "UNKN=
OWN", i);
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index e7bc6ee6..a46775ca 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -2549,7 +2549,7 @@ static int ocontext_isid_to_cil(struct policydb *p=
db, const char *const *sid_to_
>>
>>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>>                 i =3D isid->sid[0];
>> -               if (i < num_sids) {
>> +               if (i < num_sids && sid_to_string[i]) {
>>                         sid =3D (char*)sid_to_string[i];
>>                 } else {
>>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
>> --
>> 2.40.1
>>

