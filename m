Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QFXGB7006600
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 11:33:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 855841A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:33:20 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJPQqC+pc9Fh for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 17:33:19 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 20AA11A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 17:33:19 +0200 (CEST)
Date: Mon, 26 Mar 2012 17:33:17 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] policycoreutils -- Only run setfiles if we found
 read-write filesystems to run it on
Message-ID: <20120326173317.25d0ed1c@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Only run setfiles if we have a R/W filesystem

Laurent


From: Manoj Srivastava <srivasta@debian.org>
Date: Thu, 5 Jun 2008 22:07:22 -0500
Subject: Only run setfiles if we found read-write filesystems to run it on

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 scripts/fixfiles |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 310fccf..0db4558 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -234,7 +234,12 @@ then
 	done
 FC=$TEMPFCFILE
 fi
-${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE
+if [  -n "${FILESYSTEMSRW}" ]; then
+    echo "Relabeling `echo ${FILESYSTEMSRW}`"
+    ${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE
+else
+    echo >&2 "fixfiles: No suitable file systems found"
+fi
 rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFCFILE
 
 UNDEFINED=`get_undefined_type` || exit $?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
