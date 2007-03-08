Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28MEj3b025759
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 17:14:45 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28MEitt028761
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 22:14:44 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l28MEh1h025930
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 17:14:43 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l28MEhYp001404
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 17:14:43 -0500
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l28MEheP029799
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 17:14:43 -0500
Message-ID: <45F08AD3.6090800@redhat.com>
Date: Thu, 08 Mar 2007 17:14:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I would like to propose dropping the disable_trans boolean.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Several reasons for this.

1.  We have gotten the policy to such a state where most stuff just works.
2.  Problems are easily worked around using audit2allow and loadable 
policy modules
grep badtype /var/log/audit/audit.log | audit2allow -m myfix
3.  Disabling trans often causes more problems then it is worth, because 
of screwed up file context.
4.  You can get the same behavior by changing the file context of a file 
to bin_t.

Thoughts?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
