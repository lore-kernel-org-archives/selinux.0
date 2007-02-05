Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l15HWxoP021319
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2007 12:32:59 -0500
Received: from ppp1-100.the.forthnet.gr (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l15HY4Bc012070
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2007 17:34:05 GMT
Received: from ppp1-100.the.forthnet.gr (localhost [127.0.0.1])
	by ppp1-100.the.forthnet.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l15HY3xK023318
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2007 19:34:03 +0200
Received: from localhost (localhost [[UNIX: localhost]])
	by ppp1-100.the.forthnet.gr (8.13.8/8.13.8/Submit) id l15HXxWf023317
	for selinux@tycho.nsa.gov; Mon, 5 Feb 2007 19:33:59 +0200
From: Stefanos Harhalakis <v13@priest.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: question
Date: Mon, 5 Feb 2007 19:33:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200702051933.59532.v13@priest.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there,

  Recently I started reading of selinux and I find it very useful. I'm planing 
to use it for a multiuser server installation during the next 6 months. I've 
read most of the documents I could find and a large portion of the 'SELinux 
by Example' book.

  No matter where I looked I did not find an answer to the following question:

  When using the refpolicy, is it possible to adjust permissions without 
changing the existing modules? As far as I understand, the proper way to 
perform changes to existing modules is to change the appropriate .te file and 
recompile it, but this presumes that there is only one kind of policy, one 
policy tree and no future upgrades. Should I create my own supplementary 
modules without defining any interfaces and load them?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
