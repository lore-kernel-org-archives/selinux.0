Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA03738
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 18:15:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA11053
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 22:14:59 GMT
Received: from centauri.ee.ucla.edu (centauri.ee.ucla.edu [128.97.92.179])
	by jazzswing.ncsc.mil  with ESMTP id WAA11049
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 22:14:59 GMT
Received: from localhost (simonhan@localhost)
	by centauri.ee.ucla.edu (8.8.8+Sun/8.8.8(ee-0002)) with ESMTP id PAA14006
	for <selinux@tycho.nsa.gov>; Wed, 3 Jul 2002 15:15:28 -0700 (PDT)
Date: Wed, 3 Jul 2002 15:15:28 -0700 (PDT)
From: Simon Han <simonhan@ee.ucla.edu>
To: selinux@tycho.nsa.gov
Subject: type_transition_rule
Message-ID: <Pine.GSO.4.10.10207031514490.13831-100000@centauri.ee.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
	I am new to selinux.  Please forgive me if the question is stupid.  
	I am playing with the example security server included in selinux.
I wonder if there is a way to do domain transition based on the file
current domain is reading.  Please allow me to explain why I need this.
Consider Java VM,

I define a type 'java_t' for java domain.  
Now, I would like to transition to another domain when java_t is reading
a_file.class file since java_t is about to load this class to the VM, and
I don't trust this class.  It will be desirable to be able to transition
to new domain, say java_insecure_t.  Then, I can config java_insecure_t to
have very strict access rule.  

Could someone please give me a hand?  An answer telling me that this is
not possible is also appreciated.  Even better answer will be telling me
where to modify example server so that this approach can happen.  :)

Thanks in advance,
Simon	




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
