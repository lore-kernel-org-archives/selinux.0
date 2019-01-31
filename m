Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F0C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F1B218AC
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfAaVIQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:08:16 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34498 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAaVIQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:08:16 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 496915646AB
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:08:12 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] python: reindent lines that were over-indented
Date:   Thu, 31 Jan 2019 22:07:51 +0100
Message-Id: <20190131210753.11221-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131210753.11221-1-nicolas.iooss@m4x.org>
References: <20190131210753.11221-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:08:12 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Flake8 3.7.0 warns about lines that are over-indented, i.e. lines that
are indented with more than 4 spaces:

    python/sepolgen/src/sepolgen/refparser.py:1047:26: E117 over-indented
    python/sepolgen/src/sepolgen/yacc.py:2569:21: E117 over-indented
    python/sepolicy/sepolicy/interface.py:196:13: E117 over-indented
    python/sepolicy/sepolicy/interface.py:198:13: E117 over-indented
    python/sepolicy/sepolicy/interface.py:215:13: E117 over-indented
    python/sepolicy/sepolicy/interface.py:217:13: E117 over-indented
    python/sepolicy/sepolicy/manpage.py:172:13: E117 over-indented
    python/sepolicy/sepolicy/manpage.py:174:13: E117 over-indented

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/refparser.py |   2 +-
 python/sepolgen/src/sepolgen/yacc.py      | 214 +++++++++++-----------
 python/sepolicy/sepolicy/interface.py     |   8 +-
 python/sepolicy/sepolicy/manpage.py       |   4 +-
 4 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 9fb931828278..f506dc3ae189 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -1044,7 +1044,7 @@ def list_headers(root):
                 if name == "obj_perm_sets.spt":
                     support_macros = filename
                 elif len(re.findall("patterns", modname[0])):
-                         modules.append((modname[0], filename))
+                    modules.append((modname[0], filename))
             elif modname[1] == '.if':
                 modules.append((modname[0], filename))
 
diff --git a/python/sepolgen/src/sepolgen/yacc.py b/python/sepolgen/src/sepolgen/yacc.py
index 88188a1e8ead..55c1ef7d8b30 100644
--- a/python/sepolgen/src/sepolgen/yacc.py
+++ b/python/sepolgen/src/sepolgen/yacc.py
@@ -2566,118 +2566,118 @@ class LRGeneratedTable(LRTable):
             log.info('')
 
             for p in I:
-                    if p.len == p.lr_index + 1:
-                        if p.name == "S'":
-                            # Start symbol. Accept!
-                            st_action['$end'] = 0
-                            st_actionp['$end'] = p
+                if p.len == p.lr_index + 1:
+                    if p.name == "S'":
+                        # Start symbol. Accept!
+                        st_action['$end'] = 0
+                        st_actionp['$end'] = p
+                    else:
+                        # We are at the end of a production.  Reduce!
+                        if self.lr_method == 'LALR':
+                            laheads = p.lookaheads[st]
                         else:
-                            # We are at the end of a production.  Reduce!
-                            if self.lr_method == 'LALR':
-                                laheads = p.lookaheads[st]
-                            else:
-                                laheads = self.grammar.Follow[p.name]
-                            for a in laheads:
-                                actlist.append((a, p, 'reduce using rule %d (%s)' % (p.number, p)))
-                                r = st_action.get(a)
-                                if r is not None:
-                                    # Whoa. Have a shift/reduce or reduce/reduce conflict
-                                    if r > 0:
-                                        # Need to decide on shift or reduce here
-                                        # By default we favor shifting. Need to add
-                                        # some precedence rules here.
-
-                                        # Shift precedence comes from the token
-                                        sprec, slevel = Precedence.get(a, ('right', 0))
-
-                                        # Reduce precedence comes from rule being reduced (p)
-                                        rprec, rlevel = Productions[p.number].prec
-
-                                        if (slevel < rlevel) or ((slevel == rlevel) and (rprec == 'left')):
-                                            # We really need to reduce here.
-                                            st_action[a] = -p.number
-                                            st_actionp[a] = p
-                                            if not slevel and not rlevel:
-                                                log.info('  ! shift/reduce conflict for %s resolved as reduce', a)
-                                                self.sr_conflicts.append((st, a, 'reduce'))
-                                            Productions[p.number].reduced += 1
-                                        elif (slevel == rlevel) and (rprec == 'nonassoc'):
-                                            st_action[a] = None
-                                        else:
-                                            # Hmmm. Guess we'll keep the shift
-                                            if not rlevel:
-                                                log.info('  ! shift/reduce conflict for %s resolved as shift', a)
-                                                self.sr_conflicts.append((st, a, 'shift'))
-                                    elif r < 0:
-                                        # Reduce/reduce conflict.   In this case, we favor the rule
-                                        # that was defined first in the grammar file
-                                        oldp = Productions[-r]
-                                        pp = Productions[p.number]
-                                        if oldp.line > pp.line:
-                                            st_action[a] = -p.number
-                                            st_actionp[a] = p
-                                            chosenp, rejectp = pp, oldp
-                                            Productions[p.number].reduced += 1
-                                            Productions[oldp.number].reduced -= 1
-                                        else:
-                                            chosenp, rejectp = oldp, pp
-                                        self.rr_conflicts.append((st, chosenp, rejectp))
-                                        log.info('  ! reduce/reduce conflict for %s resolved using rule %d (%s)',
-                                                 a, st_actionp[a].number, st_actionp[a])
+                            laheads = self.grammar.Follow[p.name]
+                        for a in laheads:
+                            actlist.append((a, p, 'reduce using rule %d (%s)' % (p.number, p)))
+                            r = st_action.get(a)
+                            if r is not None:
+                                # Whoa. Have a shift/reduce or reduce/reduce conflict
+                                if r > 0:
+                                    # Need to decide on shift or reduce here
+                                    # By default we favor shifting. Need to add
+                                    # some precedence rules here.
+
+                                    # Shift precedence comes from the token
+                                    sprec, slevel = Precedence.get(a, ('right', 0))
+
+                                    # Reduce precedence comes from rule being reduced (p)
+                                    rprec, rlevel = Productions[p.number].prec
+
+                                    if (slevel < rlevel) or ((slevel == rlevel) and (rprec == 'left')):
+                                        # We really need to reduce here.
+                                        st_action[a] = -p.number
+                                        st_actionp[a] = p
+                                        if not slevel and not rlevel:
+                                            log.info('  ! shift/reduce conflict for %s resolved as reduce', a)
+                                            self.sr_conflicts.append((st, a, 'reduce'))
+                                        Productions[p.number].reduced += 1
+                                    elif (slevel == rlevel) and (rprec == 'nonassoc'):
+                                        st_action[a] = None
+                                    else:
+                                        # Hmmm. Guess we'll keep the shift
+                                        if not rlevel:
+                                            log.info('  ! shift/reduce conflict for %s resolved as shift', a)
+                                            self.sr_conflicts.append((st, a, 'shift'))
+                                elif r < 0:
+                                    # Reduce/reduce conflict.   In this case, we favor the rule
+                                    # that was defined first in the grammar file
+                                    oldp = Productions[-r]
+                                    pp = Productions[p.number]
+                                    if oldp.line > pp.line:
+                                        st_action[a] = -p.number
+                                        st_actionp[a] = p
+                                        chosenp, rejectp = pp, oldp
+                                        Productions[p.number].reduced += 1
+                                        Productions[oldp.number].reduced -= 1
                                     else:
-                                        raise LALRError('Unknown conflict in state %d' % st)
+                                        chosenp, rejectp = oldp, pp
+                                    self.rr_conflicts.append((st, chosenp, rejectp))
+                                    log.info('  ! reduce/reduce conflict for %s resolved using rule %d (%s)',
+                                             a, st_actionp[a].number, st_actionp[a])
                                 else:
-                                    st_action[a] = -p.number
-                                    st_actionp[a] = p
-                                    Productions[p.number].reduced += 1
-                    else:
-                        i = p.lr_index
-                        a = p.prod[i+1]       # Get symbol right after the "."
-                        if a in self.grammar.Terminals:
-                            g = self.lr0_goto(I, a)
-                            j = self.lr0_cidhash.get(id(g), -1)
-                            if j >= 0:
-                                # We are in a shift state
-                                actlist.append((a, p, 'shift and go to state %d' % j))
-                                r = st_action.get(a)
-                                if r is not None:
-                                    # Whoa have a shift/reduce or shift/shift conflict
-                                    if r > 0:
-                                        if r != j:
-                                            raise LALRError('Shift/shift conflict in state %d' % st)
-                                    elif r < 0:
-                                        # Do a precedence check.
-                                        #   -  if precedence of reduce rule is higher, we reduce.
-                                        #   -  if precedence of reduce is same and left assoc, we reduce.
-                                        #   -  otherwise we shift
-
-                                        # Shift precedence comes from the token
-                                        sprec, slevel = Precedence.get(a, ('right', 0))
-
-                                        # Reduce precedence comes from the rule that could have been reduced
-                                        rprec, rlevel = Productions[st_actionp[a].number].prec
-
-                                        if (slevel > rlevel) or ((slevel == rlevel) and (rprec == 'right')):
-                                            # We decide to shift here... highest precedence to shift
-                                            Productions[st_actionp[a].number].reduced -= 1
-                                            st_action[a] = j
-                                            st_actionp[a] = p
-                                            if not rlevel:
-                                                log.info('  ! shift/reduce conflict for %s resolved as shift', a)
-                                                self.sr_conflicts.append((st, a, 'shift'))
-                                        elif (slevel == rlevel) and (rprec == 'nonassoc'):
-                                            st_action[a] = None
-                                        else:
-                                            # Hmmm. Guess we'll keep the reduce
-                                            if not slevel and not rlevel:
-                                                log.info('  ! shift/reduce conflict for %s resolved as reduce', a)
-                                                self.sr_conflicts.append((st, a, 'reduce'))
-
+                                    raise LALRError('Unknown conflict in state %d' % st)
+                            else:
+                                st_action[a] = -p.number
+                                st_actionp[a] = p
+                                Productions[p.number].reduced += 1
+                else:
+                    i = p.lr_index
+                    a = p.prod[i+1]       # Get symbol right after the "."
+                    if a in self.grammar.Terminals:
+                        g = self.lr0_goto(I, a)
+                        j = self.lr0_cidhash.get(id(g), -1)
+                        if j >= 0:
+                            # We are in a shift state
+                            actlist.append((a, p, 'shift and go to state %d' % j))
+                            r = st_action.get(a)
+                            if r is not None:
+                                # Whoa have a shift/reduce or shift/shift conflict
+                                if r > 0:
+                                    if r != j:
+                                        raise LALRError('Shift/shift conflict in state %d' % st)
+                                elif r < 0:
+                                    # Do a precedence check.
+                                    #   -  if precedence of reduce rule is higher, we reduce.
+                                    #   -  if precedence of reduce is same and left assoc, we reduce.
+                                    #   -  otherwise we shift
+
+                                    # Shift precedence comes from the token
+                                    sprec, slevel = Precedence.get(a, ('right', 0))
+
+                                    # Reduce precedence comes from the rule that could have been reduced
+                                    rprec, rlevel = Productions[st_actionp[a].number].prec
+
+                                    if (slevel > rlevel) or ((slevel == rlevel) and (rprec == 'right')):
+                                        # We decide to shift here... highest precedence to shift
+                                        Productions[st_actionp[a].number].reduced -= 1
+                                        st_action[a] = j
+                                        st_actionp[a] = p
+                                        if not rlevel:
+                                            log.info('  ! shift/reduce conflict for %s resolved as shift', a)
+                                            self.sr_conflicts.append((st, a, 'shift'))
+                                    elif (slevel == rlevel) and (rprec == 'nonassoc'):
+                                        st_action[a] = None
                                     else:
-                                        raise LALRError('Unknown conflict in state %d' % st)
+                                        # Hmmm. Guess we'll keep the reduce
+                                        if not slevel and not rlevel:
+                                            log.info('  ! shift/reduce conflict for %s resolved as reduce', a)
+                                            self.sr_conflicts.append((st, a, 'reduce'))
+
                                 else:
-                                    st_action[a] = j
-                                    st_actionp[a] = p
+                                    raise LALRError('Unknown conflict in state %d' % st)
+                            else:
+                                st_action[a] = j
+                                st_actionp[a] = p
 
             # Print the actions associated with each terminal
             _actprint = {}
diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 18374dcfed96..27c37bb8e1f8 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -193,9 +193,9 @@ def get_xml_file(if_file):
     """ Returns xml format of interfaces for given .if policy file"""
     import os
     try:
-            from commands import getstatusoutput
+        from commands import getstatusoutput
     except ImportError:
-            from subprocess import getstatusoutput
+        from subprocess import getstatusoutput
     basedir = os.path.dirname(if_file) + "/"
     filename = os.path.basename(if_file).split(".")[0]
     rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
@@ -212,9 +212,9 @@ def interface_compile_test(interface, path="/usr/share/selinux/devel/policy.xml"
     exclude_interface_type = ["template"]
 
     try:
-            from commands import getstatusoutput
+        from commands import getstatusoutput
     except ImportError:
-            from subprocess import getstatusoutput
+        from subprocess import getstatusoutput
     import os
     policy_files = {'pp': "compiletest.pp", 'te': "compiletest.te", 'fc': "compiletest.fc", 'if': "compiletest.if"}
     idict = get_interface_dict(path)
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index cfcb7c3932d7..af18b6ffc12f 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -169,9 +169,9 @@ def get_alphabet_manpages(manpage_list):
 
 def convert_manpage_to_html(html_manpage, manpage):
     try:
-            from commands import getstatusoutput
+        from commands import getstatusoutput
     except ImportError:
-            from subprocess import getstatusoutput
+        from subprocess import getstatusoutput
     rc, output = getstatusoutput("/usr/bin/groff -man -Thtml %s 2>/dev/null" % manpage)
     if rc == 0:
         print(html_manpage, "has been created")
-- 
2.20.1

