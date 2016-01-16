Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0GBXbk3022695
 for <selinux@tycho.nsa.gov>; Sat, 16 Jan 2016 06:33:38 -0500
Received: from iosakhe.numericable.fr (89-156-121-7.rev.numericable.fr
 [89.156.121.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9A19856480E
 for <selinux@tycho.nsa.gov>; Sat, 16 Jan 2016 12:33:34 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sepolgen: Support latest refpolicy interfaces
Date: Sat, 16 Jan 2016 12:33:09 +0100
Message-Id: <1452943989-11913-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1452943989-11913-1-git-send-email-nicolas.iooss@m4x.org>
References: <1452943989-11913-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some refpolicy interfaces use:

* "$" character in paths, for example in kernel/selinux.if:

    genfscon selinuxfs /booleans/$2 gen_context(system_u:object_r:$1,s0)

* empty members in ifelse statement, for example in system/init.if:

    ifelse(`$5',`',`',`
        ...
    ')

Modify sepolgen/refparser grammar accordingly.

This fixes the following syntax errors reported by sepolgen-ifgen:

    /usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error
    on line 43 gen_context [type=GEN_CONTEXT]
    /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
    line 1416 ' [type=SQUOTE]
    /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
    line 1422 ' [type=SQUOTE]

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 sepolgen/src/sepolgen/refparser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index 3132c6fe7109..9b1d0c8f458d 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -219,7 +219,7 @@ t_BAR       = r'\|'
 t_EXPL      = r'\!'
 t_EQUAL     = r'\='
 t_NUMBER    = r'[0-9\.]+'
-t_PATH      = r'/[a-zA-Z0-9)_\.\*/]*'
+t_PATH      = r'/[a-zA-Z0-9)_\.\*/\$]*'
 #t_IPV6_ADDR = r'[a-fA-F0-9]{0,4}:[a-fA-F0-9]{0,4}:([a-fA-F0-9]{0,4}:)*'
 
 # Ignore whitespace - this is a special token for ply that more efficiently
@@ -417,6 +417,7 @@ def p_tunable_policy(p):
 def p_ifelse(p):
     '''ifelse : IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
               | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
     '''
 #    x = refpolicy.IfDef(p[4])
 #    v = True
-- 
2.7.0
