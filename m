Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JEtQE8011427
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 10:55:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JEtPD6022041
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 14:55:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5JEtO3m030016
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 10:55:24 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5JEtOXk018291
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 10:55:24 -0400
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l5JEtN30003500
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 10:55:24 -0400
Message-ID: <4677EE5B.9030405@redhat.com>
Date: Tue, 19 Jun 2007 10:55:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Per Domain Permissive Mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steven mentioned in another conversion the idea of a Per Domain 
Permissive Mode.  This is something our customers are looking for. 

A few customers want to write policy to confine an application but they 
are afraid of releasing it in enforcingmode to hundreds/thousands of 
machines, and then finding out they missed a crucial code path.  The 
would like to be able to write the policy distribute it and gather AVC 
messages in for a couple of months, until they fail confident that the 
policy will work.  Currently they would have to turn all the machines to 
permissive mode or take there chances.  

Having a simple domain that would run in permissive mode while the rest 
of the machine ran enforcing would satisfy this need.

Thoughts...

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
