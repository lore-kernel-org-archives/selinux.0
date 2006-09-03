Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k83J9fr5013395
	for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2006 15:09:43 -0400
Received: from bay0-omc3-s4.bay0.hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k83J8xn4008486
	for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2006 19:09:00 GMT
Message-ID: <BAY114-F8E865C1A9A150F1B9063BAF320@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: Limitation of damages
Date: Sun, 03 Sep 2006 21:09:35 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I have a doubt about the limitation of damanges in the event of a 
buffer overflow (or some kind of similar attack): If I have a program which 
runs as "root" (because it has the setuid flag), and it is compromised, the 
damage is still contained to the domain of the running program, right? But, 
if for example I execute a shellcode which opens a shell, could I do a 
'newrole -t unconfined_t' or to wathever domain I want to inflict damage to? 
Can I limit this changes of domain?
I have another question: I have a SELinux machine, which has only the binary 
policy file, so there's no way an intruder can modify the policy sources to 
weaken the security of the system, recompile them and reload them...But what 
if the intruder create a very lazy security policy on his/her computer, 
recompile it, and then upload the binary policy file to the compromised 
system, so that this gets a weakened security policy?
Thanks

_________________________________________________________________
Vuoi vedere la reazione dei tuoi amici? 
http://imagine-msn.com/messenger/launch80/?locale=it-it


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
