Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34845C433EF
	for <selinux@archiver.kernel.org>; Mon, 21 Feb 2022 11:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiBULHK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:07:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355718AbiBULDd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Feb 2022 06:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48920A0
        for <selinux@vger.kernel.org>; Mon, 21 Feb 2022 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645439488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJA/rEPwPv+jLDldYCdrtH430PERFDterJe+0uoaYNo=;
        b=AWBiK0nstWCuNPhcuq9zoBPRyffKwlS9k3xVoEEBlnN/pvGI6p8mCvpbMTeDxiRPgCm8/D
        18DT9iLsPnpp8Q0V+UoJZDbNCAQV8FaPmnJquf6M2VgAVzIZlhNrDZ6ErT3+f4vbFEnXl+
        jf0NkIt1uTiXFHFHcI9Y0uDdPgycqZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-uXvewRtKPGWly9IngYPl_g-1; Mon, 21 Feb 2022 05:31:26 -0500
X-MC-Unique: uXvewRtKPGWly9IngYPl_g-1
Received: by mail-wr1-f70.google.com with SMTP id q21-20020adfab15000000b001e57c9a342aso7211504wrc.6
        for <selinux@vger.kernel.org>; Mon, 21 Feb 2022 02:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJA/rEPwPv+jLDldYCdrtH430PERFDterJe+0uoaYNo=;
        b=Y6u9XDe1VA4yDXSlGngxRJwShUd7jPy3Hl0An53JFVXrXWFUtmy9vrheXlsvx3rOpm
         uRjnzHXYauQj5upqdGX51OMn09vG9kQKoReBjoR00S3G2lJox5QxFSNZyhimRZdi0ePL
         x1kzyW+6jcymWCiKf7pKc2LT40SgFBByEShFXdRB7EuMFZUm7bHtLlNkQqFykFXMS/oE
         nkyoe/7v35bBHOjWavWloG8tabEBxlimJ5vnwkQtCtbxQyBwvoIMKQsJjZyNbjgOV/Ec
         Y7jFWKD/folPM4SHG5izZprkjobcsgs1mX75qV43Y68OmaCjKFq+pUWkVsQ/4j4ua3ey
         PJHQ==
X-Gm-Message-State: AOAM532NbH/m6D0p59Fgpepkycjh1nUu8/vl8BTocX77Rc9GsRJxHNMU
        Fy0I8fnoU2rEKhoEKl85RjHmiVG511j+l7g50f6l+QGsOdsxPuLxRNUWwO3hEHMKhSUjIPOVWXU
        7SIAt9GbuHdQ6oeHXZEHIMH3jxPCMyWNfboubNNN0JCZ387z+HLwvpV+Zs+aCr17nAiSS
X-Received: by 2002:a05:6000:1787:b0:1e7:aeac:eb00 with SMTP id e7-20020a056000178700b001e7aeaceb00mr15506631wrg.141.1645439485478;
        Mon, 21 Feb 2022 02:31:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6hMiZ1nBk1KQkmp63ChBLqhrTPmsK8bYvrHdY43zA9wpC4lp4agVdirQVmKMpYWp21fhuiA==
X-Received: by 2002:a05:6000:1787:b0:1e7:aeac:eb00 with SMTP id e7-20020a056000178700b001e7aeaceb00mr15506595wrg.141.1645439485150;
        Mon, 21 Feb 2022 02:31:25 -0800 (PST)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id h2sm7049927wmm.27.2022.02.21.02.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 02:31:24 -0800 (PST)
Subject: Re: [PATCH v2] libselinux: Strip spaces before values in config
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com>
 <20220217131415.1195383-1-vmojzis@redhat.com>
 <CAJ2a_Df=pjCN_Cs1EN_bk1wF_XFuqUVhB_5vjH0oiqCG=xWbKw@mail.gmail.com>
From:   Vit Mojzis <vmojzis@redhat.com>
Message-ID: <d46fe913-04c3-7df1-c29a-1d186d2c3b32@redhat.com>
Date:   Mon, 21 Feb 2022 11:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Df=pjCN_Cs1EN_bk1wF_XFuqUVhB_5vjH0oiqCG=xWbKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 17. 02. 22 15:16, Christian Göttsche wrote:
> On Thu, 17 Feb 2022 at 14:14, Vit Mojzis <vmojzis@redhat.com> wrote:
>>
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
>>
>> Sorry for the delay. I sent the fixed patch to a wrong mailing list.
>>
>>   libselinux/src/selinux_config.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
>> index 97f81a8b..d2e49ee1 100644
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
> 
> Strictly speaking one should cast to unsigned char to avoid UB, see
> [1], but that
> seems to be not done in SElinux userspace as
> 
>      grep -REw "(isalnum|isalpha|isascii|isblank|iscntrl|isdigit|isgraph|islower|isprint|ispunct|isspace|isupper|isxdigit|toascii|toupper|tolower)"
> 
> shows 87 usages.
> 
> [1]: https://wiki.sei.cmu.edu/confluence/display/c/STR37-C.+Arguments+to+character-handling+functions+must+be+representable+as+an+unsigned+char
> 


Right, thank you. So, should I fix the patch (which would make the use 
of the cast inconsistent in selinux_config.c), or leave it as is?
If this is something worth fixing I can make a new patch adding the cast 
to all the calls (except for cases where EOF can be expected? -- not 
sure if we need to watch for that).

Vit


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
>> +                                       value++;
>>                                  intptr = &require_seusers;
>>                          } else {
>>                                  continue;
>> --
>> 2.30.2
>>

