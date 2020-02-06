Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C0C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC27214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPTpjVER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgBFNND (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:13:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26177 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727361AbgBFNNC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580994781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7v5BlLtIsQ3PnHA53VkvitgHN4RCREqXcZqZQ+LdmFE=;
        b=fPTpjVERMbh+80uEKo9VgOJphIJAyG5x4IFCOIo+qRk0RIm2Jw9GRNeniB4xZK6VEfeX9z
        A18NidROY/ym5oiySbo2D4nEpRypvQ+lKAWnUUwYPte2qQ8Ne+C1JYSOMLzkSdkR6g/wfY
        iezvl59I4v27p4eOknbz8VoQDbUG6NE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-S6r88QZ7Ocua9YDEVJ1WRQ-1; Thu, 06 Feb 2020 08:12:59 -0500
X-MC-Unique: S6r88QZ7Ocua9YDEVJ1WRQ-1
Received: by mail-wr1-f70.google.com with SMTP id u18so3332701wrn.11
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 05:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v5BlLtIsQ3PnHA53VkvitgHN4RCREqXcZqZQ+LdmFE=;
        b=rau8potArMXpDMGgjBCZDPesST5ind4WTu5OGLPBarTZvGsJRg8DXIxtJ4DuH7zDL7
         OnaEhi8cB3YjcdHIZGipSj5iueNdXiXMWwZDtGoMYtXC8NICQn1AvoW7L5wQJHOL7fqa
         4ZE4l/Tz6nYOXIS+pHj+ClRmwAGAIBqtOb1/5fAjbd/hlT0ApKqIqBWnPBSiowSb3++N
         FFmd1K4X31H58ny1i416cvPw1AYcTMe+OKD2x65VtZc50X2JIKtzUuDfNTvn2o3VP0jt
         4VEV8V6f2zMlX5MB5rNzuT2BNwboqZKrSSiosjPrb6LX5V/AYY+aOVCqp85yt4b7kFus
         cRJA==
X-Gm-Message-State: APjAAAWHfc4ApR8dBofSiMg8l2JdR7+MjR90VqQ8XNVyK9zpkojgYU1A
        +1plvruIrQy+v21vgCustg/E9893ulPbloyT/D99sQRd6saFMm+WcXn8rfvKxTGCo3CfWovh9xb
        5RtO+a7RzKqMesduVxw==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr3792307wrs.237.1580994777762;
        Thu, 06 Feb 2020 05:12:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4mTSyXne9MKHci6ii6jvDjAA2IBqbg5dksqfIvwBIhKuvWCwFVZrif37TtBJytnrKVqzVCQ==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr3792284wrs.237.1580994777482;
        Thu, 06 Feb 2020 05:12:57 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm4506472wrw.54.2020.02.06.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:12:56 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [RFC PATCH 2/2] semodule: support changing policyvers via command line
Date:   Thu,  6 Feb 2020 14:12:53 +0100
Message-Id: <20200206131253.535302-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206131253.535302-1-omosnace@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When using semodule for building a distribution policy package (as
Fedora does), the environment might not have selinuxfs available and
provide no way to modify semanage.conf. When we want to build a policy
with version X (because our kernel doesn't support X+1 and above yet),
but our libsepol already has support for X+1, then we currently have no
way to do so.

To resolve this, add a new command-line argument to semodule, which
allows to override the system-wide configured version to a different
one.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/semodule/semodule.8 |  3 +++
 policycoreutils/semodule/semodule.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 18d4f708..88e027fd 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -64,6 +64,9 @@ A module is extracted as HLL by default. The name of the module written is
 <module-name>.<lang_ext>
 .SH "OPTIONS"
 .TP
+.B  \-V,\-\-policyvers
+force specific kernel policy version
+.TP
 .B  \-s,\-\-store
 name of the store to operate on
 .TP
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index a1f75e16..30c4495b 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -50,6 +50,8 @@ static int build;
 static int disable_dontaudit;
 static int preserve_tunables;
 static int ignore_module_cache;
+static unsigned policyvers;
+static int policyvers_set = 0;
 static uint16_t priority;
 static int priority_set = 0;
 
@@ -137,6 +139,7 @@ static void usage(char *progname)
 	printf("  -d,--disable=MODULE_NAME  disable module\n");
 	printf("  -E,--extract=MODULE_NAME  extract module\n");
 	printf("Options:\n");
+	printf("  -V,--policyvers  force specific kernel policy version\n");
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -N,-n,--noreload do not reload policy after commit\n");
 	printf("  -h,--help        print this message and quit\n");
@@ -210,7 +213,7 @@ static void parse_command_line(int argc, char **argv)
 	no_reload = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
+		getopt_long(argc, argv, "V:s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -248,6 +251,10 @@ static void parse_command_line(int argc, char **argv)
 			fprintf(stderr, "The --upgrade option is deprecated. Use --install instead.\n");
 			set_mode(INSTALL_M, optarg);
 			break;
+		case 'V':
+			policyvers = (unsigned)strtoul(optarg, NULL, 10);
+			policyvers_set = 1;
+			break;
 		case 's':
 			set_store(optarg);
 			break;
@@ -363,6 +370,9 @@ int main(int argc, char *argv[])
 		goto cleanup_nohandle;
 	}
 
+	if (policyvers_set)
+		semanage_set_policyvers(sh, policyvers);
+
 	if (store) {
 		/* Set the store we want to connect to, before connecting.
 		 * this will always set a direct connection now, an additional
-- 
2.24.1

