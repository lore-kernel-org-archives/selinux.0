Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAGEQnRb002535
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 09:26:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAGEQmqY025808
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 14:26:48 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAGEQm0o025805 for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 14:26:48 GMT
Date: Sun, 16 Nov 2003 14:26:35 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Specific details of the policy ERR
Message-ID: <20031116142635.GJ17041@vnl.com>
References: <200311100849.52026.russell@coker.com.au> <200311121338.13459.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311121338.13459.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To save you some time, here's where the double def of the
type are occuring:

misc/later.te:		type run_init_conf_t, file_type, sysadmfile;
misc/later.te:		allow userhelper_t run_init_conf_t:file rw_file_perms;

program/userhelper.te:	type run_init_conf_t, file_type, sysadmfile;
program/userhelper.te:	allow userhelper_t run_init_conf_t:file rw_file_perms;

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
