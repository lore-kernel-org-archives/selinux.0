Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k59GbqDQ026036
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 12:37:52 -0400
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k59Gbpqa009981
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 16:37:52 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k59Gbl9N018181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 12:37:47 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k59GbeN1213822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 10:37:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k59GblUb030867
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 10:37:47 -0600
Received: from sergelap.hallyn.com (sig-9-76-5-196.mts.ibm.com [9.76.5.196])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k59Gbktb030856
	for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2006 10:37:46 -0600
Date: Fri, 9 Jun 2006 11:36:52 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: prevent null deref
Message-ID: <20060609163652.GA9987@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If the allocation of vallist fails, we jump to the error
path where we immediately try to free vallist[i].  Make sure
that doesn't happen.

I'd like to happily point out that this seems to address the
last valid-seeming bug found by our internal code checker :)

thanks,
-serge

--- policycoreutils/setsebool/setsebool.c.orig	2006-06-09 11:26:21.000000000 -0500
+++ policycoreutils/setsebool/setsebool.c	2006-06-09 11:26:33.000000000 -0500
@@ -252,9 +252,11 @@ int setbool(char **list, size_t start, s
 	fprintf(stderr, "setsebool: out of memory");
 		
 	err:
-	for (i=0; i < boolcnt; i++) 
-		free(vallist[i].name);
-	free(vallist);
+	if (vallist) {
+		for (i=0; i < boolcnt; i++) 
+			free(vallist[i].name);
+		free(vallist);
+	}
 	return -1;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
