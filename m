Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388545;
	b=rWpYmfrOqNGyRZna5GxGkLbKCFzbBl3kwrEddT5AcUvL5v/9AUjztGtzPHBFTzKOf/vh
	 JYGB5bw+Ev1JfzVYEnSZSqmXhbBeFV3WbinuaR4KPe8hn+Fq3lBGe4MvUsbJtdBZc3xWV
	 qx3u6rYDhtJZdq+foFqFQfrzK7uLS6DMs0l3rpSOWMzHv2K/nDDL+WMWTbSKSQ1QhxNxX
	 SIr9kYKMkzG0Qin41PYWXzb2Q9KETeLLVR2k7r7MauXuA7YHB94gbLVOPB5MTWhJYjVI9
	 EUxepXigUhLo4S9Veh7iPDjx5lyClnquRboPPC3xQFmddFE7HZVKnkd8nZn3d0Rh6VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1lW0ZDbFZ0v6uKwWJWFPrl5LtrRuL4MIrbyJRozzGo0=;
	b=oPoLmC3AngZ8LNw5RmDWhUbBm9oNobYCFUVmmrTa+LtdWEmp2VpZktJY1PRjOLaOYNud
	 zQJtffAUv0MYnpJJ3Hm24UrR8ttiugMsjDGfPm+38G4ObBFJ8l7deA+fTmgpCi9W3abO4
	 p7SZBeuhf7XeOufDuybqfEmHo2S82wtl9clvXSEuk+Ca5Pv7bVI3ZguSaLDQpXoFs5K7C
	 hFuLT0HGgJu4mrLw+P4oYDYfVMVHsvQdZZZkW4JZrnSJ1ITQQd/p0BJ7hJ1MOrz4DkGKN
	 4hpf/imHugNbzQV6MAUwQf0IYyF1fa0vz7wkqNzLnPaPAduiuNGVD62+7ONlCntH7XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cNiwhheR;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51531606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51531606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cNiwhheR
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c7a706b1fso30777906d6.1
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388544; x=1793993344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1lW0ZDbFZ0v6uKwWJWFPrl5LtrRuL4MIrbyJRozzGo0=;
        b=cNiwhheRiJihHx0AyWEaoFxRMiMK2sr2+l56d6Sw31cDX/l8zfkrHm6Vor/6jr3CVV
         doz2KlwcIs2hGUhy42N5fugMfaXT+vIPcxTyneApm6DzHwsp+V5L0Ca7yNvl1sxoM7Yh
         runf1JhyHwRa2KAcyi7ElI1/1Vfke2n1i+cNpm9Yn5+f4qTQ/mV3GYHZY2sLv26RatTU
         E269SaoYIzkNEq1krkmKfKESinEwJfOLwOumCM1MPno/sVnbvdw45IoV0RAIUNQoC5Px
         2z4f1jStnEM3h8GBiNXWkvMB1sD7rJPVa/0G/K84mSXmFqEn4oQh+uMiSfPeg0+z7l8o
         avIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388544; x=1793993344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1lW0ZDbFZ0v6uKwWJWFPrl5LtrRuL4MIrbyJRozzGo0=;
        b=C8UNp/p8I9SJMlYSlQRUyLCNdzpBngYHg96BAHe4DzIWpRV6aMqTC7VRz4kAM4objY
         fldTLbzqQFGijFHbwEKL8P7kChQGs0qfUkMFPo37ji6WnxJxGOUZR5qUHw0p/GR4Pv/U
         rUUhjjVsAX14eRGrlyEHf5egvetkkbDtCZdyOdDc+h5EELijE6a/pyl90cpgJFW2BH/x
         QTotVnFzo+BEK2+kHlU/rWGaynLqJK8du+HMzxh0zTDGCRjzK1TQyU1jGVBdTtYE9pEs
         NHCKpxVmg0pwK05m/Whq1f+PzGlpB3jV3nXM2r1kHO9BwHsORHHlKbd4EA6GpE9KaWDu
         8oiA==
X-Gm-Message-State: AFq9FYLTndQf0Hc7aAQI/kciDyGRrl1BSrrUSQ8bSolMNZIyFs6SlfDO
	cg7n1Gy5o4NcqaL/wLc0bLZy4kaTbVUss6qK7m/sQ6sMBvUR7JTwqkWn7xCQeiFv
X-Gm-Gg: AYBFou1TTFg0euJ8pIuRzhuiFMIsjB9VpVggGZDwebypujPuF67j7/1utHwvZYnZLSQ
	6xSQ1Nx1/q4thamG2botPcQv+oxV2oK0ulNpFZPRHRvS58ZZmyaFeCEuO2g7UYLcux79Gcx/80Q
	atoInGJI58KW0NefX7tJvFcAPQMpC8OFNY07Zo9avlY0YoE9le3Kdc2hWbnbKQRyO7qPEpouh3k
	YG/BsuFWmT2kYgV9dAlPU/nb7jvaN4ib3IVHrR9Romgwd1JdcQsrzre1wmHCkZHG3pord705aBF
	jtnopNxRqELMZ93Vp8jaYcVDMMpqlJkWtL7DjDnf+MSMRv88MzBkL4cI16+jAjbA1FsKnlmchMo
	3/sfKGmy5+joBH5SvQc3ZXTHuZpY3t0y2RK4copxG6+mDPPbk0LMAoL8T4wjlgSMzLBfUeY8zhb
	5jdgJovtO98mydMvrpKG2TGTIFiYPZ6thadWYSVl0cTqxp7CvJ8knBLyTnU5EeVOxiuE2NNdjQV
	eUrk4hXC5fQ2t6gUFHoI4lO6kgt8SbVRtc2DVACm4x/Wmg6WhGNfYDNVdookIqG4B1Bx9omIF9D
	zPDyQl9MLLstCaAr3fUY7aZSG8IpWHFTfTLydAoJ9L9rSSWqnHteBG0V02nhoPmv4D94FaIdUaF
	oM+wW/o0sU6wbDmLaoINEW1cYxsfEQGkY+0/n+WnSdBR+rzGGIMvdS9JYb2qXXpDWJMWCAAn9S+
	FP2Xzv/am53BeZubf7WgendQ5c2lkAkuEdE2TxuMqSFFpV7rfmH8Q=
X-Received: by 2002:ac8:5f96:0:b0:535:52c:a2e2 with SMTP id d75a77b69052e-542b7337ab0mr51371751cf.20.1793388544109;
        Fri, 30 Oct 2026 12:29:04 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 02/11] libsemanage: propagate file database read failures
Date: Fri, 30 Oct 2026 15:28:39 -0400
Message-ID: <20261030192849.151830-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
References: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_skip_space() treats every getline() failure as end of file. An I/O
or allocation failure can therefore produce a successful empty or
partial cache, which a later modification may write back while
discarding local records.

Require a clean EOF indication for a present stream and reject stream
errors. Preserve the successful absent optional-file case. Add fault-
injection coverage for EIO, ENOMEM, EOF, and error plus EOF before and
after a complete record.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/parse_utils.c                 |  8 +-
 libsemanage/tests/.gitignore                  |  1 +
 libsemanage/tests/Makefile                    |  9 ++-
 .../tests/regression/test_parse_read_error.c  | 75 +++++++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_parse_read_error.c

diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index b3b8e94b..034f223a 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -120,8 +120,14 @@ int parse_skip_space(semanage_handle_t *handle, parse_info_t *info)
 		}
 	}
 
+	if (info->file_stream &&
+	    (ferror(info->file_stream) || !feof(info->file_stream))) {
+		ERR(handle, "could not read file %s.", info->filename);
+		free(buffer);
+		return STATUS_ERR;
+	}
+
 	free(buffer);
-	buffer = NULL;
 
 	return STATUS_SUCCESS;
 
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 796479e6..303fbf03 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,3 +1,4 @@
 libsemanage-tests
 test-user-join-transaction
+test-parse-read-error
 *.policy
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index cef19b42..d847ae96 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -6,6 +6,7 @@ CILS = $(sort $(wildcard *.cil))
 
 EXECUTABLE = libsemanage-tests
 USER_JOIN_TEST = test-user-join-transaction
+ERROR_TESTS = test-parse-read-error
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
@@ -13,7 +14,10 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(ERROR_TESTS)
+
+test-parse-read-error: regression/test_parse_read_error.c ../src/parse_utils.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
 
 $(USER_JOIN_TEST): regression/test_user_join_transaction.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -25,8 +29,9 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(ERROR_TESTS)
 
 test: all
 	./$(EXECUTABLE)
 	./$(USER_JOIN_TEST)
+	./test-parse-read-error
diff --git a/libsemanage/tests/regression/test_parse_read_error.c b/libsemanage/tests/regression/test_parse_read_error.c
new file mode 100644
index 00000000..9afa38a2
--- /dev/null
+++ b/libsemanage/tests/regression/test_parse_read_error.c
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include "handle.h"
+
+static int read_calls;
+static int injected_errno;
+static int stream_error;
+static int stream_eof;
+static int give_record;
+
+static ssize_t injected_getline(char **line, size_t *size, FILE *stream)
+{
+	(void)stream;
+	read_calls++;
+	if (give_record) {
+		*line = strdup("record\n");
+		assert(*line);
+		*size = 8;
+		give_record = 0;
+		return 7;
+	}
+	errno = injected_errno;
+	return -1;
+}
+
+#define getline injected_getline
+#undef ferror
+#undef feof
+#define ferror(stream) ((void)(stream), stream_error)
+#define feof(stream) ((void)(stream), stream_eof)
+#include "../../src/parse_utils.c"
+#undef getline
+
+int main(void)
+{
+	semanage_handle_t sh = { 0 };
+	parse_info_t info = { .filename = "local records",
+			      .file_stream = stdin };
+	int errors[] = { EIO, ENOMEM, 0, EIO };
+	unsigned int i, after_record;
+	int rc;
+
+	for (after_record = 0; after_record < 2; after_record++) {
+		for (i = 0; i < sizeof(errors) / sizeof(errors[0]); i++) {
+			give_record = after_record;
+			if (give_record) {
+				assert(parse_skip_space(&sh, &info) == 0);
+				assert(strcmp(info.ptr, "record") == 0);
+				info.ptr += strlen(info.ptr);
+			}
+			injected_errno = errors[i];
+			stream_error = errors[i] == EIO;
+			stream_eof = i >= 2;
+			rc = parse_skip_space(&sh, &info);
+			printf("getline errno=%d: parser rc=%d null_ptr=%d\n",
+			       injected_errno, rc, info.ptr == NULL);
+			assert(rc == (errors[i] ? -1 : 0) && info.ptr == NULL);
+			if (errors[i])
+				assert(errno == errors[i]);
+		}
+	}
+	info.file_stream = NULL;
+	i = read_calls;
+	assert(parse_skip_space(&sh, &info) == 0);
+	assert(read_calls == (int)i);
+	puts("Parser read-error, EOF, and absent-file controls passed.");
+	return 0;
+}
-- 
2.56.0

