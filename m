Return-Path: <SRS0=hnB7=YO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E044CA9EB5
	for <selinux@archiver.kernel.org>; Mon, 21 Oct 2019 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD9421721
	for <selinux@archiver.kernel.org>; Mon, 21 Oct 2019 05:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="c7U/NGO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfJUFzS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:55:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40335 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfJUFzR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Oct 2019 01:55:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so7698848pfb.7
        for <selinux@vger.kernel.org>; Sun, 20 Oct 2019 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xA6NS+xkd4XOOPYbauTeIGyoxqwwiLCr/AC/UJN2Etg=;
        b=c7U/NGO2bzpEpINZ56r6VW4aJCiHmJ77gzxAbb7kB7Vc4R0T4gKxWNKXvN1mog5Cwx
         p+H6UqgvBEj9C1nMellVo1N6j/01qBrfEvQIl7oVaqzJZai1er7JcXK3Bqa3ggTVvL+O
         LnNuAQCyqqS3Enm+gjghVHnYmazPwyFRGirLIvLWtdx8T9ihBE5HyXKuWC7S26FgYcU+
         NIFwYnaYaTt3Pdw6TP6aZCKhq3R+wsYIdf1o8TL5rsZMT/i8znqsCnrWuDb/tpKoLtKo
         tJSOXPGqaP1oaz/NPyiPncNnmFHbhx9Rl3TvO65sJ2hZ9/jK1f0RSlGA315p8BCrdvjy
         nB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xA6NS+xkd4XOOPYbauTeIGyoxqwwiLCr/AC/UJN2Etg=;
        b=KkyPI5Jt9PoTVZgJlm4lA1AeUJp4x8IUUabB8Q7MiTx7XF/Swv6kZGr20zgnrEBRx5
         3ZliYtTqmsKiJ2h6asmoAJMS2bpx2xatBpL1+lAeNgFjDt2IcM6fjGH7CJ4gZq+XY0bl
         GLnp/s3F4vF0Jv1fBZObx0hcWnZ0+hdWAHGyfDS6tEkoBUZ66t620chFLgFQiTTDH/XV
         65awwydTUY2BM+n6JfcaNZDs/2Xwx12Ww7PNSIccVCcoxh9K5rE0IHO1QwJeK5qDsv0n
         cwryzQ3UOAjOL1vZU3xbtR1ky87q9SzCInip7NWsDTHm1NzgdgTDxZrJTQDx4+fUZwNn
         EDOw==
X-Gm-Message-State: APjAAAX9VsaMKUEn3hgYY66VUMHoVJlZ9CwR3jN9n/dWw6i6lyE5gkcy
        WAZkFJ3yAbG2Kp1JtLb0gazUmLoI1BCWbg==
X-Google-Smtp-Source: APXvYqy6iMuNbfYEIkK9S5orVw2KHZSYfcpPdF7KSbBsEJDOsUoqnhf4o0LNM7ImBvIjUpO4rYLcvA==
X-Received: by 2002:a17:90a:8c14:: with SMTP id a20mr26828108pjo.77.1571637315663;
        Sun, 20 Oct 2019 22:55:15 -0700 (PDT)
Received: from localhost ([2401:fa00:d:fd00:d09e:9177:8678:8a22])
        by smtp.gmail.com with ESMTPSA id l22sm12294528pgj.4.2019.10.20.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 22:55:14 -0700 (PDT)
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: [PATCH] policycoreutils: semodule: Enable CIL logging
Date:   Mon, 21 Oct 2019 13:55:05 +0800
Message-Id: <20191021055505.25372-1-jason@perfinion.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

semodule -v will turn on semodule's own verbose logging but not logging
from CIL. This change makes the verbose flag also set cil's log level.

By default (ie no -v flag), this will enable CIL_ERR, and each -v will
increase the level from there.

Tested with a duplicated fcontext in the policy.
Before this change:
    # semodule -v -B
    Committing changes:
    Problems processing filecon rules
    Failed post db handling
    semodule:  Failed!

After this change:
    # semodule -v -B
    [ ... snip ... ]
    Found conflicting filecon rules
      at /var/lib/selinux/mcs/tmp/modules/400/mycustom/cil:159
      at /var/lib/selinux/mcs/tmp/modules/400/mycustom/cil:158
    Problems processing filecon rules
    Failed post db handling
    semodule:  Failed!

Closes: https://github.com/SELinuxProject/selinux/issues/176
Signed-off-by: Jason Zaman <jason@perfinion.com>
---

I also opened a PR here to run travis tests: https://github.com/SELinuxProject/selinux/pull/182

This only affects semodule -v, I tested out setsebool and it doesnt die
on a duplicated fcontext so I skipped it there. Should all the tools set
it or only as-needed? Do we want to make some general guidelines for
what kind of tools should set the CIL logging?

-- Jason


 policycoreutils/semodule/semodule.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index a76797f5..a1f75e16 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -22,6 +22,7 @@
 #include <libgen.h>
 #include <limits.h>
 
+#include <sepol/cil/cil.h>
 #include <semanage/modules.h>
 
 enum client_modes {
@@ -238,7 +239,7 @@ static void parse_command_line(int argc, char **argv)
 			set_mode(LIST_M, optarg);
 			break;
 		case 'v':
-			verbose = 1;
+			verbose++;
 			break;
 		case 'r':
 			set_mode(REMOVE_M, optarg);
@@ -350,6 +351,8 @@ int main(int argc, char *argv[])
 	}
 	parse_command_line(argc, argv);
 
+	cil_set_log_level(CIL_ERR + verbose);
+
 	if (build)
 		commit = 1;
 
-- 
2.23.0

