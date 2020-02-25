Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39081C35E0E
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C54520658
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No4JmmPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgBYUDI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:03:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41979 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUDI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:03:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so69396pgf.8
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xjSkLm+0LHvANOkmNPllladJCBXdxU5B3DDov8I2O94=;
        b=No4JmmPjE77onlkbggtFDmRVJVcVDNMsndueTHJQGJNHzodmmjjd+cpDqSjrA2yu7F
         mnebV3lJoTL+ODLMLUsG7qzCj7CJC6zMKO9gSzzTul0Zu9E6tU9cbzuXztUL+njWrYSw
         /AuI3tsQ1SPX1ITznWkbbj8LIbYdmUQCT10ByrsUAWyPoqtk3qAXM4+qFB3nEpGJvZhe
         RUhnUJUjaE3k9sMQybqJVDdDvk7N8fyqA39SSZO6JP4zCvrP3RfIT6MzVYXl6quRbHxJ
         R6QmOw1OFrkYhYE2OiMGDW2q/cBW+Ent3a/PS29MvXYyxgItWDeavKH+ZIM/4zlxH/EU
         P7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xjSkLm+0LHvANOkmNPllladJCBXdxU5B3DDov8I2O94=;
        b=gMOZuNbAqKePzUwGaUmvfb6mWtZ54SyhHi/nT0pLvQ59ghfUuSzAk5CYeSuoEMm9E8
         B7HXXjsxi/lLLnlGpMxsR4/kssH/07ssuPxIYiOoMRfujFCqLwNTg4hHTOeUK7YrfGAm
         uIbcqTPrTo7uNMt2XFM3yPad/22hmzId5zID34oQXzUAhAQ5klpLBkpRAo5njKsG4Yu3
         MIy9OoJRrTGVus7sbZq3obrdZgFJW1aWI5RIFUBtQmS6St6pQ//K6f44ac4cM7GbT/2C
         ha/RfAgHHyQNAdkZBesBFInpAy2Zyd/DjHrsBjTAbiDjdoWzgAqIRMCUeC7PoGRVY5jJ
         60+w==
X-Gm-Message-State: APjAAAV5JvaJrO4R1sfCO1w6JtxjUri4WwthEDmRBe4o2HrIhrlPHn9A
        ul8WRSn6B6z0DOFS18gNNJQ=
X-Google-Smtp-Source: APXvYqxzVyIbV599QFIQjzje8GzT6mzT97rW32C36Zxd7STCxI6dtg5tAtGw3V/JJWazdkydPK6jEg==
X-Received: by 2002:a62:446:: with SMTP id 67mr354224pfe.109.1582660988017;
        Tue, 25 Feb 2020 12:03:08 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:03:07 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 17/17] utils/matchpathcon: allow use of deprecated funcs
Date:   Tue, 25 Feb 2020 14:02:19 -0600
Message-Id: <20200225200219.6163-18-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Internally users of deprecated functions are ok so allow it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/utils/matchpathcon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index eb39a1881066..139ee9b45556 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -22,7 +22,10 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 static int printmatchpathcon(const char *path, int header, int mode)
 {
 	char *buf;
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	int rc = matchpathcon(path, mode, &buf);
+#pragma GCC diagnostic pop
 	if (rc < 0) {
 		if (errno == ENOENT) {
 			buf = strdup("<<none>>");
@@ -103,7 +106,10 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			init = 1;
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 			if (matchpathcon_init(optarg)) {
+#pragma GCC diagnostic pop
 				fprintf(stderr,
 					"Error while processing %s:  %s\n",
 					optarg,
@@ -195,6 +201,9 @@ int main(int argc, char **argv)
 			error |= printmatchpathcon(path, header, mode);
 		}
 	}
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	matchpathcon_fini();
+#pragma GCC diagnostic pop
 	return error;
 }
-- 
2.17.1

