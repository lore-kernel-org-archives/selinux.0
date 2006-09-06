Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k86GK21e013843
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 12:20:02 -0400
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k86GJckO012980
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 16:19:38 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k86GK0xf030775
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 12:20:00 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k86GK0OZ293384
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 12:20:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k86GK03n002089
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 12:20:00 -0400
Received: from sergelap.hallyn.com (sig-9-65-113-206.mts.ibm.com [9.65.113.206])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k86GJx4s002068
	for <selinux@tycho.nsa.gov>; Wed, 6 Sep 2006 12:20:00 -0400
Date: Wed, 6 Sep 2006 11:19:59 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: semanage user
Message-ID: <20060906161959.GA29623@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

It appears removing a user with semanage does not also remove it's
associated logins.  This is a problem because then re-adding the
user fails.  (I do not have the error handy as my test machines are all
down atm)

I had done:
	semanage user -a -R abat_r -P abat abat_u
	semanage login -a -s abat_u abat
	semanage user -r abat_u   [ or is it -d? ]
	semanage user -a -R abat_r -P abat abat_u

the last step failed.  When I then did

	semanage login -d abat  (or was it -r?  :)
	semanage user -a -R abat_r -P abat abat_u

it succeeded.

Not sure whether there is a good reason to leave the code like
that, or whether semanage user -r should automatically imply
semanage login -r.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
