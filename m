Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9GJergI015853
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 15:40:53 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9GJer6I000323
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2008 19:40:53 GMT
Received: from 78-3-189-137.adsl.net.t-com.hr ([78.3.189.137] helo=[192.168.1.22])
	by house.lunarmania.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1KqYiF-0000xv-TE
	for selinux@tycho.nsa.gov; Thu, 16 Oct 2008 12:40:49 -0700
Message-ID: <48F798BB.6070602@rubix.com>
Date: Thu, 16 Oct 2008 21:40:43 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: adding objects classes and permissions to policy
Content-Type: multipart/alternative;
 boundary="------------090301020004030508050408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090301020004030508050408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


When adding new object classes and permissions to SELinux policy is it 
necessary to re-create flask.h and av_permissions.h header files so that 
a user-space object manager can access the associated defines? If so, 
would someone give me some pointers as to how these are generated?

Thanks,

Andy

--------------090301020004030508050408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial"><br>
When adding new object classes and permissions to SELinux policy is it
necessary to re-create flask.h and av_permissions.h header files so
that a user-space object manager can access the associated defines? If
so, would someone give me some pointers as to how these are generated? <br>
<br>
Thanks,<br>
<br>
Andy<br>
</font>
</body>
</html>

--------------090301020004030508050408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
