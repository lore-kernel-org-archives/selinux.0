Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA13694
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 14:32:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA08532
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 19:30:50 GMT
Received: from penguincomputing.com ([209.24.233.229])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with SMTP id TAA08528
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 19:30:49 GMT
Date: Fri, 22 Dec 2000 11:31:44 -0800
From: Jeremiah Johnson <jjohnson@penguincomputing.com>
To: selinux@tycho.nsa.gov
Subject: well.. stuff doesnt build.
Message-ID: <20001222113144.A18856@mailserver.penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Ok, 

	So I was attempting to build this stuff into rpm's.  But some of the include files reference files that don't seem to exist.  ie:

include/fs_secure.h
include/proc_secure.h
include/socket_secure.h
include/ss_types.h

  all reference

#include <linux/flask/flask.h>

"flask.h" doesnt exist in the distro.  I tried replacing "linux/flask/flask.h" with "flask_util.h" and compiling fileutils and it errors in building.  I can print the error if it would help.  But since I dont think flask.h and flask_util.h are the same its probably not related to that.

Jeremiah Johnson
Linux Security Analyst
Penguin Computing

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
