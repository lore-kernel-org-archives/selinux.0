Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55552C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2C4204EF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXush4nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEOLTm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOLTm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:19:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DBDC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:19:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so1825349ljg.5
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MfyxhaYbj650l0ClFUDDMgqFVZqGA6e00J8tsS4q/+Q=;
        b=sXush4nKwWY6qFHPYRL77vh2Y709Ta8fXhsT8BC62TwaUh93kgaMFrfrZf4F+Bzkul
         xMazt7ZakmA7gpDsVcTINFfBdkNdWYDaCDWAjtJIARW5D14itHK5i6pTrd2ehmQdfLfe
         vzpEH+rWrMWKLpVRhfOl/7Xbur0ZiwVPrdtfdmmkMd7cYbPz5hLNSeszxvFMmTdTBSVZ
         0B/85vEyeQlg6UqyeMK8LOrkkWRSAS3nV9W7A+4ZqZr1fdXONQjwuxPqECwPS5TkRQzp
         4jROhBHEgdWtXDnLuTdoA8wBKjxWWrC6/7bPc2lKcbySFHMysouTlkXk+CjTnQzhdccC
         7RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfyxhaYbj650l0ClFUDDMgqFVZqGA6e00J8tsS4q/+Q=;
        b=D3Sz+KzDnCHyBfriHhXzQYenVDiotzyQHAcA5OUJ/YdNzM11Le6mQWsOtCI/ceeLF0
         n6gPpcgP/0LpnXINT/whlQTC9GcKjqwqh2FxWVDcg4VyR1VpKo9z59zhcEiryvKfehBX
         lKZxiKy7KUItoUh5t3KpwKISt1ydRpW04C44CpStqmQrpZ+XJ8rSuszkTpHQbFpL9vnh
         iu09AKSMdYfk4kBDYByqOwuMdO7NKsU13Y1yXwro6V2bCdxdBfe62sdw6y0LlmshlV5j
         sCeZVULCKPpwffLDHuLjj52MfED6gQL7/XE3Dyxyn0xmOnTgWlGSJ0L7WbtTE1pXmfMe
         df9g==
X-Gm-Message-State: AOAM530HZdRejPMqJMZPnGHKBwf2t63MNezvaws0qPElNWbhWSJq1dXR
        Y2d+1hNvUShQn+8Ydg1AeoS0xWLa
X-Google-Smtp-Source: ABdhPJw8EB9KKGmLiJWRB/5xIuJfMUqq7fpnx54nGZoBnO0iD67gZBcSnJCI3x2tGciQ+vt3UfpFIA==
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr1858581ljm.165.1589541580143;
        Fri, 15 May 2020 04:19:40 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id z23sm1002974ljm.46.2020.05.15.04.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 04:19:39 -0700 (PDT)
Subject: Re: [PATCH] secilc/docs: fix use of TMPDIR #240
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200515105105.10075-1-toiwoton@gmail.com>
 <20200515110900.GA255621@workstation>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <c50a1736-0bfd-88c4-7b8f-cf4b29151941@gmail.com>
Date:   Fri, 15 May 2020 14:19:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515110900.GA255621@workstation>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 15.5.2020 14.09, Petr Lautrbach wrote:
> On Fri, May 15, 2020 at 01:51:05PM +0300, Topi Miettinen wrote:
>> Environment variable TMPDIR may be already set for the user building
>> and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existing
>> directories. Then when running 'make clean', there are unintended side
>> effects:
>>
>> rm -rf /run/user/1000
>> rm: cannot remove '/run/user/1000/dconf/user': Permission denied
>> rm: cannot remove '/run/user/1000/systemd': Permission denied
>> rm: cannot remove '/run/user/1000/gnupg': Permission denied
>> rm: cannot remove '/run/user/1000/dbus-1': Is a directory
>> rm: cannot remove '/run/user/1000/inaccessible': Permission denied
>> make[1]: *** [Makefile:68: clean] Error 1
>>
>> Fix by using a different name.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>>   secilc/docs/Makefile | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
>> index 6b07ce7f..90214e0d 100644
>> --- a/secilc/docs/Makefile
>> +++ b/secilc/docs/Makefile
>> @@ -1,7 +1,7 @@
>>   CWD ?= $(shell pwd)
>>   HTMLDIR ?= $(CWD)/html
>>   PDFDIR ?= $(CWD)/pdf
>> -TMPDIR ?= $(CWD)/tmp
>> +TMP_DIR ?= $(CWD)/tmp
>>   TESTDIR ?= $(CWD)/../test
> 
> Maybe it would be enough to drop `?=`:
> 
> CWD = $(shell pwd)
> HTMLDIR = $(CWD)/html
> PDFDIR = $(CWD)/pdf
> TMPDIR = $(CWD)/tmp
> TESTDIR = $(CWD)/../test

That could work, assuming that the higher level Makefiles or builders 
don't use the variables.

Other approaches could be to rework build process to use 'mktemp -d' and 
immediately removing the temporary directory, or generating the 
temporary files with a prefix (%.md -> %.sedded) in the build directory.

-Topi

> 
> 
> 
>>   # All the markdown files that make up the guide:
>> @@ -26,7 +26,7 @@ FILE_LIST ?= cil_introduction.md \
>>   	cil_infiniband_statements.md \
>>   	cil_xen_statements.md
>>   
>> -PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
>> +PANDOC_FILE_LIST = $(addprefix $(TMP_DIR)/,$(FILE_LIST))
>>   
>>   PDF_OUT=CIL_Reference_Guide.pdf
>>   HTML_OUT=CIL_Reference_Guide.html
>> @@ -40,29 +40,29 @@ endif
>>   
>>   all: html pdf
>>   
>> -$(TMPDIR):
>> -	mkdir -p $(TMPDIR)
>> +$(TMP_DIR):
>> +	mkdir -p $(TMP_DIR)
>>   
>> -$(TMPDIR)/%.md: %.md | $(TMPDIR)
>> -	cp -f $< $(TMPDIR)/
>> +$(TMP_DIR)/%.md: %.md | $(TMP_DIR)
>> +	cp -f $< $(TMP_DIR)/
>>   	@# Substitute markdown links for conversion into PDF links
>>   	$(SED) -i -re 's:(\[`[^`]*`\])\([^#]*([^\)]):\1\(\2:g' $@
>>   
>> -$(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
>> +$(TMP_DIR)/policy.cil: $(TESTDIR)/policy.cil
>>   	cp -f $< $@
>>   	@# add a title for the TOC to policy.cil. This is needed to play nicely with the PDF conversion.
>>   	$(SED) -i '1i Example Policy\n=========\n```' $@
>>   	echo '```' >> $@
>>   
>> -html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
>> +html: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
>>   	mkdir -p $(HTMLDIR)
>>   	$(PANDOC) -t html $^ -o $(HTMLDIR)/$(HTML_OUT)
>>   
>> -pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil
>> +pdf: $(PANDOC_FILE_LIST) $(TMP_DIR)/policy.cil
>>   	mkdir -p $(PDFDIR)
>>   	$(PANDOC) --standalone --toc $^ -o $(PDFDIR)/$(PDF_OUT)
>>   
>>   clean:
>>   	rm -rf $(HTMLDIR)
>>   	rm -rf $(PDFDIR)
>> -	rm -rf $(TMPDIR)
>> +	rm -rf $(TMP_DIR)
>> -- 
>> 2.26.2
>>
> 

