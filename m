Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8ULGwD4027369
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 17:16:58 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8ULFpsN004677
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 21:15:51 GMT
Message-ID: <451EDEC6.1090401@hp.com>
Date: Sat, 30 Sep 2006 17:16:54 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Audit events for IPsec based network labeling
References: <20060930144449.37002.qmail@web51505.mail.yahoo.com>
In-Reply-To: <20060930144449.37002.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve G wrote:

> Do we need any audit events for the inserting or deletion of rules for the IPsec
> based network labeling scheme? What about Secmark?

The way I read the application notes in the LSPP sections about
importing and exporting labeled and unlabeled data, I'd say we do if
we're using them for labeling and for security decisions in an LSPP
configuration.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
