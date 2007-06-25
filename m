Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5PIsxKU018979
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 14:54:59 -0400
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5PIsv5Z007697
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 18:54:58 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l5PIsOOR002564
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 14:54:24 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l5PIs4Gr019893
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2007 14:54:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: mls contraints on adding files to directories
Date: Mon, 25 Jun 2007 11:54:55 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01DBFA97@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that I'm misunderstanding the mls constraints on adding files to
directories. 

I thought that the following constraint would prevent adding a file at a
higher security level than the directory, unless the domain of the
writing process had been given the mlsfilewritetoclr attribute, or the
directory type had been given the mlstrustedobject attribute:

mlsconstrain dir { add_name remove_name reparent rmdir }
	((( l1 dom l2 ) and ( l1 domby h2 )) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby
l2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

However, I can use runcon to create a file at a higher level than the
directory. For example, I can do the following:

> runcon -l s3 touch /m2ds/import/datasources/inputBuffer/U/temp

> ls -Z /m2ds/import/datasources/inputBuffer/U/temp
-rw-r--r--  root root root:object_r:import_datasources_t:s3
/m2ds/import/datasources/inputBuffer/U/temp

> ls -dZ /m2ds/import/datasources/inputBuffer/U
drwxrwxr-x  root m252 system_u:object_r:import_datasources_t:s1
/m2ds/import/datasources/inputBuffer/U

I'm able to do this with the policy in Enforcing mode. 

So what is this mlsconstrain statement doing?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
