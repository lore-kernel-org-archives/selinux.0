Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2BHjRsO014545
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 13:45:27 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2BHjQFt003427
	for <selinux@tycho.nsa.gov>; Wed, 11 Mar 2009 17:45:26 GMT
Received: from 78-3-249-56.adsl.net.t-com.hr ([78.3.249.56] helo=[192.168.1.2])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1LhSUV-0004xE-Fg
	for selinux@tycho.nsa.gov; Wed, 11 Mar 2009 10:45:16 -0700
Message-ID: <49B7F893.9040706@rubix.com>
Date: Wed, 11 Mar 2009 18:44:51 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Significance of the level on a port configuration
Content-Type: multipart/alternative;
 boundary="------------060104000407010500050202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060104000407010500050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Can someone give me a quick overview of the significance (i.e., the MLS 
behavior) of the port level for SELinux.

I am attempting to have two connection from untrusted hosts that are 
statically labeled (with netlabelctl) one at high (s0) and one at low 
(s1). Both connections will be made over the same port number. The 
service accepting the connections runs at SystemHigh on Fedora 9 with 
MLS policy. What difference does the level of the port make ? Assume all 
TE rules are satisfied for the context of my question.

Thanks,

Andy



--------------060104000407010500050202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">Can someone give me a quick overview of the
significance (i.e., the MLS behavior) of the port level for SELinux. <br>
<br>
I am attempting to have two connection from untrusted hosts that are
statically labeled (with netlabelctl) one at high (s0) and one at low
(s1). Both connections will be made over the same port number. The
service accepting the connections runs at SystemHigh on Fedora 9 with
MLS policy. What difference does the level of the port make ? Assume
all TE rules are satisfied for the context of my question.<br>
<br>
Thanks,<br>
<br>
Andy<br>
<br>
<br>
</font>
</body>
</html>

--------------060104000407010500050202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
