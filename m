Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77GdLq9006442
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 12:39:23 -0400
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77GdKAB005308
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 16:39:20 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l77GcKgb019428
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 12:38:20 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l77GadoC020341
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 12:38:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: java.if
Date: Tue, 7 Aug 2007 09:37:53 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB787D@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a number of domains in which I run java programs. I generally
enter these domains using a script, and then execute_no_trans the java
executable. So I found I kept replicating the following allow rules in
these various domains:

require {type java_exec_t;}
allow weblogic_t java_exec_t:file {getattr read execute
execute_no_trans};

I looked for an interface to use in java.if, but didn't find one. I
added one myself so I could eliminate the above rule in each of these
domains, but I was surprised not to find an existing interface to use.
This seems like it would be a common issue that other policy creators
would run into as well, or am I just missing something?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
