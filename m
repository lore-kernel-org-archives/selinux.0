Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATCVaRb000085
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 07:31:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hATCVZqY024660
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 12:31:35 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hATCVY0o024657 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 12:31:34 GMT
Date: Sat, 29 Nov 2003 12:31:20 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Policy error of the day
Message-ID: <20031129123120.GI18062@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ah...Russ... did you do something naughty? I note all of these are
failing after the postinst.d/selinux. I wonder if you are 
expecting these installs to be occuring under selinux rather
than on a non-selinux 'factory' machine in a chroot:

run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
dpkg: error processing selinux-policy-default (--configure):
 1Error running trigger postinst: No such file or directory
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
dpkg: error processing modutils (--configure):
 1Error running trigger postinst: No such file or directory
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
dpkg: error processing strace (--configure):
 1Error running trigger postinst: No such file or directory
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
dpkg: error processing hdparm (--configure):
 1Error running trigger postinst: No such file or directory
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
dpkg: error processing dash (--configure):
 1Error running trigger postinst: No such file or directory
run-parts: /etc/dpkg/postinst.d/selinux exited with return code 1
dpkg: error processing cramfsprogs (--configure):
 1Error running trigger postinst: No such file or directory
dpkg: dependency problems prevent configuration of initrd-tools:
 initrd-tools depends on cramfsprogs; however:
  Package cramfsprogs is not configured yet.
 initrd-tools depends on dash | ash; however:
  Package dash is not configured yet.
  Package ash is not installed.
dpkg: error processing initrd-tools (--configure):
 dependency problems - leaving unconfigured
Errors were encountered while processing:
 selinux-policy-default
 modutils
 strace
 hdparm
 dash
 cramfsprogs
 initrd-tools
E: Sub-process /usr/bin/dpkg returned an error code (1)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
