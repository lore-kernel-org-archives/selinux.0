Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MFIKYJ015304
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 11:18:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id n24so3940653pfb.3
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 08:18:18 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/7] sepolicy: make search() use setools4 api
Date: Thu, 22 Sep 2016 23:17:32 +0800
Message-Id: <1474557453-14379-7-git-send-email-jason@perfinion.com>
In-Reply-To: <1474557453-14379-1-git-send-email-jason@perfinion.com>
References: <1474557453-14379-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/sepolicy/sepolicy/__init__.py | 122 ++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 15 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index a3ab10c..b00ec81 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -249,23 +249,115 @@ def info(setype, name=None):
         raise ValueError("Invalid type")
 
 
-def search(types, info={}):
-    seinfo = info
-    valid_types = [ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW]
+def _setools_rule_to_dict(rule):
+    d = {
+        'type': str(rule.ruletype),
+        'source': str(rule.source),
+        'target': str(rule.target),
+        'class': str(rule.tclass),
+    }
+
+    try:
+        enabled = bool(rule.qpol_symbol.is_enabled(rule.policy))
+    except AttributeError:
+        enabled = True
+
+    if isinstance(rule, setools.policyrep.terule.AVRule):
+        d['enabled'] = enabled
+
+    try:
+        d['permlist'] = list(map(str, rule.perms))
+    except setools.policyrep.exception.RuleUseError:
+        pass
+
+    try:
+        d['transtype'] = str(rule.default)
+    except setools.policyrep.exception.RuleUseError:
+        pass
+
+    try:
+        d['boolean'] = [(str(rule.conditional), enabled)]
+    except (AttributeError, setools.policyrep.exception.RuleNotConditional):
+        pass
+
+    try:
+        d['filename'] = rule.filename
+    except (AttributeError,
+            setools.policyrep.exception.RuleNotConditional,
+            setools.policyrep.exception.TERuleNoFilename):
+        pass
+
+    return d
+
+
+def search(types, seinfo=None):
+    if not seinfo:
+        seinfo = {}
+    valid_types = set([ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW])
     for setype in types:
         if setype not in valid_types:
-            raise ValueError("Type has to be in %s" % valid_types)
-        seinfo[setype] = True
-
-    perms = []
-    if PERMS in seinfo:
-        perms = info[PERMS]
-        seinfo[PERMS] = ",".join(seinfo[PERMS])
-
-    dict_list = _policy.search(seinfo)
-    if dict_list and len(perms) != 0:
-        dict_list = filter(lambda x: _dict_has_perms(x, perms), dict_list)
-    return dict_list
+            raise ValueError("Type has to be in %s" % " ".join(valid_types))
+
+    source = None
+    if SOURCE in seinfo:
+        source = str(seinfo[SOURCE])
+
+    target = None
+    if TARGET in seinfo:
+        target = str(seinfo[TARGET])
+
+    tclass = None
+    if CLASS in seinfo:
+        tclass = str(seinfo[CLASS]).split(',')
+
+    toret = []
+
+    tertypes = []
+    if ALLOW in types:
+        tertypes.append(ALLOW)
+    if NEVERALLOW in types:
+        tertypes.append(NEVERALLOW)
+    if AUDITALLOW in types:
+        tertypes.append(AUDITALLOW)
+
+    if len(tertypes) > 0:
+        q = setools.TERuleQuery(_pol,
+                                ruletype=tertypes,
+                                source=source,
+                                target=target,
+                                tclass=tclass)
+
+        if PERMS in seinfo:
+            q.perms = seinfo[PERMS]
+
+        toret += [_setools_rule_to_dict(x) for x in q.results()]
+
+    if TRANSITION in types:
+        rtypes = ['type_transition', 'type_change', 'type_member']
+        q = setools.TERuleQuery(_pol,
+                                ruletype=rtypes,
+                                source=source,
+                                target=target,
+                                tclass=tclass)
+
+        if PERMS in seinfo:
+            q.perms = seinfo[PERMS]
+
+        toret += [_setools_rule_to_dict(x) for x in q.results()]
+
+    if ROLE_ALLOW in types:
+        ratypes = ['allow']
+        q = setools.RBACRuleQuery(_pol,
+                                  ruletype=ratypes,
+                                  source=source,
+                                  target=target,
+                                  tclass=tclass)
+
+        for r in q.results():
+            toret.append({'source': str(r.source),
+                          'target': str(r.target)})
+
+    return toret
 
 
 def get_conditionals(src, dest, tclass, perm):
-- 
2.7.3
