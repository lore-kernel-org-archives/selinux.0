Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8JKpkng025016
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 16:51:46 -0400
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2018 22:51:14 +0200
Message-Id: <20180919205114.2683-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Subject: [PATCH 1/1] python/sepolicy: fix compatibility with setools
 4.2.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When testing sepolicy gui with setools 4.2.0-beta, the following error
happened:

      File "python/sepolicy/sepolicy/__init__.py", line 277, in _setools_=
rule_to_dict
        if isinstance(rule, setools.policyrep.terule.AVRule):
    AttributeError: module 'setools.policyrep' has no attribute 'terule'

This is due to a reorganization of files in setools 4.2. After reporting
the issue on https://github.com/SELinuxProject/setools/issues/8 , it
appears that sepolicy has not been using setools API properly. Fix this
by:
* replacing exception types internal to setools with AttributeError, as
  they all inherit from it ;
* using rule.conditional.evaluate(...) in order to find out whether a
  conditional rule is enabled, instead of relying on
  rule.qpol_symbol.is_enabled() (which disappeared).

This last point required knowing the states of the booleans in the
policy. As sepolicy already retrieves all boolean states in
get_all_bools(), put them in a dict which can be used by
rule.conditional.evaluate().

This code has been tested with setools 4.1.1 and setools 4.2.0-beta.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 30 +++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepol=
icy/__init__.py
index 89346aba0b15..ed6dfea9718a 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -112,6 +112,7 @@ login_mappings =3D None
 file_types =3D None
 port_types =3D None
 bools =3D None
+bools_dict =3D None
 all_attributes =3D None
 booleans =3D None
 booleans_dict =3D None
@@ -134,6 +135,7 @@ def policy(policy_file):
     global all_domains
     global all_attributes
     global bools
+    global bools_dict
     global all_types
     global role_allows
     global users
@@ -143,6 +145,7 @@ def policy(policy_file):
     all_domains =3D None
     all_attributes =3D None
     bools =3D None
+    bools_dict =3D None
     all_types =3D None
     role_allows =3D None
     users =3D None
@@ -272,34 +275,35 @@ def _setools_rule_to_dict(rule):
         'class': str(rule.tclass),
     }
=20
+    # Evaluate the boolean condition if it is a conditional rule.
+    # In order to do this, extract the booleans which are used in the co=
ndition first.
     try:
-        enabled =3D bool(rule.qpol_symbol.is_enabled(rule.policy))
+        all_bools =3D get_all_bools_as_dict()
+        used_bools =3D dict((str(name), all_bools[name]) for name in rul=
e.conditional.booleans)
+        enabled =3D rule.conditional.evaluate(**used_bools) =3D=3D rule.=
conditional_block
     except AttributeError:
         enabled =3D True
=20
-    if isinstance(rule, setools.policyrep.terule.AVRule):
-        d['enabled'] =3D enabled
+    d['enabled'] =3D enabled
=20
     try:
         d['permlist'] =3D list(map(str, rule.perms))
-    except setools.policyrep.exception.RuleUseError:
+    except AttributeError:
         pass
=20
     try:
         d['transtype'] =3D str(rule.default)
-    except setools.policyrep.exception.RuleUseError:
+    except AttributeError:
         pass
=20
     try:
         d['boolean'] =3D [(str(rule.conditional), enabled)]
-    except (AttributeError, setools.policyrep.exception.RuleNotCondition=
al):
+    except AttributeError:
         pass
=20
     try:
         d['filename'] =3D rule.filename
-    except (AttributeError,
-            setools.policyrep.exception.RuleNotConditional,
-            setools.policyrep.exception.TERuleNoFilename):
+    except AttributeError:
         pass
=20
     return d
@@ -930,6 +934,14 @@ def get_all_bools():
     return bools
=20
=20
+def get_all_bools_as_dict():
+    """Return a name->state dict of the booleans defined in the policy""=
"
+    global bools_dict
+    if not bools_dict:
+        bools_dict =3D dict((b['name'], b['state']) for b in get_all_boo=
ls())
+    return bools_dict
+
+
 def prettyprint(f, trim):
     return " ".join(f[:-len(trim)].split("_"))
=20
--=20
2.19.0
