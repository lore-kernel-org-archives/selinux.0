Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8O95vir000602
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 05:05:58 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
 [10.5.11.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD7F0308421A
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 09:05:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-142.brq.redhat.com
 [10.40.204.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 325A3308BDBA
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 09:05:51 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 24 Sep 2018 11:05:49 +0200
Message-Id: <20180924090549.17810-1-vmojzis@redhat.com>
In-Reply-To: <CAJfZ7==sczRmbFRVnLhQyNsQ=nQXEJwWUELZgpJANqxr-3J+eA@mail.gmail.com>
References: <CAJfZ7==sczRmbFRVnLhQyNsQ=nQXEJwWUELZgpJANqxr-3J+eA@mail.gmail.com>
Subject: [PATCH] python/sepolicy: Update to work with setools-4.2.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change in internal setools API causes sepolicy to crash when processing
AVRules.

    File "python/sepolicy/sepolicy/__init__.py", line 277, in _setools_rule_to_dict
        if isinstance(rule, setools.policyrep.terule.AVRule):
    AttributeError: module 'setools.policyrep' has no attribute 'terule'

See https://github.com/SELinuxProject/setools/issues/8 for more details.

Stop using internal setools API:

- use AttributeError instead of setools specific exceptions
- evaluate conditional expressions using conditional.evaluate() instead
of qpol_symbol.is_enabled()

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---



Thank you for the testing.
Your commit message is way more descriptive, so feel free to include it
(or just use v2 of your patch instead of this).



 python/sepolicy/sepolicy/__init__.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 2e772867..489c6c6f 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -278,34 +278,39 @@ def _setools_rule_to_dict(rule):
         'class': str(rule.tclass),
     }
 
+    # Evaluate boolean expression associated with given rule (if there is any)
     try:
-        enabled = bool(rule.qpol_symbol.is_enabled(rule.policy))
+        # Get state of all booleans in the conditional expression
+        boolstate = {}
+        for boolean in rule.conditional.booleans:
+            boolstate[str(boolean)] = boolean.state
+        #evaluate if the rule is enabled
+        enabled = rule.conditional.evaluate(**boolstate) == rule.conditional_block
+
     except AttributeError:
+        # non-conditional rules are always enabled
         enabled = True
 
-    if isinstance(rule, setools.policyrep.terule.AVRule):
-        d['enabled'] = enabled
+    d['enabled'] = enabled
 
     try:
         d['permlist'] = list(map(str, rule.perms))
-    except setools.policyrep.exception.RuleUseError:
+    except AttributeError:
         pass
 
     try:
         d['transtype'] = str(rule.default)
-    except setools.policyrep.exception.RuleUseError:
+    except AttributeError:
         pass
 
     try:
         d['boolean'] = [(str(rule.conditional), enabled)]
-    except (AttributeError, setools.policyrep.exception.RuleNotConditional):
+    except AttributeError:
         pass
 
     try:
         d['filename'] = rule.filename
-    except (AttributeError,
-            setools.policyrep.exception.RuleNotConditional,
-            setools.policyrep.exception.TERuleNoFilename):
+    except AttributeError:
         pass
 
     return d
-- 
2.17.1
