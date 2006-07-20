Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6KKq2iP003305
	for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2006 16:52:02 -0400
Received: from e5.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6KKq14T012271
	for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2006 20:52:01 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6KKq1gJ004010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2006 16:52:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6KKpvVx287252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2006 16:52:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6KKpvV7002271
	for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2006 16:51:57 -0400
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.139])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6KKptrL002151
	for <selinux@tycho.nsa.gov>; Thu, 20 Jul 2006 16:51:57 -0400
Message-ID: <44BFECE8.80501@us.ibm.com>
Date: Thu, 20 Jul 2006 15:51:52 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Existence of "helper" functions (specifcally MLS)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey all,

I haven't looked extensively, but I was wondering if there exist any 
funcitons (probably in libselinux?) which would do comparisons on MLS 
labels and would return back whether or not one dominates another, or if 
the categories are equal (or a subset), etc.

Thanks much,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
