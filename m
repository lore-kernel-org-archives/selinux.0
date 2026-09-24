Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004013E168F
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266958; cv=none; b=khOqUwW4E2erQnl7K/tUfAN5mePMxeQzL18H1os74ZN0vEHaeSoN/55B2FWIpZmHBtmS+fN6NfCd+kZWLOND8i/A/spjSFhbON7cz8ZQDQ1u6HDjNJcZ7NF8vvU2+TLf8xcv9VPPvrJAwZl2WO7INWXtNre+grfm/G70gBKoiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266958; c=relaxed/simple;
	bh=yeRvrxLNXu5P/5fuNsA8vOFpswkyNefZgn9R8H/EavU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnhG2i0Rp30CnVUpblSO4f7mbu3QKjjwUfvj7GFXwoj15hP1owgKbrcZEDcecWXsKTV2GQyIAGjL6MrsqDlD3e60RzNydSgaNNTRXsdYMJnZyhfhdvh6HnvgHBP6a+rcF34MhXdodjtKsAKR+y1cMgCFDyF/tvbXLyGoKASbdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsEEdewL; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsEEdewL"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c9995ca60so549443d50.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266956; x=1790871756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HBvTgUmuKWfYCix8ZfV3kufvtt3QFhFjLgVOos+ID6U=;
        b=lsEEdewLbb6u0XKkpC+djCGuPxrqnKNntC2qgWMyFbnndQ1V+XH8kvGXpc1m0qEOMm
         PbsIwshJMZt8drw9pWPn4MRLqFwFoEOWuVO/1Wy8T+fL9MOEWkjMFP//XeHoGIvdKl+E
         U/nltmUFMr7yIzZeTX8UNJ/82NQh4qXk4GMz1HFQCaOWs963YrPUiY33Hc2Ak3h8hS8g
         wCS1hIKwAvlVU3SeyPTv0Te2PZMqVGC+RknXjQqFxcjPmLEDkOwN+ODXYYAfn7qlI/uZ
         htN0gVKLtwr3w8/jm77bN8wFsXdc+vdLPVGlHTY89dtASHhG9X1qSJxOeRyHBhp1VS1G
         nndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266956; x=1790871756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBvTgUmuKWfYCix8ZfV3kufvtt3QFhFjLgVOos+ID6U=;
        b=OGUO0TxcGncFGFPHrpZ1/5gBMuPCAujplamx5wEWp6n96iwtpa5hMfjxIJ4M7JEoN6
         rS82+Nox6PCMJ8F/qTP4mgDHNbVk+GkwIVjdyP2HDcauQtSmWe1ZpBYj16W9x5u7QP1o
         Fr5PQJZuDZ3tls9nT06aJUTAo7EXulWbGIy5r+rlzqBbLXqK/0Sgsa1Ach+stVCisQ3k
         1gemzBn7xFHs/9iuvs0kQxv/gB58BwfjkmyAq9FJTC8UOKAKSZ37Hl0ecqF5HHGFse0q
         7v5ZQrNOa/V5suXWHhNphe48Nx16oqFDycmm/yyx/aTyJuDqLKi//IRru5j4XEWZPiWS
         3PFg==
X-Gm-Message-State: AFuF++mGvjuk1aDYsoEg6gJWX4cG++HSL66iSWqqBhLg5c/nVKBVYSBY
	SMCGppFEIc66keDs4TlwuUCx7ljtUXruR526SUvA79vQjLki+5f1yYJlc26pvw==
X-Gm-Gg: AYBFou1JRKhcirEUuB2faJDoIF88e1K+Pe8LHxfj5cAzj5vdyfjqmcW3pOl41kMqqr7
	eQTtI6AcDCVDSE0at6/NG0YnwKdqHR/vdd4YxID5tJpHQE7dLRuDA1kYSxfp7w/Bc3Ac2bloSmA
	vKYuPEa8Xb0dfgJSHQqaBJYo4bik26YJUsY6vHDQYncBtYNuQfUO9ya1hmfrTjZONhv3fFiKmn1
	nb6/WCgEzHZaAViNiUjjhaqh/sozqcgtqj465xlzIV0hopm2oZXKC5PopbAfSBDvRIBm7COpqZh
	KwiZoJJORbuEQ2UGCOkKYkKmrcUIkwqO2F1GN4IPEkV+hZ1gv1qzQYfFkcG5rQkBdvJNy2/39sF
	mKKvvhmhIjvMQM1OTVgaRd5BHj3PSGm53AqFnWfu0iUfbu4fGGts9O5dN61hGT8Fm0lWA8K9pUG
	M40kMwpEXG1ttIoQ3asPxhHZomKYeUkNsaWqwH5b8dAlodO5ASI0mY5SOQIJGua2ZGBEf5rA5wI
	DVjrxvpc5iMaPNZnXQaRMFCaV3n6bNTW7US+j8lsJZ5/9X/qruJpFbT/pvXEroGSTbN6As4j/s=
X-Received: by 2002:a05:690e:11c2:b0:670:fe3e:bf05 with SMTP id 956f58d0204a3-672ed302e52mr1920349d50.23.1790266955831;
        Thu, 24 Sep 2026 09:22:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e21967fsm19786586d6.13.2026.09.24.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:22:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/semanage: fall back to filename completion for fcontext paths
Date: Thu, 24 Sep 2026 12:22:20 -0400
Message-ID: <20260924162220.64876-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

semanage fcontext -a -t TYPE /some/pathprefix<TAB> does not
auto-complete currently; the fcontext arm of _semanage()
unconditionally offers the option word list for any word that isn't
the argument to -t/-f/-S/..., and the completion is registered without
-o default, so an empty match stays empty.

Register the completion with '-o default -o bashdefault' so an empty
COMPREPLY falls through to readline filename completion, and only
offer the fcontext option list when the current word is empty or
starts with '-'. The path/regex positional and the -e/--equal argument
then get ordinary filename completion.

While here, the __get_*_opts helpers echo '$ALL_OPTS $MANAGED_OPTS
...'  in single quotes, so the common option variables are never
expanded and only the per-subcommand-specific flags have ever been
offered. Switch to double quotes so -l/--list, -a/--add, -h/--help, etc
are completed under every subcommand.

Reported-by: Germano Massullo (@Germano0)
Fixes: https://github.com/SELinuxProject/selinux/issues/278
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/semanage/semanage-bash-completion.sh | 30 +++++++++++----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
index d0dd139f..cbc26f9c 100644
--- a/python/semanage/semanage-bash-completion.sh
+++ b/python/semanage/semanage-bash-completion.sh
@@ -57,18 +57,18 @@ __get_all_stores () {
 __get_all_modules () {
     semodule -l
 }
-__get_import_opts () { echo '$ALL_OPTS --f --input_file' ; }
-__get_export_opts () { echo '$ALL_OPTS --f --output_file' ; }
-__get_boolean_opts () { echo '$ALL_OPTS --on -off -1 -0' ; }
-__get_user_opts () { echo '$ALL_OPTS $MANAGED_OPTS -L --level -r --range -R --role '; }
-__get_login_opts () { echo '$ALL_OPTS $MANAGED_OPTS -s --seuser -r --range'; }
-__get_port_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -r --range -p --proto'; }
-__get_interface_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type '; }
-__get_node_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -M --mask -p --proto'; }
-__get_fcontext_opts () { echo '$ALL_OPTS $MANAGED_OPTS -t --type -e --equal -f --ftype '; }
-__get_module_opts () { echo '$ALL_OPTS $MANAGED_OPTS --enable --disable '; }
-__get_dontaudit_opts () { echo '-S on off' ; }
-__get_permissive_opts () { echo '$ALL_OPTS -a --add -d --delete' ; }
+__get_import_opts () { echo "$ALL_OPTS --f --input_file" ; }
+__get_export_opts () { echo "$ALL_OPTS --f --output_file" ; }
+__get_boolean_opts () { echo "$ALL_OPTS --on -off -1 -0" ; }
+__get_user_opts () { echo "$ALL_OPTS $MANAGED_OPTS -L --level -r --range -R --role "; }
+__get_login_opts () { echo "$ALL_OPTS $MANAGED_OPTS -s --seuser -r --range"; }
+__get_port_opts () { echo "$ALL_OPTS $MANAGED_OPTS -t --type -r --range -p --proto"; }
+__get_interface_opts () { echo "$ALL_OPTS $MANAGED_OPTS -t --type "; }
+__get_node_opts () { echo "$ALL_OPTS $MANAGED_OPTS -t --type -M --mask -p --proto"; }
+__get_fcontext_opts () { echo "$ALL_OPTS $MANAGED_OPTS -t --type -e --equal -f --ftype "; }
+__get_module_opts () { echo "$ALL_OPTS $MANAGED_OPTS --enable --disable "; }
+__get_dontaudit_opts () { echo "-S on off" ; }
+__get_permissive_opts () { echo "$ALL_OPTS -a --add -d --delete" ; }
 
 _semanage () {
         local command=${COMP_WORDS[1]}
@@ -150,7 +150,9 @@ _semanage () {
                 COMPREPLY=( $(compgen -W "$( __get_node_opts ) " -- "$cur") )
 		return 0
         elif __contains_word "$command" ${VERBS[FCONTEXT]} ; then
-                COMPREPLY=( $(compgen -W "$( __get_fcontext_opts ) " -- "$cur") )
+		if [[ -z "$cur" || "$cur" == -* ]] ; then
+			COMPREPLY=( $(compgen -W "$( __get_fcontext_opts ) " -- "$cur") )
+		fi
 		return 0
         elif __contains_word "$command" ${VERBS[BOOLEAN]} ; then
                 COMPREPLY=( $(compgen -W "$( __get_boolean_opts ) " -- "$cur") )
@@ -171,4 +173,4 @@ _semanage () {
         COMPREPLY=( $(compgen -W "$comps" -- "$cur") )
         return 0
 }
-complete -F _semanage semanage
+complete -o default -o bashdefault -F _semanage semanage
-- 
2.55.0

