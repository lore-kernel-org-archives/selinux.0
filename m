Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8KH3tkm014995
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 13:03:55 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8KH3sVg021650
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 17:03:54 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8KH2XpF000427
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 13:02:33 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l8KH1pwZ032198
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 13:01:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: variables for file context files
Date: Thu, 20 Sep 2007 10:03:51 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0236BF7C@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a way to set variables in a file context file?

For instance, I'd like to be able to do something like this in my .fc
files

ORACLE_HOME = '/opt/nl/oracle/ora10gR2/app/oracle/product/10.2.0/db_1'
$ORACLE_HOME/lib/lib.+\.a -- gen_context(system_u:object_r:lib_t,s0)
$ORACLE_HOME/lib32/lib.+\.a -- gen_context(system_u:object_r:lib_t,s0)
...

That way if my ORACLE_HOME changes, I only have to change a single line

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
