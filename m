Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED63C05052
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHNNVQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHNNUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00DB10FB
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so67643001fa.2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019240; x=1692624040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T+4o5IqM1ckjv1vB6Hj+yuZO8zxIn1UbsF72lQnCa4=;
        b=oCIX3KnWLl/XTmWwWWCjFzifVZ1RqskFZnv67XMB7Kcc8rgN1NkY2aFP4LTcj8U4w+
         nt4mJxGUvUFxMipi4+aHM37e3fKFM22XDl7cm0fxT1VJGQbOfrXpJZtQPeQCmPnQUlsP
         s5KVUjAzmTDC9HMa704Pv6iX2gvj6SGZEr2HGDKghmmFuKKzn2KouXmMuYn91NMs8kZW
         fq/T+2o0koQxfoukvuDgcgMPYCaB51IsTJoW8291cGgxnvxYb66cGEk31KtCfDHcaO7j
         WvqOel3iQhyp4CKzLGKlZEw90n/FytxbJiG3c8DxMG09FNYbkV7xwyi7ad3zN9yc4Z/S
         dUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019240; x=1692624040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T+4o5IqM1ckjv1vB6Hj+yuZO8zxIn1UbsF72lQnCa4=;
        b=QV71LeY9gjnP3G2zjEl6XACyKY/8Ye/IsEE4PtpRPZTgY+F0UTyxe8AvVRiRBFyZb/
         2Vu0igR5zOOkdzzR1jFiRN3eKE+XW7IV9VhnwhSL9vizddvkeAkW4b3Hqaf+/sn/OL5R
         PhdzKYekid2sSFlG7wFEfqFrVyEe1XJn3KBBV9fz/HABKusAZFl6fItgisDya9fgAquU
         TOskhJxR4sGgilZcHn6OWk5tnp6bI2kWepp2sdXgCDYwqL/Daquak7OqQqxbmGW7QATh
         hSV1WF263LqFyY1VXqbNi+lJ2h4cvy5SoFa5SZZUJP9sNeurn7N2f08cDX2t1cgBmV26
         W8TA==
X-Gm-Message-State: AOJu0YyyPIk9GkHR3OQexVlVhUbqEuI9S855DnKbH4RRaV8nMqH5EcG4
        +QuRXutQt4UfNu5pnxUuL01mS6VrMD3sHfkLpnk=
X-Google-Smtp-Source: AGHT+IFV60vtjqBYnaAJl9ZA8RtqIKJ2BbfJOzF713VSENQRpmu8Uqh3KKpNmYRZuluGO2zM5UhdyA==
X-Received: by 2002:a2e:8e92:0:b0:2b9:f0b4:eaa1 with SMTP id z18-20020a2e8e92000000b002b9f0b4eaa1mr6368638ljk.16.1692019239878;
        Mon, 14 Aug 2023 06:20:39 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 01/27] libselinux/utils: update selabel_partial_match
Date:   Mon, 14 Aug 2023 15:19:59 +0200
Message-Id: <20230814132025.45364-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Print usage information and exit if required path option is not given
or superfluous arguments are given.

Constify read-only variables assigned command line arguments.

Simplify bool evaluation.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_partial_match.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/selabel_partial_match.c
index 7bbd5777..0df2627a 100644
--- a/libselinux/utils/selabel_partial_match.c
+++ b/libselinux/utils/selabel_partial_match.c
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 {
 	int opt;
 	bool partial_match;
-	char *validate = NULL, *path = NULL, *file = NULL;
+	const char *validate = NULL, *path = NULL, *file = NULL;
 
 	struct selabel_handle *hnd;
 	struct selinux_opt selabel_option[] = {
@@ -55,6 +55,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (!path || optind != argc)
+		usage(argv[0]);
+
 	selabel_option[0].value = file;
 	selabel_option[1].value = validate;
 
@@ -69,7 +72,7 @@ int main(int argc, char **argv)
 	partial_match = selabel_partial_match(hnd, path);
 
 	printf("Match or Partial match: %s\n",
-		    partial_match == 1 ? "TRUE" : "FALSE");
+		    partial_match ? "TRUE" : "FALSE");
 
 	selabel_close(hnd);
 	return partial_match;
-- 
2.40.1

