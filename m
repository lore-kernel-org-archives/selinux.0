Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA7CL2OJ028921
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 07:21:02 -0500
Received: from nm20.bullet.mail.ne1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oA7CL16w011742
	for <selinux@tycho.nsa.gov>; Sun, 7 Nov 2010 12:21:01 GMT
Message-ID: <182838.53024.qm@web110814.mail.gq1.yahoo.com>
Date: Sun, 7 Nov 2010 04:20:59 -0800 (PST)
From: Behnaz Hassanshahi <behnaz.kallen@yahoo.com>
Subject: temporal role base access control in Linux
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-742494366-1289132459=:53024"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-742494366-1289132459=:53024
Content-Type: text/plain; charset=us-ascii

Hi,
I want to enforce temporal role base access control to Fedora10 platform. 
Therefore, I have written a piece of code which receives simple temporal policy 
rules and updates a file in which disallowed roles are being kept. In order to 
attach the code to the fedora core, I am making use of SELinux modules. I wonder 
if avc_has_perm(...) function in /libselinex/src/avc.c can be the right place 
for using my code where requests will be granted or denied access. Actually, I 
had thought about getting the role field from the security_id_t (@ssid) and 
compare it with the denied roles that my code computes. If I`m wrong and this 
will not work out, is there any other suggestions for attaching my code to 
SELinux?  


Best regards,
Behnaz 


      
--0-742494366-1289132459=:53024
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div>Hi,<br>I want to enforce temporal role base access control to Fedora10 platform. Therefore, I have written a piece of code which receives simple temporal policy rules and updates a file in which disallowed roles are being kept. In order to attach the code to the fedora core, I am making use of SELinux modules. I wonder if avc_has_perm(...) function in /libselinex/src/avc.c can be the right place for using my code where requests will be granted or denied access. Actually, I had thought about getting the role field from the security_id_t (@ssid) and compare it with the denied roles that my code computes. If I`m wrong and this will not work out, is there any other suggestions for attaching my code to SELinux?&nbsp; <br><br>Best regards,<br>Behnaz <br><br></div>
</div><br>







      </body></html>
--0-742494366-1289132459=:53024--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
