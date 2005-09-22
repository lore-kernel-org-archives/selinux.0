Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8M25PNs015483
	for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2005 22:05:25 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8M215Ep001786
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 02:01:05 GMT
Message-ID: <4332121F.2010904@cornell.edu>
Date: Wed, 21 Sep 2005 22:08:31 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: kmacmillan@tresys.com, dwalsh@redhat.com
Subject: Re: [ SEMANAGE ] Redesign dbase
References: <43320A2E.5000906@cornell.edu>
In-Reply-To: <43320A2E.5000906@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Arr...I see a bug... query() needs to clone the record:

s/..................
                 else
                                *response = entry->data;

 	return STATUS_SUCCESS;

.........

	if (dconfig->rtable->clone(entry->data, *response) < 0)
		goto err;
	
	return STATUS_SUCCESS;


Also, that list could probably be singly-linked...I can fix this later...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
