Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0RDdY2D030738
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 08:39:34 -0500
Received: from mailhub249.itcs.purdue.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0RDaXoA003125
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 13:36:33 GMT
Received: from jacques-thomas-powerbook-g4-17.local (c-98-223-73-152.hsd1.in.comcast.net [98.223.73.152])
	(authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.14.2/8.14.2/smtp-auth.purdue.edu) with ESMTP id n0RDdVwI002180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Tue, 27 Jan 2009 08:39:32 -0500
Message-ID: <497F0E8C.4010301@cs.purdue.edu>
Date: Tue, 27 Jan 2009 08:39:24 -0500
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SE-PostgreSQL to be considered for upstream in PostgreSQL
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

According to the following email message that was forwarded to me, the 
PostgreSQL community is considering to upstream the type enforcement 
patches from KaiGai Kohei.

They need participation from the security community. The discussion 
starts on the pgsql-hackers mailing list tomorrow; details below.

Best,
Jacques

*From: *Bruce Momjian <bruce@momjian.us <mailto:bruce@momjian.us>>
*Date: *January 24, 2009 10:36:22 AM GMT-05:00
*To: *PostgreSQL-announce <pgsql-announce@postgresql.org 
<mailto:pgsql-announce@postgresql.org>>
*Subject: **[ANNOUNCE] Need help on possible PG 8.4 security features*

The PostgreSQL community is considering including security enhancements
in Postgres 8.4, e.g. row-level permissions and SE-Linux security.
However, to evaluate the patch and its usefulness, we need security
experts who want to use this capability or have used it in other
databases.

The most recent version of the patch is mentioned here:

http://archives.postgresql.org/pgsql-hackers/2009-01/msg01680.php

Particularly interesting is the documentation patch:

http://sepgsql.googlecode.com/files/sepostgresql-docs-8.4devel-3-r1460.patch

If you know someone who is interested in these features or can help in
discussing them, please have them subscribe to pgsql-hackers here:

http://www.postgresql.org/community/lists/subscribe

Email discussion about this topic will start on Wednesday, January 28,
at 12:00 GMT, and will include the subject text "SE-PostgreSQL".

-- 
 Bruce Momjian  <bruce@momjian.us>        http://momjian.us
 EnterpriseDB                             http://enterprisedb.com

 + If your life is a hard drive, Christ can be your backup. +

---------------------------(end of broadcast)---------------------------
-To unsubscribe from this list, send an email to:

              pgsql-announce-unsubscribe@postgresql.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
