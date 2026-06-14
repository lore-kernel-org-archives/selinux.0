Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5130E859
	for <selinux@vger.kernel.org>; Sun, 14 Jun 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781440169; cv=none; b=TNgmRPl12HQtiQQfrNjNNqR3gv2c6xDY1xHZ38VVYKXc+yHIE2oVwjDuhjn+HZw3LWFBC3sTc4nxhrjhp19TC/sGtTrTDy9C/gwzoNc4x2fxSa+zo+k5wmkLUQZmRa7NO+DsK95TLXLaAD4deUFAX1czZ3LuV7Dl4SfTd8qstyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781440169; c=relaxed/simple;
	bh=Hnsyz7QmuJcjJHqs534PH0M4XWPjEDvowRTm0t9t080=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooipP4V5oAX3qCuKdwM+eJLqUdfuWAWc9zkzXqEDhjsC92wLCKuw+nPE4eLefY7IiYBJgtJzF0Us1j1U2dP0V4+uNNAepWRGdRZNAZkv3JIY5Rwmh3k3HDb2tx7nuhym2vkQjKRYyZ2f9vPoTdVqecnscYVBiERrgH3i1XPVPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=RnYIqr5C; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="RnYIqr5C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+ZL6rSMsq/2rDmvd2tkH97VsTimDtDP/UE48Zy9KW7w=; b=RnYIqr5C3NjGGUUA8rrR2hDYYN
	vHkULSkyqKDoID3JyWJrv69Kc27TinAVCu1ireIaxzNfQGAKxSS6F8LNkt7z1jhtSbIMjW6++Ut51
	sKQHJ38uoprGlVEy1Qe+dIXGk2e/oPz69vTYWmZJW1QM7Ddx2MIFD+QHtitdGSgTIqyq86ESGUshD
	sw4x1M+yOgcId9Vw6S9UKT8Cw0toYfMd7fYI6ne122S0L/rnKtReFaV4jb17FkSHZWI4sy1CPO2wY
	mWY8y0CnhUD20pHP8DCe7Sx7gI5h/oaEojJP9qUgxc/+ZIC1AbxD/BweVfhR26PSb60t+lK5ps68P
	R0vUHZhg==;
Received: from 87-95-76-183.bb.dnainternet.fi ([87.95.76.183]:4557 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wYjxm-00000007yqE-12Yu;
	Sun, 14 Jun 2026 15:29:18 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 1/2] policycoreutils: use stderr for error messages
Date: Sun, 14 Jun 2026 15:29:03 +0300
Message-ID: <20260614122904.29873-2-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614122904.29873-1-kalevi@kolttonen.fi>
References: <20260614122904.29873-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 policycoreutils/sestatus/sestatus.c | 50 ++++++++++++++++-------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 637f26eb..0effc4ad 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -100,7 +100,7 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 	int filelen = strlen(FILES);
 
 	if (fp == NULL) {
-		printf("\nUnable to open %s.\n", CONF);
+		fprintf(stderr, "\nUnable to open %s.\n", CONF);
 		return;
 	}
 
@@ -158,8 +158,9 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 					break;
 				default:
 					/* ignore lines before a section */
-					printf("Line not in a section: %s.\n",
-					       buf);
+					fprintf(stderr,
+						"Line not in a section: %s.\n",
+						buf);
 					break;
 				}
 			}
@@ -234,7 +235,7 @@ int main(int argc, char **argv)
 		return 0;
 		break;
 	default:
-		printf("unknown (%s)\n", strerror(errno));
+		fprintf(stderr, "unknown (%s)\n", strerror(errno));
 		return 0;
 		break;
 	}
@@ -251,13 +252,13 @@ int main(int argc, char **argv)
 	printf_tab("SELinux root directory:");
 	root_dir = selinux_path();
 	if (root_dir == NULL) {
-		printf("error (%s)\n", strerror(errno));
+		fprintf(stderr, "error (%s)\n", strerror(errno));
 		return -1;
 	}
 	/* The path has a trailing '/' so duplicate to edit */
 	root_path = strdup(root_dir);
 	if (!root_path) {
-		printf("malloc error (%s)\n", strerror(errno));
+		fprintf(stderr, "malloc error (%s)\n", strerror(errno));
 		return -1;
 	}
 	/* actually blank the '/' */
@@ -273,7 +274,7 @@ int main(int argc, char **argv)
 		puts(pol_name);
 		free(pol_path);
 	} else {
-		printf("error (%s)\n", strerror(errno));
+		fprintf(stderr, "error (%s)\n", strerror(errno));
 	}
 
 	printf_tab("Current mode:");
@@ -286,7 +287,7 @@ int main(int argc, char **argv)
 		printf("permissive\n");
 		break;
 	default:
-		printf("unknown (%s)\n", strerror(errno));
+		fprintf(stderr, "unknown (%s)\n", strerror(errno));
 		break;
 	}
 
@@ -304,7 +305,7 @@ int main(int argc, char **argv)
 			break;
 		}
 	} else {
-		printf("error (%s)\n", strerror(errno));
+		fprintf(stderr, "error (%s)\n", strerror(errno));
 	}
 
 	printf_tab("Policy MLS status:");
@@ -317,7 +318,7 @@ int main(int argc, char **argv)
 		printf("enabled\n");
 		break;
 	default:
-		printf("error (%s)\n", strerror(errno));
+		fprintf(stderr, "error (%s)\n", strerror(errno));
 		break;
 	}
 
@@ -331,7 +332,7 @@ int main(int argc, char **argv)
 		printf("denied\n");
 		break;
 	default:
-		printf("error (%s)\n", strerror(errno));
+		fprintf(stderr, "error (%s)\n", strerror(errno));
 		break;
 	}
 
@@ -345,14 +346,14 @@ int main(int argc, char **argv)
 		printf("requested (insecure)\n");
 		break;
 	default:
-		printf("error (%s)\n", strerror(errno));
+		fprintf(stderr, "error (%s)\n", strerror(errno));
 		break;
 	}
 
 	rc = security_policyvers();
 	printf_tab("Max kernel policy version:");
 	if (rc < 0)
-		printf("unknown (%s)\n", strerror(errno));
+		fprintf(stderr, "unknown (%s)\n", strerror(errno));
 	else
 		printf("%d\n", rc);
 
@@ -377,7 +378,8 @@ int main(int argc, char **argv)
 					printf("off");
 					break;
 				default:
-					printf("unknown (%s)", strerror(errno));
+					fprintf(stderr, "unknown (%s)",
+						strerror(errno));
 					break;
 				}
 				c = security_get_boolean_pending(bools[i]);
@@ -390,8 +392,9 @@ int main(int argc, char **argv)
 						printf(" (inactivate pending)");
 						break;
 					default:
-						printf(" (pending error: %s)",
-						       strerror(errno));
+						fprintf(stderr,
+							" (pending error: %s)",
+							strerror(errno));
 						break;
 					}
 				printf("\n");
@@ -415,14 +418,14 @@ int main(int argc, char **argv)
 		printf("%s\n", context);
 		freecon(context);
 	} else
-		printf("unknown (%s)\n", strerror(errno));
+		fprintf(stderr, "unknown (%s)\n", strerror(errno));
 
 	printf_tab("Init context:");
 	if (getpidcon(1, &context) >= 0) {
 		printf("%s\n", context);
 		freecon(context);
 	} else
-		printf("unknown (%s)\n", strerror(errno));
+		fprintf(stderr, "unknown (%s)\n", strerror(errno));
 
 	for (i = 0; i < npc; i++) {
 		rc = pidof(pc[i]);
@@ -445,7 +448,7 @@ int main(int argc, char **argv)
 		printf("%s\n", context);
 		freecon(context);
 	} else {
-		printf("unknown (%s)\n", strerror(errno));
+		fprintf(stderr, "unknown (%s)\n", strerror(errno));
 	}
 
 	for (i = 0; i < nfc; i++) {
@@ -454,8 +457,9 @@ int main(int argc, char **argv)
 
 			/* check if this is a symlink */
 			if (lstat(fc[i], &m)) {
-				printf("%s (could not check link status (%s)!)\n",
-				       context, strerror(errno));
+				fprintf(stderr,
+					"%s (could not check link status (%s)!)\n",
+					context, strerror(errno));
 				freecon(context);
 				free(fc[i]);
 				continue;
@@ -469,8 +473,8 @@ int main(int argc, char **argv)
 					printf("%s\n", context);
 					freecon(context);
 				} else {
-					printf("unknown (%s)\n",
-					       strerror(errno));
+					fprintf(stderr, "unknown (%s)\n",
+						strerror(errno));
 				}
 			} else {
 				printf("%s\n", context);
-- 
2.54.0

