Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463EB1D133
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ll2J8TZi"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a235e394758so274121866b.1
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002215; x=1703607015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlPBJRCJAiUl6SzcrSl5tuliJRJLnt898mkFfNL7oSQ=;
        b=ll2J8TZiAV58USCix789cQZ4S+IANGn0OQiLUHHOMjaffdGAw02e5pIScos8Eci/Su
         rxET3OexxOksGLsZquudw3K+4jBzRBQP8lsiQo8wUJOSIvWhdFym6eeER9D1E1GJtGBx
         qfqCo4N062QcowcY+Is32PSxBhoJD/hiEJ6Tm42x5Z6IKFJSIfk7dji/wzjuChAZeoX0
         ZhUB09qapIgjWP3MAnOq/3f8Ly52Lp/4UEXSOuhSTo4ZQqowrUAWoVWKMz3vclB7zYXh
         Jh55L9EWQXBeWvMT9dS6OPFOypyh1akDJp6S/4hpmVL0NVqOZ1Vy9O2Otdjb4QHv/TpA
         yR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002215; x=1703607015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlPBJRCJAiUl6SzcrSl5tuliJRJLnt898mkFfNL7oSQ=;
        b=VhUYCbOO47uK0nODYnUMqJKzyI7XD2lfAg/nXeXlX3nsJgygez2xM6zcjb+sXocelt
         UGKCyFYqGz1vxtZ2U03L7jwafDdgioxG9/Ye5k7XfCsoqyXcqb2mU5tpOAg/r4wzfPlN
         h4BFzwnrZW+rnL7PPaZrlS4b7VN4WsSagFdzmBNttlPWHZDwMP7u0qFz9nVcXrZTtxhm
         MdfnHcs2BoHtbd2ALPOwU9c2UL9WxLMIwINvPMs1jkmxVM2FpxmDJxmCtTlsRk9x4/0v
         f90mxw3ksjyG28HA+uVdlbzF4qhmdmQZOp5F3AfSo1juuuCe5qb6O1XYCD9yZ1s4aqOg
         ezZA==
X-Gm-Message-State: AOJu0YzCx8Znps3oNL7B3PH/M9TTw1CGV0+kOPxUxV4+uacuWnrOf6fE
	+PE+z14doOz0w4tS6/wK3Gk3/0Fq2eQ=
X-Google-Smtp-Source: AGHT+IHlkqFu6v8JmLi5mzK881Xnu7Dq4XjUME+ykQtecw+0+0xIImBNLS8DUdcKsGKQitef76tWfw==
X-Received: by 2002:a17:906:a85a:b0:a23:5974:3cb2 with SMTP id dx26-20020a170906a85a00b00a2359743cb2mr1961427ejb.116.1703002215555;
        Tue, 19 Dec 2023 08:10:15 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:15 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 06/11] libselinux: fail selabel_open(3) on invalid option
Date: Tue, 19 Dec 2023 17:09:28 +0100
Message-ID: <20231219160943.334370-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Return an error on invalid selabel_open(3) options, e.g. an option for
a different backend was used.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_backends_android.c | 7 +++++++
 libselinux/src/label_db.c               | 8 ++++++++
 libselinux/src/label_file.c             | 7 +++++++
 libselinux/src/label_media.c            | 7 +++++++
 libselinux/src/label_x.c                | 7 +++++++
 5 files changed, 36 insertions(+)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index cd3875fc..7ddacdbe 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -157,6 +157,13 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
 			break;
+		case SELABEL_OPT_UNUSED:
+		case SELABEL_OPT_VALIDATE:
+		case SELABEL_OPT_DIGEST:
+			break;
+		default:
+			errno = EINVAL;
+			return -1;
 		}
 
 	if (!path)
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 3f803037..2daf1770 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -268,6 +268,14 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 		case SELABEL_OPT_PATH:
 			path = opts[nopts].value;
 			break;
+		case SELABEL_OPT_UNUSED:
+		case SELABEL_OPT_VALIDATE:
+		case SELABEL_OPT_DIGEST:
+			break;
+		default:
+			free(catalog);
+			errno = EINVAL;
+			return NULL;
 		}
 	}
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 4778f8f8..315298b3 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -812,6 +812,13 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		case SELABEL_OPT_BASEONLY:
 			baseonly = !!opts[n].value;
 			break;
+		case SELABEL_OPT_UNUSED:
+		case SELABEL_OPT_VALIDATE:
+		case SELABEL_OPT_DIGEST:
+			break;
+		default:
+			errno = EINVAL;
+			return -1;
 		}
 
 #if !defined(BUILD_HOST) && !defined(ANDROID)
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index b3443b47..4c987988 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -85,6 +85,13 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
 			break;
+		case SELABEL_OPT_UNUSED:
+		case SELABEL_OPT_VALIDATE:
+		case SELABEL_OPT_DIGEST:
+			break;
+		default:
+			errno = EINVAL;
+			return -1;
 		}
 
 	/* Open the specification file. */
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index e15190ca..f332dcb6 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -112,6 +112,13 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		case SELABEL_OPT_PATH:
 			path = opts[n].value;
 			break;
+		case SELABEL_OPT_UNUSED:
+		case SELABEL_OPT_VALIDATE:
+		case SELABEL_OPT_DIGEST:
+			break;
+		default:
+			errno = EINVAL;
+			return -1;
 		}
 
 	/* Open the specification file. */
-- 
2.43.0

