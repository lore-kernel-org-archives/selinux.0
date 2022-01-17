Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E8C433EF
	for <selinux@archiver.kernel.org>; Mon, 17 Jan 2022 09:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiAQJmq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jan 2022 04:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233920AbiAQJmp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jan 2022 04:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642412565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nzN67nFCbl6CAPz1VxhsHR8v1CqxufiAJIfMzVetKUk=;
        b=bfH8pgTTycfqTbvdMl0CNHtKTuo9Xeqx6xVf14BP1bWVDtMORp8emieNN5JPGZKNjLwUUY
        qoQF7dWbKHVszhSV4TaqIYg1plcg9voADmeIsO9cfk8Pt/05ZDKtsSMLtN0r5KD/hThNpl
        HAgfalVh9s2nA2z0py11iDWdZIEsg6c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-2OGzJrVgPiS3z7Fa7fxwPQ-1; Mon, 17 Jan 2022 04:42:43 -0500
X-MC-Unique: 2OGzJrVgPiS3z7Fa7fxwPQ-1
Received: by mail-ed1-f72.google.com with SMTP id ee53-20020a056402293500b004022f34edcbso3005537edb.11
        for <selinux@vger.kernel.org>; Mon, 17 Jan 2022 01:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nzN67nFCbl6CAPz1VxhsHR8v1CqxufiAJIfMzVetKUk=;
        b=iDi0Aeg2GV1mow/R28qzjm9Nn5ofq7TtN9pX5RQvr5a6PfpPnmFdzLr0jyJr6XRmhl
         UiUTzqhOA4ASOzYvsEio9RX4QtDkQXwyVuE0nXqLSXbueKJQRneuMaigKKNbOk1XbRFb
         bICXyTH5biMqgb4ymKTKXXraRGmWxKnAMxsFVBw08UE3QUXM/koGbLZlejYNLkRvegHw
         N1uU3VE3dI4Ps4PKKikz6OG37+uBgZ/Y8YGFmEb+HRxUoMEWLMsFJx5IbePqdtNfFzmQ
         aKLaEXshd554TqqB3F1+DdzYwOkSJBtIte6YG6XpbLqfh9lhDycjH0hgGQB5ekIyG5OS
         qXdg==
X-Gm-Message-State: AOAM533d6LB87v9ODnTkaCS6wnwQF4SFiFU+AK7VEg4v7oly7hTbqsGh
        5kLxVtbs/DlhPVHJOwzTuzv3sVxs1PX67crDS+42/FEDJHfn6Z3HZR92fs0yf4AncFUTPdiAqyi
        4/Zb9kXPp+rPg+2RF3pvVtWuORefDDLh91ZmWQchgfiFY08bkWKgub+yQ7zdoyHx8aZPw
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr15268035ejc.247.1642412561228;
        Mon, 17 Jan 2022 01:42:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMRA9AVTTWJ/DHJgwbycE12AcnuXY7FKai+GMNf4PyHqY+TF5yzLjQIkzXS3cgQao2SbOxLA==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr15268023ejc.247.1642412560956;
        Mon, 17 Jan 2022 01:42:40 -0800 (PST)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id w17sm5573580edr.68.2022.01.17.01.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 01:42:40 -0800 (PST)
Subject: Re: [PATCH] libselinux: Strip spaces before values in config
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20220113204353.185947-1-vmojzis@redhat.com>
 <CAJ2a_Ddp1jfsHSZq9FSOUL83yBmnuiWP2SOweFa=KRj5KL9w_A@mail.gmail.com>
From:   Vit Mojzis <vmojzis@redhat.com>
Message-ID: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com>
Date:   Mon, 17 Jan 2022 10:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Ddp1jfsHSZq9FSOUL83yBmnuiWP2SOweFa=KRj5KL9w_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 15. 01. 22 18:28, Christian Göttsche wrote:
> On Thu, 13 Jan 2022 at 21:44, Vit Mojzis <vmojzis@redhat.com> wrote:
>> Spaces before values in /etc/selinux/config should be ignored just as
>> spaces after them are.
>>
>> E.g. "SELINUXTYPE= targeted" should be a valid value.
>>
>> Fixes:
>>     # sed -i 's/^SELINUXTYPE=/SELINUXTYPE= /g' /etc/selinux/config
>>     # dnf install <any_package>
>>     ...
>>     RPM: error: selabel_open: (/etc/selinux/ targeted/contexts/files/file_contexts) No such file or directory
>>     RPM: error: Plugin selinux: hook tsm_pre failed
>>     ...
>>     Error: Could not run transaction.
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>   libselinux/src/selinux_config.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
>> index 97f81a8b..99cd6124 100644
>> --- a/libselinux/src/selinux_config.c
>> +++ b/libselinux/src/selinux_config.c
>> @@ -92,6 +92,7 @@ int selinux_getenforcemode(int *enforce)
>>          FILE *cfg = fopen(SELINUXCONFIG, "re");
>>          if (cfg) {
>>                  char *buf;
>> +               char *tag;
>>                  int len = sizeof(SELINUXTAG) - 1;
>>                  buf = malloc(selinux_page_size);
>>                  if (!buf) {
>> @@ -101,21 +102,24 @@ int selinux_getenforcemode(int *enforce)
>>                  while (fgets_unlocked(buf, selinux_page_size, cfg)) {
>>                          if (strncmp(buf, SELINUXTAG, len))
>>                                  continue;
>> +                       tag = buf+len;
>> +                       while (isspace(*tag))
>> +                               tag++;
>>                          if (!strncasecmp
>> -                           (buf + len, "enforcing", sizeof("enforcing") - 1)) {
>> +                           (tag, "enforcing", sizeof("enforcing") - 1)) {
>>                                  *enforce = 1;
>>                                  ret = 0;
>>                                  break;
>>                          } else
>>                              if (!strncasecmp
>> -                               (buf + len, "permissive",
>> +                               (tag, "permissive",
>>                                   sizeof("permissive") - 1)) {
>>                                  *enforce = 0;
>>                                  ret = 0;
>>                                  break;
>>                          } else
>>                              if (!strncasecmp
>> -                               (buf + len, "disabled",
>> +                               (tag, "disabled",
>>                                   sizeof("disabled") - 1)) {
>>                                  *enforce = -1;
>>                                  ret = 0;
>> @@ -176,7 +180,10 @@ static void init_selinux_config(void)
>>
>>                          if (!strncasecmp(buf_p, SELINUXTYPETAG,
>>                                           sizeof(SELINUXTYPETAG) - 1)) {
>> -                               type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
>> +                               buf_p += sizeof(SELINUXTYPETAG) - 1;
>> +                               while (isspace(*buf_p))
>> +                                       buf_p++;
>> +                               type = strdup(buf_p);
>>                                  if (!type) {
>>                                          free(line_buf);
>>                                          fclose(fp);
>> @@ -199,6 +206,8 @@ static void init_selinux_config(void)
>>                          } else if (!strncmp(buf_p, REQUIRESEUSERS,
>>                                              sizeof(REQUIRESEUSERS) - 1)) {
>>                                  value = buf_p + sizeof(REQUIRESEUSERS) - 1;
>> +                               while (isspace(*value))
>> +                                       buf_p++;
> This looks wrong.
Yes, sorry, stupid mistake.

>
>>                                  intptr = &require_seusers;
>>                          } else {
>>                                  continue;
>> --
>> 2.34.1
>>

