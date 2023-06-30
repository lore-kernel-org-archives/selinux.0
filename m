Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A908BEB64D7
	for <selinux@archiver.kernel.org>; Fri, 30 Jun 2023 12:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjF3M0P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjF3M0P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jun 2023 08:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1422728
        for <selinux@vger.kernel.org>; Fri, 30 Jun 2023 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688127922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR9n//WN6c0yzIx+Hemytk0cTmjOIS8invN8uO3E3XA=;
        b=a2yvThdAi+C5ejIItQZkENnjVqEm3qclSLsnbyU4XikjITw6GWShNFd8j2/eydwMftSQ1C
        b6oQ8tjNBBFqiqW2qK7vuCQw9bLFs5LndVMsm3hMrLXNBTsUW0pdGy3qTgGNhFBIyK5lkE
        rdpuq4n6unrSwyDHL46fOEumT3JGlB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-PhqbygFVOjKveCHvkmsuOA-1; Fri, 30 Jun 2023 08:25:21 -0400
X-MC-Unique: PhqbygFVOjKveCHvkmsuOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10915185A792;
        Fri, 30 Jun 2023 12:25:20 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C43A6F5CFD;
        Fri, 30 Jun 2023 12:25:19 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dismod: print the policy version only in
 interactive mode
In-Reply-To: <CAP+JOzQXyjmqh65=uXi18Z7_yNAg0ne0cPhxyXs7miqfb5F0Xg@mail.gmail.com>
References: <20230614191658.3356192-1-yamato@redhat.com>
 <CAP+JOzQXyjmqh65=uXi18Z7_yNAg0ne0cPhxyXs7miqfb5F0Xg@mail.gmail.com>
Date:   Fri, 30 Jun 2023 14:25:18 +0200
Message-ID: <87zg4hyw5t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Wed, Jun 14, 2023 at 3:23=E2=80=AFPM Masatake YAMATO <yamato@redhat.co=
m> wrote:
>>
>> Instead, a new action, 'v' for printing the policy (and/or
>> module) version in batch mode is added.
>>
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>
> For both patches:
> Acked-by: James Carter <jwcart2@gmail.com>

both merged, thanks!


>> ---
>>  checkpolicy/test/dismod.c | 30 ++++++++++++++++++++----------
>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
>> index 515fc9a5..fa729ef2 100644
>> --- a/checkpolicy/test/dismod.c
>> +++ b/checkpolicy/test/dismod.c
>> @@ -91,6 +91,7 @@ static struct command {
>>         {CMD|NOOPT, 'l', "Link in a module"},
>>         {CMD,       'u', "Display the unknown handling setting"},
>>         {CMD,       'F', "Display filename_trans rules"},
>> +       {CMD,       'v', "display the version of policy and/or module"},
>>         {HEADER, 0, ""},
>>         {CMD|NOOPT, 'f',  "set output file"},
>>         {CMD|NOOPT, 'm',  "display menu"},
>> @@ -899,6 +900,19 @@ static int menu(void)
>>         return 0;
>>  }
>>
>> +static void print_version_info(policydb_t * p, FILE * fp)
>> +{
>> +       if (p->policy_type =3D=3D POLICY_BASE) {
>> +               fprintf(fp, "Binary base policy file loaded.\n");
>> +       } else {
>> +               fprintf(fp, "Binary policy module file loaded.\n");
>> +               fprintf(fp, "Module name: %s\n", p->name);
>> +               fprintf(fp, "Module version: %s\n", p->version);
>> +       }
>> +
>> +       fprintf(fp, "Policy version: %d\n\n", p->policyvers);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>         char *ops =3D NULL;
>> @@ -952,17 +966,10 @@ int main(int argc, char **argv)
>>                 exit(1);
>>         }
>>
>> -       if (policydb.policy_type =3D=3D POLICY_BASE) {
>> -               printf("Binary base policy file loaded.\n");
>> -       } else {
>> -               printf("Binary policy module file loaded.\n");
>> -               printf("Module name: %s\n", policydb.name);
>> -               printf("Module version: %s\n", policydb.version);
>> -       }
>> -
>> -       printf("Policy version: %d\n\n", policydb.policyvers);
>> -       if (!ops)
>> +       if (!ops) {
>> +               print_version_info(&policydb, stdout);
>>                 menu();
>> +       }
>>         for (;;) {
>>                 if (ops) {
>>                         puts("");
>> @@ -1069,6 +1076,9 @@ int main(int argc, char **argv)
>>                 case 'l':
>>                         link_module(&policydb, out_fp);
>>                         break;
>> +               case 'v':
>> +                       print_version_info(&policydb, out_fp);
>> +                       break;
>>                 case 'q':
>>                         policydb_destroy(&policydb);
>>                         exit(0);
>> --
>> 2.40.1
>>

