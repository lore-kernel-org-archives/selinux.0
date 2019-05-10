Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49AC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9E62084A
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="0BfGnMZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfEJTCp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 15:02:45 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:56178 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfEJTCp (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 15:02:45 -0400
X-Greylist: delayed 2765 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2019 15:02:40 EDT
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4AIHtXC013599
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 21:17:56 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4AIHtXC013599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1557512276;
        bh=cfxLH6ygpqVey1s8Q/OHb3TEiPmow+eHIM/ePkTzvB4=;
        h=Date:From:To:Subject:From;
        b=0BfGnMZdflZ44Vjml+saEgIDDKxnagFCkg2vHzX7R2R+5PES5dzqgBLngob32086D
         FldnSvPG/eeHUNZbykDMBYUBg6k95u68vB5dBiBVCjgLUKWIpB3pyq82pimB9pcSHC
         ajYLM3A1ewSBcoIPqZp+wQZ7ct+UZ+S9d0WlThMIspLvuUgPc9wuWqYm4oSOwCrsdE
         PngeICIJ61vZs6ONE7B2TbMHg8Qp7ZTFAHtQ9nszEMXDRuULk3uPzRtFqVsk/tvqjb
         RdCqXsJpQI57iSS9XQkrdyCJt11ndVmeghWqL85cLP31dr9kCABis5jGiotuGouJnO
         DtOX1gXcmGkBQ==
Date:   Fri, 10 May 2019 21:17:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH] Global replace exit(0) with more readable
 exit(EXIT_SUCCESS)
Message-ID: <alpine.LFD.2.21.1905102117140.16225@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



---
 libselinux/utils/avcstat.c         | 4 ++--
 libselinux/utils/compute_av.c      | 2 +-
 libselinux/utils/compute_create.c  | 2 +-
 libselinux/utils/compute_member.c  | 2 +-
 libselinux/utils/compute_relabel.c | 2 +-
 libselinux/utils/compute_user.c    | 4 ++--
 libselinux/utils/getfilecon.c      | 2 +-
 libselinux/utils/getpidcon.c       | 2 +-
 libselinux/utils/getseuser.c       | 2 +-
 libselinux/utils/policyvers.c      | 2 +-
 libselinux/utils/setfilecon.c      | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 884a10bf..da239287 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -116,7 +116,7 @@ int main(int argc, char **argv)
 		case 'h':
 		case '-':
 			usage();
-			exit(0);
+			exit(EXIT_SUCCESS);
 		default:
 			usage();
 			die("unrecognized parameter '%c'", i);
@@ -133,7 +133,7 @@ int main(int argc, char **argv)
 		}
 		if (n == 0) {
 			usage();
-			exit(0);
+			exit(EXIT_SUCCESS);
 		}
 		interval = n;
 	}
diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.c
index 574fa6ed..df4a77e8 100644
--- a/libselinux/utils/compute_av.c
+++ b/libselinux/utils/compute_av.c
@@ -51,5 +51,5 @@ int main(int argc, char **argv)
 		printf("\n");
 	}
 
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute_create.c
index 4abc29fb..449ccd90 100644
--- a/libselinux/utils/compute_create.c
+++ b/libselinux/utils/compute_create.c
@@ -32,5 +32,5 @@ int main(int argc, char **argv)
 
 	printf("%s\n", buf);
 	freecon(buf);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compute_member.c
index 14edd451..c6dad19e 100644
--- a/libselinux/utils/compute_member.c
+++ b/libselinux/utils/compute_member.c
@@ -32,5 +32,5 @@ int main(int argc, char **argv)
 
 	printf("%s\n", buf);
 	freecon(buf);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/compute_relabel.c
index 970750e8..85c760bc 100644
--- a/libselinux/utils/compute_relabel.c
+++ b/libselinux/utils/compute_relabel.c
@@ -32,5 +32,5 @@ int main(int argc, char **argv)
 
 	printf("%s\n", buf);
 	freecon(buf);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/compute_user.c b/libselinux/utils/compute_user.c
index cae62b26..86d00a6e 100644
--- a/libselinux/utils/compute_user.c
+++ b/libselinux/utils/compute_user.c
@@ -27,12 +27,12 @@ int main(int argc, char **argv)
 
 	if (!buf[0]) {
 		printf("none\n");
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	for (ptr = buf; *ptr; ptr++) {
 		printf("%s\n", *ptr);
 	}
 	freeconary(buf);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/getfilecon.c b/libselinux/utils/getfilecon.c
index a7a51abb..6266ae16 100644
--- a/libselinux/utils/getfilecon.c
+++ b/libselinux/utils/getfilecon.c
@@ -23,5 +23,5 @@ int main(int argc, char **argv)
 		printf("%s\t%s\n", argv[i], buf);
 		freecon(buf);
 	}
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/getpidcon.c b/libselinux/utils/getpidcon.c
index 3df0da1f..ea6c274e 100644
--- a/libselinux/utils/getpidcon.c
+++ b/libselinux/utils/getpidcon.c
@@ -27,5 +27,5 @@ int main(int argc, char **argv)
 
 	printf("%s\n", buf);
 	freecon(buf);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
index c33a4ad2..9193fe0a 100644
--- a/libselinux/utils/getseuser.c
+++ b/libselinux/utils/getseuser.c
@@ -36,5 +36,5 @@ int main(int argc, char **argv)
 	for (i = 0; i < n; i++)
 		printf("Context %d\t%s\n", i, contextlist[i]);
 	freeconary(contextlist);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/policyvers.c b/libselinux/utils/policyvers.c
index 0309d7d1..dd56f2c7 100644
--- a/libselinux/utils/policyvers.c
+++ b/libselinux/utils/policyvers.c
@@ -14,5 +14,5 @@ int main(int argc __attribute__ ((unused)), char **argv)
 	}
 
 	printf("%d\n", rc);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
diff --git a/libselinux/utils/setfilecon.c b/libselinux/utils/setfilecon.c
index d69af84a..79af55de 100644
--- a/libselinux/utils/setfilecon.c
+++ b/libselinux/utils/setfilecon.c
@@ -20,5 +20,5 @@ int main(int argc, char **argv)
 			exit(2);
 		}
 	}
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
-- 
2.21.0

