Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6B45DF6B
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616234; cv=none; b=CgqvnGEoUNCNlfAMEjlVw2F5Gs/FQ66jTa7TJKsRNeHKCprCGROyQA2P+j6TQDSFjJWKFf6oqnDPFTwrwXFRJkWe2LT44AsMiN+ORc+eE71rbrMJMMWZUfQ+FKR+R3me+5EqatG02a1bSFYzpzx8KNLRJwC/8ENMabZVOGRbjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616234; c=relaxed/simple;
	bh=0gcEd+4ro0Zw2XlghNymp925Yh8spr3uoQH4v6+Ff/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A66jdgR6UYE/i11QJ1aj+la5ovaWCLsbnJ0nvDxROocZC26TdG+Aw9Rr3Kk/bPxh1u3Qj8ydoRdxb/Es8n9Zm1TO/l1SfiuWzlzS1hClLFXD6O3SU/vsuZAg7wCO5PMFbtJtPqXW7yz+KHc78AqkoJm648sndxT33fYDenm9FZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzLGkl/q; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzLGkl/q"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-53331a61f71so21193941cf.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616226; x=1791221026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/tsJEDpQZZ4C+/j/KQN4/c2l287tmeNheUFMjANBuD8=;
        b=OzLGkl/qdk7wBYTASDKf1cDqCgPB/3oBO506UKfO38PUXTuSLvY9E4HSjM5aMD3vbz
         0vWpunQrmRDwuxM7qFT8XhUsP/sCnCtB0zkUishd445cVClqcUM1bP1pf9crbyT6cEJ8
         HMhA/ppzYqw0HtsGVHmqpgPwRvg6++FxrYmZlspmyLpN8AL9kPIDvOT+AoOzkAb7Hfe+
         ziorVEQ3ghXIyw9u5L91GrNVxhispNIf1vPJzyNXZYN6yY+ml0g70F64ek9NzxyRW/jv
         ++wE3634Koe0zBi6TUcXDYAQgVDoWIHqMkncE7jTHkpICAiZu9NOqnG9Rzh7AKFmUm9Z
         Xt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616226; x=1791221026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/tsJEDpQZZ4C+/j/KQN4/c2l287tmeNheUFMjANBuD8=;
        b=jxwA7u3aeFp0sF7COFPfU7NcDO514gajYtfyGb1wzeRRKl3iwIrnzeXcuektik413z
         hkL04B9FdSeumjt0pIT+0xRsokAVXIKZNoWaS5oR9TtIQ/pMry1x3o8NE85y01+bRp39
         Lkla6vK3+MXqAb550HGlRxyoc8YK86TsMmoMZaVwx8dPjxqGiYZSeCHkJkM+OuG4xUPJ
         3+jZWwA7yxjeqoEwxHNGA+SAQBnxYkGjxVyQGVkWmb3DBccPxB3OCkr7b0KXeSVgf9cD
         5ZqvMsrjQpOHvbGugQooBBf39h6VU8tFC2Y5DqEv9mSkiBLWMc8+E9uJ6Xv/UVkaOPCF
         VTNA==
X-Gm-Message-State: AFuF++mdjG3R+XuJrxnuwdvhMgpOAdpLpDSWwzDL/CXXSnSLWldhxWvI
	ytCunf3BBQkY7loY85Zj0krfpXdLhPTcTbxGjmxnky1pqL8ktrkPV1jyGAJXDg==
X-Gm-Gg: AYBFou0F930ao26iFsLoDLhC5TmKWwxPp+TW4LRInjNUSPmGHe3JWOt+M0K45dF6lIU
	GA/LxpMXAn8duZyrXHXmcEiqXQhDwie5fGURdMt2VwmDosz5HWBJIzz/BHvDL+Kg9zt738SourJ
	dpqH47AFTL6oRqIDIz7hUsxJe3tPnWeOsGtoa890zi5JmNDQxEOVf9NxmZfE5cJh/JbkkShT+ed
	Wk3d40yvdI/7RUtrQ5+hg7klq3jDMj63GvHbakWWr4bi7WYI27hNVtt7IfraTHNXc14jvIYEsRv
	x6TRKv4BYnTytKMY3x6qJXQcrcDiPjdcvY5zH3LHyq2dOw57S2VU8ilApgZeum3pZ1xDvYFD3rr
	CtApS68QCxERDT6j9egJeorjWLFQyQDJd1eZkhxhyNkcdywjLjjMOadhtxuC+l3GUfJL2ZYxOFo
	STQnrbImn/XKLCoxWMXrvqc/zbY9LlRn+IBTmkKp/71ZZgdAO1+CgtWjdVurl8RYfmVK7HyQbjC
	2LM6HubWMkDNntjycK70583QcVBLgTvrqHT6NokOD+WDv/J8x/JqU6yiOT+HBSVAN43rFesu8s=
X-Received: by 2002:a05:6214:d6c:b0:917:7c94:dcb3 with SMTP id 6a1803df08f44-9177c94dfc9mr30711916d6.45.1790616226179;
        Mon, 28 Sep 2026 10:23:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dd2858sm85061876d6.21.2026.09.28.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:23:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox: shell-quote the command written to .sandboxrc
Date: Mon, 28 Sep 2026 13:23:30 -0400
Message-ID: <20260928172330.77970-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sandbox -X writes the argv into ~/.sandboxrc as

    cmd 'arg1' 'arg2' ...

with argv[0] unquoted and argv[1:] wrapped in bare single quotes with
no escaping. An argument containing a single quote terminates the
quoting and the remainder is parsed as shell, and any space or shell
metacharacter in argv[0] is interpreted rather than passed through.
The same string is also written after "#TITLE:" and read back by
sandboxX.sh for the Xephyr window title, so a newline in an argument
turns the tail into a second uncommented script line.

This runs after setexeccon() inside the sandbox domain with the
invoker's own argv, so no boundary is crossed; it just means 'sandbox
-X -- prog "two words"' and similar have never worked.

Build the command with shlex.join() so every element is quoted, and
derive the #TITLE: line separately with control characters stripped
and truncated to what sandboxX.sh's `cut -b8-80` will keep.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index d909fc44..6a18b660 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -27,6 +27,7 @@ import socket
 import random
 import fcntl
 import shutil
+import shlex
 import re
 import subprocess
 import selinux
@@ -274,9 +275,10 @@ class Sandbox:
 /etc/gdm/Xsession
 """)
         else:
-            command = self.__paths[0] + " "
-            for p in self.__paths[1:]:
-                command += "'%s' " % p
+            command = shlex.join(self.__paths)
+            # #TITLE: is read back by sandboxX.sh with grep|cut for the
+            # window title; keep it on one line and printable.
+            title = re.sub(r"[^ -~]", " ", " ".join(self.__paths))[:72]
             fd.write("""#! /bin/sh
 #TITLE: %s
 # /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
@@ -285,7 +287,7 @@ if which dbus-run-session >/dev/null 2>&1; then
 else
     dbus-launch --exit-with-session %s
 fi
-""" % (command, command, command))
+""" % (title, command, command))
         fd.close()
         os.chmod(execfile, 0o700)
 
-- 
2.55.0

