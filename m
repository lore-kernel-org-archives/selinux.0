Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01354
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 09:24:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA23340
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 14:21:57 GMT
Received: from venere.mat.uniroma1.it (venere.mat.uniroma1.it [151.100.50.3])
	by jazzswing.ncsc.mil  with ESMTP id OAA23336
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 14:21:56 GMT
Message-ID: <3DE7778D.9080703@inwind.it>
Date: Fri, 29 Nov 2002 15:19:57 +0100
From: Giorgio Zanin <giorgio.zanin@inwind.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, sds@epoch.ncsc.mil
Subject: label transitions
Content-Type: multipart/related;
 boundary="------------090404000608090603040609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------090404000608090603040609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm now investigating the mechanism used in SELinux to change 
something's security label.
I know there is a kernel interface and a system call for applications  
to do it, their name is security_transition_sid.

The configuration language has two constructs: type_transition and 
type_change. The first is used by the kernel and instructs the security 
server to return a particular label for a type pair and a class when the 
security_transition_sid is called to label a new object or a transformed 
process.

If type_transition is used to label a transformed process, it requires 
the transition permission of the class process.
What about type_transition for files? I mean I had a look at 
file_trans_macro and it seems it's not specified anything like the 
transition process permission to change the type of a file. How can I 
control the privilege to change the type of a new object?

Is it correct to argue that permissions relabelto, relabelfrom and 
transition of file class are used to grant applications the ability to 
change labels with a call to security_transition_sid (with the output 
label specified via type_change)?

Thanks in advance for your nth answer ;)

Giorgio

--------------090404000608090603040609--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
