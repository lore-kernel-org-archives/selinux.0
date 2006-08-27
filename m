Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7RGoofi018579
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 12:51:05 -0400
Received: from bay0-omc1-s30.bay0.hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7RGoVYc013518
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 16:50:32 GMT
Message-ID: <BAY114-F20E1AAF9368A7EA393C312AF3B0@phx.gbl>
In-Reply-To: <200608272141.29051.russell@coker.com.au>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: MLS with DAC
Date: Sun, 27 Aug 2006 18:50:42 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good morning everybody. I wonder if it could be possible to achieve partial 
MLS using standard DAC: what if I create 4 group of users (TS, Secret, 
Confidential, Unclassified), and create documents with those groups as 
owner, so that only users who belong to each group can access documents of 
that kind?

_________________________________________________________________
Ami viaggiare?Ma non sai dove andare? 
http://search.msn.it/results.aspx?q=viaggiare&FORM=QBRE


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
