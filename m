Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H5JFUj005851
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:19:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40mfjq4zQmz2NhLm
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 05:19:11 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40mfjp6T6Pz2NhLj
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 05:19:10 +0000 (UTC)
Received: by mail-pg0-f42.google.com with SMTP id p9-v6so1281847pgc.9
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 22:19:09 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Thu, 17 May 2018 13:11:14 +0800
Message-Id: <20180517051117.48454-3-jason@perfinion.com>
In-Reply-To: <20180517051117.48454-1-jason@perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
Subject: [PATCH 2/5] libselinux: enable linking to musl-fts
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Musl libc does not include the fts(3) functions so need to link to the
musl-fts library
https://github.com/pullmoll/musl-fts

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libselinux/src/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 8af04aab..977b5c8c 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -98,6 +98,8 @@ LD_SONAME_FLAGS=-install_name,$(LIBSO)
 endif
 
 PCRE_LDLIBS ?= -lpcre
+# override with -lfts when building on Musl libc to use fts-standalone
+FTS_LDLIBS ?=
 
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
@@ -149,7 +151,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
2.16.1
