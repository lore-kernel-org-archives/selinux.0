Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDF27470
	for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481782; cv=none; b=ZTd63gRMUnUn5LpF6LcN7YgsTHEGjGNuC2GFUSKpUCk/fqDiBJWRWHtxxLAykB4/Ar0lMxYEMGboQNp3d5mArf8tlL0QEMnHYO7HO9nvaPubL9sPXhZ8R6RjiUXiR2QCDoqewCs1KrLImFjVMxWC0XMJ3cUyg5b6L701TI7HpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481782; c=relaxed/simple;
	bh=LSlIvR1j3Q00wSKhv8deoAR62ew71tpXdC0QZImkY84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dditdwDNg60eHPHQ9b5pF3FFkbB7ritVp8OyLhe+IA/MY3uxBpORivRvciSDbDnDixZlGtVkjUemUeNhW8gi6BmGXeRLjnQEIXdCKgLnNkFOAuk92dtJhUEoYMYl2TswYQXA7xpjCn1PjMo6sFf/0jdA1QnAsq7HMf2WFdbwvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6picWyP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6picWyP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so22351255e9.3
        for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753481779; x=1754086579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+LPHGuS6e9/ix10FODa+kQfX9V4vbk1pysubmDZ/qE=;
        b=D6picWyPecWCbkWAwMdhDDrISThkaTx1r16zI5vMq0Y2/naiYCS9JgkDALwZJKYhBE
         5V4f9NMKmQlEXcvVmKLWUNZNsdEukjNkiQnXIn3v4MBwg/943Er+lNvZ7/A1k/AjYsdv
         8lx7hmKNquDBG5MCQjKDwi/9uuXa9NX43I95rpschqtSnk5ISWQgI/+lRQv1PNFj2qIk
         9YUDUen66g3o3whbddrrRMVejavgpvOBSptD7GphrGxVXxRu4WHufGj0sT3FxNlrE/y0
         zcPIrqXNgf+MQR3XOHEDDmn5CziQdg628ykWdlNEYFCRoiwivWcQBIxQqEQZYSEBkLb1
         ol3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753481779; x=1754086579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+LPHGuS6e9/ix10FODa+kQfX9V4vbk1pysubmDZ/qE=;
        b=hSROgSmY0FCTluvH1dp4LOkBGBb9JQay1yhTnbqzB8OXcqqkj38CVSzA88aMaixUCg
         wuTJ5d6yi6j6/OeLeENScbnconiAhz2K11qq8FoMdCnpCekG/K2e6m+PgLF0bx2+Nug+
         KFLVV391FIS+BPfMEwZ4c3vG6ZPvUhoNcWu5GxX9ZOTKuXy9RrkY0Keeeu4dspPxAVyC
         a441N7mOJMvH1Hp2qcfzkhYWXAbQfJwOVSn7h0BPnMvjZ5szMs0fWVoM4AQ73yXlmzUb
         GgIC/DAbrOzvh51zw7m29ZeiYKaKCHnInLIvtKVEQKLsF+XlnPgn0sFf82pDI2R4yptI
         f9pw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZhRc21aTLsCqjE/VNevdVfYWQSf820lgj11HOjteeqnDXC1AGdAnFRvEmXAvu3Kp9SqbX8ya@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxV9irCf0MRUYxuzlKfs5h+GgGGyaabjMdlpguLqfGiIUyEo1
	ived9T1nMVtRdcZGvY+Rk/MsAL78LdHDI4VeQmzVsQqXI0WOPrmXBF/F
X-Gm-Gg: ASbGncvRYG9F8wubonkhzDtU1qtdWBO9S3IF9hFWk2XyEN5uQemzPE/g3sIPrOm/r5x
	OoE8vfDwa3jne2tByawVkDR/s05FazZCQmwmLz65JK05k20S/GdvB1QJBLviK6ZgeLV5mNZAKOV
	9XdqOVIrMsrno1/tDUp4Q+zXJwY1808dYhy93jll9Du+tLJdKQAjEHorwz8HaFejgVQj+NZvXCL
	8sX1MieMK/fBKB4fwTo0z50H2Q2I+qUshSe7F6dQm2fb31PJ4lvmUVNuPQOnP9rREsOJiQ8Ygaa
	xemXmoK2lhe1JVQmJR58Tq6ONidCUz+Zag0fWFmEXBewAyjTuhYews8ByLtKuC0tuf1lUXmFYKo
	3SueGjge1koa5
X-Google-Smtp-Source: AGHT+IGp6n47/smGvSeWwTgRzKc40v8W3sfTA21F1dhrmfzmHYJeXkIgMCCA4Qd56/7gPEr/7QfSZw==
X-Received: by 2002:a05:6000:4009:b0:3a4:ea8f:efe4 with SMTP id ffacd0b85a97d-3b7765ec775mr2483246f8f.18.1753481779059;
        Fri, 25 Jul 2025 15:16:19 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba147sm976719f8f.27.2025.07.25.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 15:16:17 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: jwcart2@gmail.com,
	nvraxn@gmail.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	plautrba@redhat.com,
	selinux@vger.kernel.org
Subject: [PATCH v5] libselinux: fix parsing of the enforcing kernel cmdline parameter
Date: Fri, 25 Jul 2025 23:15:26 +0100
Message-ID: <20250725221525.479629-2-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ6nRZ50-L5wDtnppC641OjuEzO8QRUhGjJXcT5iKTNfbQ@mail.gmail.com>
References: <CAEjxPJ6nRZ50-L5wDtnppC641OjuEzO8QRUhGjJXcT5iKTNfbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, parsing of the cmdline has two issues:
- By using atoi, no error checking is done. What happens if an argument
  that isn't an integer is provided, e.g. enforcing=foo? And as there
  is also no validation that the number provided is actually valid, 1
  or 0, what happens if enforcing=2?

- After the first strstr, no arguments that follow are searched for; if
  I have enforcing=0 enforcing=1, the latter enforcing=1 is not taken
  into account. This is made even worse due to halting searching after
  finding the first "enforcing=" token, meaning that if the cmdline was
  as follows:

  fooenforcing=0 enforcing=0

  the enforcing parameter is entirely ignored.

This patch fixes this by:

  - Using strtol to actually validate that we got passed a number, and
    if not default to 0 (i.e. permissive mode) as per kernel behaviour.
    If given a positive integer that isn't 1, also treat that as 1 (so
    enforcing mode).

  - Looping until the last "enforcing=" in the cmdline. Latter (valid)
    arguments take precedence over previous arguments.

For the case where "enforcing=" is provided with a valid integer, 0 is
treated as permissive mode, and anything else (such as 1 or 2, etc) is
treated as enforcing mode. When "enforcing=" is passed an argument that
is not a valid integer (such as "on"), default to enforcing=0, i.e.
permissive mode. This is in line with how the kernel parses the
enforcing parameter.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/load_policy.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

v2: Follow the same argument parsing behaviour as the kernel does.
v3: Actually follow the kernel's behaviour where "enforcing=" is not
    provided with a valid integer...
v4: Update the commit message to also reflect the behaviour above.
v5: Advance past sizeof("enforcing=") - 1 instead of just 1

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index dc1e4b6e..f67e5538 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -244,17 +244,28 @@ int selinux_init_load_policy(int *enforce)
 	rc = mount("proc", "/proc", "proc", 0, 0);
 	cfg = fopen("/proc/cmdline", "re");
 	if (cfg) {
-		char *tmp;
 		buf = malloc(selinux_page_size);
 		if (!buf) {
 			fclose(cfg);
 			return -1;
 		}
-		if (fgets(buf, selinux_page_size, cfg) &&
-		    (tmp = strstr(buf, "enforcing="))) {
-			if (tmp == buf || isspace((unsigned char)*(tmp - 1))) {
-				secmdline =
-				    atoi(tmp + sizeof("enforcing=") - 1);
+		if (fgets(buf, selinux_page_size, cfg)) {
+			char *search = buf;
+			char *tmp;
+			while ((tmp = strstr(search, "enforcing="))) {
+				if (tmp == buf || isspace((unsigned char)*(tmp - 1))) {
+					char *valstr = tmp + sizeof("enforcing=") - 1;
+					char *endptr;
+					errno = 0;
+					const long val = strtol(valstr, &endptr, 0);
+					if (endptr != valstr && errno == 0) {
+						secmdline = val ? 1 : 0;
+					} else {
+						secmdline = 0;
+					}
+				}
+				/* advance past the current substring, latter arguments take precedence */
+				search = tmp + sizeof("enforcing=") - 1;
 			}
 		}
 		fclose(cfg);
-- 
2.50.1

