Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17712FB29
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684235; cv=none; b=fgB8dn+nAb6BcT2LBidJ+pdiTrcI1OEdP+ah5SPeSxtj5v+/ikPS7NKnwe8BrYXx8MdXP4UCuZaBJaP+L5Sk9rjgBVfjyybE1W3ysHk9zktL5tsXZxOvdb01LVKQautCh1db2bTtfpPbk/N/DBL7U+0zf2NiQ9W6dBQM5rQFL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684235; c=relaxed/simple;
	bh=OVpiDMfeyMrlakZA6VVjk+/XgyTeWmpLJSoSCmHsDu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=WdbHkQvcpIKVC96rH/PfOsvUbjPbEeJXfljYcn9sriWLrlaQJNAq8IYJLxM20pX+/VoDmh1/KrOQB/Y0dh7Z+lpWmIY7Yiy5waNcg+sJT/Sljwajo+4iV31jXz7IxWWj3BSsmk493kCbEvFELy/eCVAFUmZzaxNB8RJWIotRXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2GoCVno; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2GoCVno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715684232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UC+DMerd/iiwRYb8sKbGuXSAAWFrYrK4qHrFiMnqFho=;
	b=D2GoCVnoqmDYIPzZwyCLefOGjvhqndoJB6/yFjxmv0XDI44Ns9fMGr7HuXN8HlX+5dWGMR
	jtQC7qlh44/iEWfGI8OIwtFKxaAO4+5rYGRHErZrGgo8ay1Y7ARJoWbhyL2xRYJ35WeMTp
	vHOz1koQE3ur1lRMcgyY79bQuioqL3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558--DwCm6FVPsqtVcJb2F1h9g-1; Tue, 14 May 2024 06:57:06 -0400
X-MC-Unique: -DwCm6FVPsqtVcJb2F1h9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1B0E8029EC
	for <selinux@vger.kernel.org>; Tue, 14 May 2024 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6BF40C6CB6;
	Tue, 14 May 2024 10:57:04 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 4/4] sandbox: Add support for Wayland
Date: Tue, 14 May 2024 12:56:51 +0200
Message-ID: <20240514105651.225925-4-lautrbach@redhat.com>
In-Reply-To: <20240514105651.225925-1-lautrbach@redhat.com>
References: <20240514105651.225925-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

- use XWayland for X application if it's run in Wayland session
- run Wayland apps directly if it's run in Wayland session
- add sandbox -Y option to run run Wayland application

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 sandbox/sandbox     | 26 ++++++++++++++++++++++++--
 sandbox/sandboxX.sh | 36 ++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 1e96f93e4a92..e3fd6119ed4d 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -344,6 +344,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                           action="callback", callback=self.__x_callback,
                           default=False, help=_("run X application within a sandbox"))
 
+        parser.add_option("-Y", dest="Y_ind",
+                          action="callback", callback=self.__x_callback,
+                          default=False, help=_("run Wayland application within a sandbox"))
+
         parser.add_option("-H", "--homedir",
                           action="callback", callback=self.__validdir,
                           type="string",
@@ -457,6 +461,16 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
         selinux.chcon(self.__runuserdir, self.__filecon, recursive=True)
         selinux.setfscreatecon(None)
 
+    def __is_wayland_app(self):
+        binary = shutil.which(self.__paths[0])
+        if binary is None:
+            return True
+        output = subprocess.run(['ldd', binary], capture_output=True)
+        for line in str(output.stdout, "utf-8").split('\n'):
+            if line.find("libwayland") != -1:
+                return True
+        return False
+
     def __execute(self):
         try:
             cmds = [SEUNSHARE, "-Z", self.__execcon]
@@ -465,7 +479,7 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
             if self.__mount:
                 cmds += ["-t", self.__tmpdir, "-h", self.__homedir, "-r", self.__runuserdir]
 
-                if self.__options.X_ind:
+                if self.__options.X_ind or self.__options.Y_ind:
                     if self.__options.dpi:
                         dpi = self.__options.dpi
                     else:
@@ -474,6 +488,9 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                         from gi.repository import Gtk
                         dpi = str(Gtk.Settings.get_default().props.gtk_xft_dpi / 1024)
 
+                    if os.environ.get('WAYLAND_DISPLAY') is not None:
+                        cmds += ["-W", os.environ["WAYLAND_DISPLAY"]]
+
                     xmodmapfile = self.__homedir + "/.xmodmap"
                     xd = open(xmodmapfile, "w")
                     try:
@@ -484,7 +501,12 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
 
                     self.__setup_sandboxrc(self.__options.wm)
 
-                    cmds += ["--", SANDBOXSH, self.__options.windowsize, dpi]
+                    if self.__options.Y_ind or self.__is_wayland_app():
+                        WN = "yes"
+                    else:
+                        WN = "no"
+
+                    cmds += ["--", SANDBOXSH, WN, self.__options.windowsize, dpi]
                 else:
                     cmds += ["--"] + self.__paths
                 return subprocess.Popen(cmds).wait()
diff --git a/sandbox/sandboxX.sh b/sandbox/sandboxX.sh
index eaa500d08143..28169182ce42 100644
--- a/sandbox/sandboxX.sh
+++ b/sandbox/sandboxX.sh
@@ -2,8 +2,9 @@
 trap "" TERM
 context=`id -Z | secon -t -l -P`
 export TITLE="Sandbox $context -- `grep ^#TITLE: ~/.sandboxrc | /usr/bin/cut -b8-80`"
-[ -z $1 ] && export SCREENSIZE="1000x700" || export SCREENSIZE="$1"
-[ -z $2 ] && export DPI="96" || export DPI="$2"
+[ -z $1 ] && export WAYLAND_NATIVE="no" || export WAYLAND_NATIVE="$1"
+[ -z $2 ] && export SCREENSIZE="1000x700" || export SCREENSIZE="$2"
+[ -z $3 ] && export DPI="96" || export DPI="$3"
 trap "exit 0" HUP
 
 mkdir -p ~/.config/openbox
@@ -20,16 +21,27 @@ cat > ~/.config/openbox/rc.xml << EOF
 </openbox_config>
 EOF
 
-(/usr/bin/Xephyr -resizeable -title "$TITLE" -terminate -screen $SCREENSIZE -dpi $DPI -nolisten tcp -displayfd 5 5>&1 2>/dev/null) | while read D; do
-    export DISPLAY=:$D
-    cat > ~/seremote << __EOF
-#!/bin/sh
-DISPLAY=$DISPLAY "\$@"
+if [ "$WAYLAND_NATIVE" == "no" ]; then
+    if [ -z "$WAYLAND_DISPLAY" ]; then
+        DISPLAY_COMMAND='/usr/bin/Xephyr -resizeable -title "$TITLE" -terminate -screen $SCREENSIZE -dpi $DPI -nolisten tcp -displayfd 5 5>&1 2>/dev/null'
+    else
+        DISPLAY_COMMAND='/usr/bin/Xwayland -terminate -dpi $DPI -retro -geometry $SCREENSIZE -decorate -displayfd 5 5>&1 2>/dev/null'
+    fi
+    eval $DISPLAY_COMMAND | while read D; do
+        export DISPLAY=:$D
+        cat > ~/seremote << __EOF
+#!/bin/bash -x
+export DISPLAY=$DISPLAY
+export WAYLAND_DISPLAY=$WAYLAND_DISPLAY
+"\$@"
 __EOF
-    chmod +x ~/seremote
+        chmod +x ~/seremote
+        /usr/share/sandbox/start $HOME/.sandboxrc
+        export EXITCODE=$?
+        kill -TERM 0
+        break
+    done
+else
     /usr/share/sandbox/start $HOME/.sandboxrc
-    export EXITCODE=$?
-    kill -TERM 0
-    break
-done
+fi
 exit 0
-- 
2.45.0

