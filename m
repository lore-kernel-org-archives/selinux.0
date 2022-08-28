Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA63C0502A
	for <selinux@archiver.kernel.org>; Sun, 28 Aug 2022 12:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiH1MOo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Aug 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH1MOn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Aug 2022 08:14:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296F1C116
        for <selinux@vger.kernel.org>; Sun, 28 Aug 2022 05:14:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m16so6976142wru.9
        for <selinux@vger.kernel.org>; Sun, 28 Aug 2022 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc;
        bh=CDut0I6OXLlOBT/yr8iARdU82NAI+F+HYWCpXHrGMkw=;
        b=NEt6Tnuls9grCXv4P/f/fXtSATojeNFYBP0hPSO/OnVEzpN13KtPsl8U4liOFLY5il
         NHEdQMfRcaoQAvorPVgjFMzCb1Ez7R5ftRqupKPeIytPz2G835tdInRMd6/lY6zb6ZK7
         IcDrCPT0Xc86dQXt5AaHinbo5E+0FGTXHlNiOJqGUPA2THFXAcpEkJv8J0CBEuhFWQio
         DUyxlj2L5v5kITiEIGK4pBRmZg7rtQcOKaUTEItZ/4ghCYbq/1L24Q7SORluumDEMNJF
         9rnkv4/kboROnx2fwbiIZNNz8lyMm267vNFmuKvAWXJ8/DloLpP4G3ooCn3D62XTCoiu
         lFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc;
        bh=CDut0I6OXLlOBT/yr8iARdU82NAI+F+HYWCpXHrGMkw=;
        b=48ezW2D5W5/AITKthb4jTvPLaFxohJqV5K8ZEpJ9ZkOW2s2n8lR863giZOXw5PtUd+
         nISetzq+PJWGgw+GHqL+aMjfVU+bVNXsQwdPdCMVGp8ScOL5bgANluOSABIAIlJ0dbvL
         zYVMGvJeaxCMCOwNyQssulN2Vq36nAb0IbsQVzEmafZ/6JJsujoyEVGoFDs7DIBO66uf
         OAe0tLPYhMwNVhOv7SdFOni0C67oN4nDnXbzB4v2InuC/9b4BqNWCsQbtsuMxPsvzBEK
         worbt8vSfYG18UiFIz5A4uL7HOMIqhWysBWwvaYl5Ej+25elozJEjQfxuPxOijbPnozK
         xUfQ==
X-Gm-Message-State: ACgBeo06yAFcIkkoG7seK1dhKA5D8QfczCxv73+tC3wgJ8en7Pu8DkD4
        NI+29hprMEVcVNRyCMgNTxZ+SP9q9LY=
X-Google-Smtp-Source: AA6agR4qPbrxx57l7baVplJcsDmU8kamM3TWfrIsXORY0r7hjOvaj7mjmIGcLqlg3RjfAr4gP79j4g==
X-Received: by 2002:a05:6000:186f:b0:225:5b8d:fc89 with SMTP id d15-20020a056000186f00b002255b8dfc89mr4297389wri.577.1661688881618;
        Sun, 28 Aug 2022 05:14:41 -0700 (PDT)
Received: from ?IPV6:2001:a61:3450:ee01:9da9:8337:59d2:c8c4? ([2001:a61:3450:ee01:9da9:8337:59d2:c8c4])
        by smtp.gmail.com with ESMTPSA id i12-20020a1c540c000000b003a2f2bb72d5sm6318631wmb.45.2022.08.28.05.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:14:41 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <89653753-717f-3ef9-9538-c90ad2aa62b1@gmail.com>
Date:   Sun, 28 Aug 2022 14:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: [PATCH 3/3] secilc/docs: disable pandoc default css for html docs
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some time ago pandoc started shipping a default css file for html, while
that is nice, it limits the max-width of the body element to 36em. We
have a lot of tables, code examples, etc... in the manual that are too
big for that, requiring constant scrolling.

See https://github.com/jgm/pandoc/blob/master/data/templates/styles.html
for the default used.

While some styling, perhaps even dark/light mode support in the CSS
would be nice, I didn't manage to find a simple way to achieve this, so
for now just disable the CSS.

Expand the arguments for pandoc in the Makefile for better readability.

Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
---
  secilc/docs/Makefile | 18 ++++++++++++++++--
  1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index a03ebeed..7e2ba40e 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -58,11 +58,25 @@ $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil

  html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
  	mkdir -p $(HTMLDIR)
-	$(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --metadata title="CIL Reference Guide" -t html $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil  -o $(HTMLDIR)/$(HTML_OUT)
+	$(PANDOC) \
+		--highlight-style=$(PANDOC_HIGHLIGHT_STYLE) \
+		--syntax-definition=secil.xml \
+		--standalone \
+		--metadata title="CIL Reference Guide" \
+		--metadata document-css=false \
+		-t html \
+		$(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil \
+		-o $(HTMLDIR)/$(HTML_OUT)

  pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
  	mkdir -p $(PDFDIR)
-	$(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --toc $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil -o $(PDFDIR)/$(PDF_OUT)
+	$(PANDOC) \
+		--highlight-style=$(PANDOC_HIGHLIGHT_STYLE) \
+		--syntax-definition=secil.xml \
+		--standalone \
+		--toc \
+		$(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil \
+		-o $(PDFDIR)/$(PDF_OUT)

  clean:
  	rm -rf $(HTMLDIR)
--
2.36.1

