Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7TJvTLa028795
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 15:57:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7TJvOet013772
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 19:57:29 GMT
Received: from etsuex1.etsu.edu (etsuex1.etsu.edu [151.141.8.103])
        by jazzband.ncsc.mil  with ESMTP id h7TJvHlq013768 for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2003 19:57:23 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Type background of SELinux
Date: Fri, 29 Aug 2003 15:57:01 -0400
Message-ID: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3563@etsuex1.etsu.edu>
From: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I've read in the various papers (Freenix presentation & the Ottawa
presentation), and I have some questions on the theoretical background
of SELinux.  Are there any pointers to the actual type models of
SELinux, or background material on the type system?  I found the Ottawa
paper to be the most descriptive, but there were still several
assertions that were made that were not explicitly discussed in the
paper.  

For example, there is the statement:

"... TE allows the relationship between a subject and its executable to
be tightly controlled, enabling protection based on the function and
trustworthiness of code and offering protection against the execution of
malicious code."

It's not immediately clear to me how much of a role types really play in
achieving this protection (beyond a very simple static type check).
Also, it's not clear to me how rich of a type system is actually
necessary -- is there a more formal definition of the type system
somewhere? 

Thanks,
Steven Jenkins
East Tennessee State University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
