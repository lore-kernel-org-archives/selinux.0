Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBH1anIi029287
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 20:36:50 -0500 (EST)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBH1Z6NH020172
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 01:35:07 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-02.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id iBH1amIM014286
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:36:49 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 7194A4A626
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:36:48 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19838-02 for <selinux@tycho.nsa.gov>;
	Thu, 16 Dec 2004 19:36:48 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 4AD434A624
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:36:48 -0600 (CST)
Date: Thu, 16 Dec 2004 19:36:48 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: setting boolean values
Message-ID: <20041217013648.GB11330@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stupid question... which component is responsible for setting the 
initial value for booleans during system startup?  I'm guessing this 
would be init's job, but am not absolutely certain.  I'm trying to 
determine why they aren't being set properly on my Debian system... 
hopefully it's not something embarrassingly stupid (nah, that NEVER 
happens! ;-).

My /etc/selinux/config contains the following:

   # used by init
   SELINUX=enforcing
   # Debian does not support using a config file to switch between policies
   SELINUXTYPE=.

My /etc/selinux/booleans contains:

   spamassasin_can_network=1

Any thoughts?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
