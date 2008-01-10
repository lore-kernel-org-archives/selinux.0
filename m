Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0AGYkfL020646
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 11:34:46 -0500
Received: from e5.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0AGYj0M013039
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 16:34:45 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0AGYjJ9022717
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 11:34:45 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m0AGYjjT203706
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 11:34:45 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m0AGYiiU001705
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 11:34:44 -0500
Received: from sergelap.hallyn.com (sig-9-65-98-134.mts.ibm.com [9.65.98.134])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m0AGYi3S001696
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2008 11:34:44 -0500
Date: Thu, 10 Jan 2008 10:34:49 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [refpolicy patch] add setfcap to list of capabilities
Message-ID: <20080110163449.GA2738@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

