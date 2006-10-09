Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k99HS4lr023172
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 13:28:04 -0400
Received: from M4.sparta.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k99HQlS2002340
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 17:26:47 GMT
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.13.5/8.13.5) with ESMTP id k99HS4MU028029
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 12:28:04 -0500
Received: from nemo.columbia.ads.sparta.com (nemo.columbia.sparta.com [157.185.80.75])
	by Beta5.sparta.com (8.12.11/8.13.1) with ESMTP id k99HS4WR001290
	for <selinux@tycho.nsa.gov>; Mon, 9 Oct 2006 12:28:04 -0500
Mime-Version: 1.0 (Apple Message framework v752.3)
To: SE Linux <selinux@tycho.nsa.gov>
Message-Id: <1ED46139-F06C-4DC6-A577-09BC257C9FBF@sparta.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-11--428427765
From: Todd Miller <Todd.Miller@sparta.com>
Subject: PATCH: fix memory leak in setfiles.c
Date: Mon, 9 Oct 2006 13:28:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-11--428427765
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Add a missing freecon() on an error path.

  - todd


--Apple-Mail-11--428427765
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=setfiles.c.diff
Content-Disposition: attachment;
	filename=setfiles.c.diff

--- setfiles.c.DIST	2006-10-09 13:20:10.000000000 -0400
+++ setfiles.c	2006-10-09 13:23:25.000000000 -0400
@@ -357,6 +357,7 @@
 				"%s: %s not reset customized by admin to %s\n",
 				progname, my_file, context);
 		}
+		freecon(context);
 		goto out;
 	}
 

--Apple-Mail-11--428427765--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
