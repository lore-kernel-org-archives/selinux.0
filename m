Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m55L25G2003278
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 17:02:05 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m55L24rd013868
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 21:02:04 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m55L0cVY018482
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 17:00:38 -0400
Received: from blums0042.bluelnk.net ([134.120.81.54])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m55L1kca019367
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 17:01:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: modules.conf problem
Date: Thu, 5 Jun 2008 14:01:59 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9E7C9@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting the following compile errors when attempting a clean compile
of my policy:

policy/modules/apps/import.if:336: Error: duplicate definition of
nlscripts_dir_search(). Original definition on 25.
policy/modules/apps/import.if:344: Error: duplicate definition of
nlscripts_dir_list(). Original definition on 17.

The thing is that I have commented out the import module out of the
modules.conf file. In fact I commented it out several weeks ago and have
done many clean compiles since without issue until this morning.

The only way that I have been able to get past these errors is to remove
the import.{te,if,fc} files from the apps directory. Then the policy
compiles and loads fine. I must have changed something in one of the
other policy files that caused this to suddenly crop up today but I have
no idea what.

If anyone has any ideas on what may be causing this or ideas on how to
track down what the problem is I would greatly appreciate hearing them.

I'm using the RHEL5.1 mls policy.

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
