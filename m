Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7TLMxLa029443
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 17:22:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7TLLUpQ014046
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 21:21:30 GMT
Received: from etsuex1.etsu.edu (etsuex1.etsu.edu [151.141.8.103])
	by jazzswing.ncsc.mil  with ESMTP id h7TLLTQX014036
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 21:21:29 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: Type background of SELinux
Date: Fri, 29 Aug 2003 17:22:50 -0400
Message-ID: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3566@etsuex1.etsu.edu>
From: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
Thanks, that's helpful.  Let me see if I understand this correctly:
 
* is there a notion of dynamic types?  
* is there a common type hierarchy (or type tree, as in how C will automatically coerce int's into float's, for example)
* how are interpreters (such as perl, python, etc) handled that have direct access to the C library?
 
Thanks,
Steven
 

	-----Original Message----- 
	

	...

	A "type" in TE is simply a security equivalence class for objects; all
	objects with the same security properties have the same type.  You could
	just as easily refer to it as a "security tag" or "security label".   TE
	is simply "the Lampson access matrix organized into equivalence classes
	for efficiency", as stated by Earl Boebert.  The security policy writer
	can define types to represent specific functional and integrity
	properties of executables, label the executables with these types, and
	define policies over the ability to execute from these types.
	
	



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
