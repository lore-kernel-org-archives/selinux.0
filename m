Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8T0rlZj017515
	for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2007 20:53:47 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8T0rkkq019718
	for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2007 00:53:46 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8T0pIDk016226
	for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2007 20:51:18 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8T0qH8G008709
	for <selinux@tycho.nsa.gov>; Fri, 28 Sep 2007 20:52:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: m4 help
Date: Fri, 28 Sep 2007 17:52:39 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD49A299@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I need help with m4 macros.

I'm using m4 macros in my file context files to define common paths, so
that I only have to define them once. Here's an example of what I'm
doing:

define(`SDK_HOME',`/opt/oracle/product/AccessServerSDK')
SDK_HOME/oblix/lib/lib.+\.so.* --
gen_context(system_u:object_r:shlib_t,s0)

The above statement works fine. But the below statement does NOT:

SDK_HOME(/.*)?  gen_context(system_u:object_r:oracle_sp_file_t,s0)

This expands to:
/opt/oracle/product/AccessServerSDK?
gen_context(system_u:object_r:oracle_sp_file_t,s0)

rather than

/opt/oracle/product/AccessServerSDK(/.*)?
gen_context(system_u:object_r:oracle_sp_file_t,s0)

How can I get m4 to handle this case properly?

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
