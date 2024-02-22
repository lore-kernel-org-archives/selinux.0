Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C11DFD9
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630287; cv=none; b=CuCznwBuXxg4R5boS1Sz1TEUFexvDPz03tihxcQYTxweMftKFG17p9gCAEvbT2fQf54zmmkSd8/ehj18oU3GtKVaha23JWGDpCJbUZzO7WINEUscPR+M2I2X5Q2b+VW1XCd/XBHYtuLqW8Q8rED0WIazNTNTzb3RrGmjnB6HLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630287; c=relaxed/simple;
	bh=qRCcXC7a8pD17pLsrdnJoTeM3ukWnuZfEqaIix6aiTI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJCJvKEAP9LBDl/LrFJlFQlv7otGUsOTOIq2pD+uyu7EVavW3KuxxyM/21tSjzyLkp1/5Xr6nEKV/kaBU44Fs7cHMDV62qZLnFf8Jm57rcAk6cP8UuQB1p+MoDoaP7Q6Qk05iv92f+5/l7dDJBAXoZes68yEdS1l9s3eGW+SNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M+GzbKZc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M+GzbKZc"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so416992a12.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 11:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708630283; x=1709235083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbGB/uwkySIfZeq38xrTsdj/lho0LNRjyJ/wCF/Rql8=;
        b=M+GzbKZcFUgHko+gTpgFk4jhC1d3hThRUc7Por0LunWWwyDT2OturwaVwJFeWUyb/o
         JuHU5SCj1Zz6vqfwqanQTfIh6wzIYnCTuFOr+0OxqRBlJCLZFjlZ0Eunwte/pBz9QXjf
         RjOX4K4SLaD8ZF08jPzbIOXtIipQ9eIZ6BdBvBZAk2Q8f6mMI2oAju0lYBDTwwLzty6a
         TKqWwdvmJU3SV+3XhqZt5hS0TdDBwm9BOGXchTG5eCOW9ToqFyqvp1hG+iPmm9e0446G
         mPNorZZRSqqWY2hwuTLDWYBIHnRntQxH6zpyr4Vj7XzKByT2KoscW9k0FIv5YSsxWvJZ
         fEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630283; x=1709235083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbGB/uwkySIfZeq38xrTsdj/lho0LNRjyJ/wCF/Rql8=;
        b=OkZWNXArHt772OpRyU4E9qRju+npSNbpa0gQ47BFScQRo4XhoOLP03giFxvIFYwP+P
         vRknQ0uJ7l7LoS8Z4cbgWIDRYyUCJhgjEQhTsDMQkngotmSnyERI8gI3VfhIQ/KlybH2
         5YJ+CIXIIzXz07bXwfeGTl/I+jaWh2tqix441CgB3QD2n7ahPigkIWqwi4lWAubzMAb6
         pPh5qYLL5qRyvOU/GTmzeE7b8gj5s6a7wAuTgGNAQegbh5E6bTDGxJNxI5qa1fotKTYO
         p/Yv+sIoiJk2ejnTcxR4KPivGTaaS5Kqu7N1SkAHyCzLRKe53d368kIbI4AEhOu4AOXh
         SIlQ==
X-Gm-Message-State: AOJu0Ywdgtg4hkYwwiqT0vdWgtKh1EcZQMzh9ZC/+wdLuLETnBDWZ/lj
	BtbFdOzOxvHJbBi8YZSwmbnY6Vc0ch6cltjcTrIhZxHjpMmJTpLJTnl9nD5b
X-Google-Smtp-Source: AGHT+IE9oCkbspuu9ljQv1kYLRzg4DBQ8ZVA/UX5g2ijipPN1j8y7/yOpo3WwII0d3MYPUVGRS7HmQ==
X-Received: by 2002:a17:906:e210:b0:a3c:5e17:1635 with SMTP id gf16-20020a170906e21000b00a3c5e171635mr3077387ejb.30.1708630283224;
        Thu, 22 Feb 2024 11:31:23 -0800 (PST)
Received: from ddev.DebianHome (dynamic-095-112-124-167.95.112.pool.telefonica.de. [95.112.124.167])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a3f0386dc96sm2728779ejc.89.2024.02.22.11.31.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:31:22 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH] sepolgen: adjust parse for refpolicy
Date: Thu, 22 Feb 2024 20:31:12 +0100
Message-ID: <20240222193117.17539-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently sepolgen fails to parse the reference policy:

    Parsing interface files:
    %--10---20---30---40---50---60---70---80---90--100
    #############/tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if: Syntax error on line 1737 - [type=MINUS]
    /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if: Syntax error on line 1755 - [type=MINUS]
    error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if: could not parse text: "/tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if: Syntax error on line 1755 - [type=MINUS]"
    /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error on line 43 - [type=MINUS]
    error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/selinux.if: could not parse text: "/tmp/destdir/usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error on line 43 - [type=MINUS]"
    ############################/tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if: Syntax error on line 183 $1_port_forwarding [type=IDENTIFIER]
    /tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if: Syntax error on line 293 ' [type=SQUOTE]
    error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if: could not parse text: "/tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if: Syntax error on line 293 ' [type=SQUOTE]"
    ######/tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Syntax error on line 2137 true [type=TRUE]
    /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Syntax error on line 2148 ' [type=SQUOTE]
    /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Syntax error on line 2152 ' [type=SQUOTE]
    /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Syntax error on line 2163 ' [type=SQUOTE]
    /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Syntax error on line 2167 ' [type=SQUOTE]
    error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: could not parse text: "/tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Syntax error on line 2167 ' [type=SQUOTE]"
    ##failed to parse some headers: /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if, /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/selinux.if, /tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if, /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if
    Missing interface definition for init_startstop_service
    Missing interface definition for init_startstop_service
    ...

Accept chained ifelse blocks, genfscon statements with file specifiers,
and booleans with unquoted identifiers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 74 +++++++++++++++++------
 python/sepolgen/src/sepolgen/refpolicy.py |  8 +++
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 1bb90564..e261d3f7 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -418,19 +418,41 @@ def p_tunable_policy(p):
         collect(p[12], x, val=False)
     p[0] = [x]
 
-def p_ifelse(p):
-    '''ifelse : IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
-              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
-              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+def p_ifelse_compare_value(p):
+    '''ifelse_compare_value : TICK IDENTIFIER SQUOTE
+                            | TICK TRUE       SQUOTE
+                            | TICK FALSE      SQUOTE
+                            | TICK            SQUOTE
+                            | empty
     '''
-#    x = refpolicy.IfDef(p[4])
-#    v = True
-#    collect(p[8], x, val=v)
-#    if len(p) > 12:
-#        collect(p[12], x, val=False)
-#    p[0] = [x]
-    pass
+    if len(p) == 4:
+        p[0] = p[2]
+    else:
+        p[0] = None
+
+def p_ifelse_section(p):
+    '''ifelse_section : TICK IDENTIFIER SQUOTE COMMA ifelse_compare_value COMMA TICK interface_stmts SQUOTE
+    '''
+    x = refpolicy.IfElse(p[2])
+    collect(p[8], x, val=True)
+    p[0] = [x]
+
+def p_ifelse_sections(p):
+    '''ifelse_sections : ifelse_sections COMMA ifelse_section
+                       | ifelse_section
+    '''
+    if len(p) == 4:
+        p[0] = p[1] + p[3]
+    else:
+        p[0] = p[1]
 
+def p_ifelse(p):
+    '''ifelse : IFELSE OPAREN ifelse_sections COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+    '''
+    x = refpolicy.IfElse(p[3])
+    collect(p[3], x, val=True)
+    collect(p[6], x, val=False)
+    p[0] = [x]
 
 def p_ifdef(p):
     '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements SQUOTE CPAREN optional_semi
@@ -460,6 +482,7 @@ def p_interface_call(p):
 def p_interface_call_param(p):
     '''interface_call_param : IDENTIFIER
                             | IDENTIFIER MINUS IDENTIFIER
+                            | MINUS IDENTIFIER
                             | nested_id_set
                             | TRUE
                             | FALSE
@@ -469,6 +492,8 @@ def p_interface_call_param(p):
     # List means set, non-list identifier
     if len(p) == 2:
         p[0] = p[1]
+    elif len(p) == 3:
+        p[0] = "-" + p[2]
     else:
         p[0] = [p[1], "-" + p[3]]
 
@@ -558,6 +583,8 @@ def p_requires(p):
                 | requires require
                 | ifdef
                 | requires ifdef
+                | ifelse
+                | requires ifelse
     '''
     pass
 
@@ -609,12 +636,17 @@ def p_initial_sid(p):
     p[0] = s
 
 def p_genfscon(p):
-    '''genfscon : GENFSCON IDENTIFIER PATH context'''
-    
+    '''genfscon : GENFSCON IDENTIFIER PATH context
+                | GENFSCON IDENTIFIER PATH MINUS IDENTIFIER context
+                | GENFSCON IDENTIFIER PATH MINUS MINUS context
+    '''
     g = refpolicy.GenfsCon()
     g.filesystem = p[2]
     g.path = p[3]
-    g.context = p[4]
+    if len(p) == 5:
+        g.context = p[4]
+    else:
+        g.context = p[6]
 
     p[0] = g
 
@@ -848,11 +880,19 @@ def p_bool(p):
     p[0] = b
 
 def p_gen_tunable(p):
-    '''gen_tunable : GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA TRUE CPAREN
+    '''gen_tunable : GEN_TUNABLE OPAREN IDENTIFIER COMMA TRUE CPAREN
+                   | GEN_TUNABLE OPAREN IDENTIFIER COMMA FALSE CPAREN
+                   | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA TRUE CPAREN
                    | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA FALSE CPAREN'''
     b = refpolicy.Bool()
-    b.name = p[4]
-    if p[7] == "true":
+    if len(p) == 7:
+        id_pos = 3
+        state_pos = 5
+    else:
+        id_pos = 4
+        state_pos = 7
+    b.name = p[id_pos]
+    if p[state_pos] == "true":
         b.state = True
     else:
         b.state = False
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 9cac1b95..f139dde4 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -899,6 +899,14 @@ class IfDef(Node):
     def to_string(self):
         return "[Ifdef name: %s]" % self.name
 
+class IfElse(Node):
+    def __init__(self, name="", parent=None):
+        Node.__init__(self, parent)
+        self.name = name
+
+    def to_string(self):
+        return "[Ifelse name: %s]" % self.name
+
 class InterfaceCall(Leaf):
     def __init__(self, ifname="", parent=None):
         Leaf.__init__(self, parent)
-- 
2.43.0

