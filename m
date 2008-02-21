Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1LC0AQb002993
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 07:00:10 -0500
Received: from qb-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1LC09fK028634
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 12:00:09 GMT
Received: by qb-out-0506.google.com with SMTP id e7so3332564qbe.8
        for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 04:00:09 -0800 (PST)
Message-ID: <7b740b700802210400k7251155at88cf77e761cb6248@mail.gmail.com>
Date: Thu, 21 Feb 2008 17:00:05 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: selinux@tycho.nsa.gov
Subject: [RFS] Application changing remote policy
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1863_30135987.1203595205734"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_1863_30135987.1203595205734
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am working on an application that needs access to a remote selinux system
and this application would like to change the policy for itself so that it
can use some resources. Definitely it has to be trusted! I know its weird
but in case it has to then what should basically be the sensible thing to
do? Is there a possibility that my application can pick the policy that is
relevant to itself from the remote selinux so that it can try to modify it?
If the policy is not available in text form (monolithic/base or LPM) then
what can be the possibilities? Something from the selinuxfs or maybe some
tweaking module needed to handle the AVC. If anyone thinks I am stupid
(especially Mr. Smalley) then I already know this ;-)

-- 
Shahbaz Khan
Research Associate, SERG, IMSciences
Group: http://serg.imsciences.edu.pk
Site: http://shazkhan.wordpress.com
Email: shazalive@gmail.com
cell: +92 300 5944647

------=_Part_1863_30135987.1203595205734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am working on an application that needs access to a remote selinux system and this application would like to change the policy for itself so that it can use some resources. Definitely it has to be trusted! I know its weird but in case it has to then what should basically be the sensible thing to do? Is there a possibility that my application can pick the policy that is relevant to itself from the remote selinux so that it can try to modify it? If the policy is not available in text form (monolithic/base or LPM) then what can be the possibilities? Something from the selinuxfs or maybe some tweaking module needed to handle the AVC. If anyone thinks I am stupid (especially Mr. Smalley) then I already know this ;-)<br clear="all">
<br>-- <br>Shahbaz Khan<br>Research Associate, SERG, IMSciences<br>Group: <a href="http://serg.imsciences.edu.pk">http://serg.imsciences.edu.pk</a><br>Site: <a href="http://shazkhan.wordpress.com">http://shazkhan.wordpress.com</a><br>
Email: <a href="mailto:shazalive@gmail.com">shazalive@gmail.com</a><br>cell: +92 300 5944647

------=_Part_1863_30135987.1203595205734--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
