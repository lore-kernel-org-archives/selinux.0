Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4EHCTI4013887
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2003 13:12:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4EHCS7R001213
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2003 17:12:28 GMT
Received: from segalo.cs.poste.it (segalo.cs.poste.it [62.241.4.185])
        by jazzband.ncsc.mil  with ESMTP id h4EHCPKP001205 for <selinux@tycho.nsa.gov>; Wed, 14 May 2003 17:12:27 GMT
Received: from yahoo.it (80.116.229.212) by segalo.cs.poste.it (6.7.015) (authenticated as giorgio.zanin@poste.it)
        id 3E775DE1000B13C8 for selinux@tycho.nsa.gov; Wed, 14 May 2003 19:12:05 +0200
Message-ID: <3EC2792D.1020209@yahoo.it>
Date: Wed, 14 May 2003 19:13:17 +0200
From: selinux list <selinux_list@yahoo.it>
MIME-Version: 1.0
To: SELinux mailing list <selinux@tycho.nsa.gov>
Subject: about the safety problem in SELinux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm studying the well known ¨safety problem¨ stated the first time in an 
old article by Harrison, Ruzzu, Ullman.
I know there exist lots of different security models that try to address 
the problem of guarantee the safety of a protection system (in a few 
words, a generic configuratrion of a protection system is said to be 
safe if there is no leakage of any generic right from that 
configuration; in other words there is no propagation of rights). Type 
Enforcement should be safe for default. If I am not wrong it has been 
demonstrated RBAC is not safe in general. There are some 
constraint-oriented  approaches which seems to be good in providing safety.

What about SELinux?

I know some of the people who subscribed this mail list are not sure 
SELinux is safe. But in the Flask doc it's written the control over 
right propagation is provided by ensuring that the security policy is 
consulted every time an object has to be accessed (e.g. for every 
security decision). Another thing that let me guess SELinux should be 
safe is that almost everything is configured by TE (RBAC support is very 
poor) and, above all, it is statically configured.
How could a subject acquire a right which is not granted by the security 
policy?
It sounds to me it's trivial to say SELinux is safe but it's a 
formidable task to configure the security policy in a way it can be 
considered secure.

Is it right what I am thinking about or I am on the wrong way?

(I am developing a small tool for policy analisis purpose, for my 
Graduate School Thesis,  and if SELinux is safe it would be of more 
value...)

Thank you and sorry if what I wrote is silly ;)

Giorgio



_________________________________________________________________
Il servizio Postemail sottopone tutti i documenti a una scansione
automatica antivirus con i programmi TREND MICRO.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
