Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AHTUrT029238
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 13:29:30 -0400 (EDT)
Received: from web.different1.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AHTNP2012714
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 13:29:25 -0400 (EDT)
Date: 10 Jun 2004 12:26:12 -0500
Message-ID: <20040610172612.25551.qmail@web.different1.com>
To: selinux@tycho.nsa.gov
Subject: Restrict File creation types
From: Kenny <selinux@kfk2.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How would I go about restricting all files created in a certain
directory to a set of types. Eg:
I have Dir Types:
Dir_Type1_t
Dir_Type2_t
and file Types:
File_type_1a_t
File_type_1b_t
File_type_2a_t
File_type_2b_t

I want all files in Dir_Type1_t to be of types File_type_1a_t or
File_type_1b_t no matter the domain of the creating process 
and all files in Dir_Type2_t to be of types File_type_2a_t or
File_type_2b_t.
(mkdir -Z user:object_r:File_type_2a_t TEST in a dir of type
Dir_Type2_t should fail as any user/role/domain)

I've tried looking through the logs with auditallow on for all the Dir
and File types, but didn't see anything where both types where listed
in the same allow statement.  Is this even possible?

Kenny

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
