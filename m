Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29247
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 14:27:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA10012
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 19:25:08 GMT
Received: from segalo.cs.poste.it ([62.241.4.185])
        by jazzband.ncsc.mil  with ESMTP id TAA10002 for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 19:25:07 GMT
Message-ID: <3DC6CAB2.3070008@inwind.it>
Date: Mon, 04 Nov 2002 20:29:54 +0100
From: Giorgio Zanin <giorgio.zanin@inwind.it>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>, selinux@tycho.nsa.gov
Subject: type transition
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

what's the difference between the following statements:

type_transition TYPE_A TYPE_B:process TYPE_C

and

allow TYPE_A TYPE_C:process transition
?

If I am  not wrong the first statement forces a new process, created by
TYPE_A, to belong to TYPE_C, i.e. everytime TYPE_A creates a process
(with respect to TYPE_B) this process is made member of TYPE_C.
The second statement allows TYPE_A to change to TYPE_C.
Does both occur upon an execve()? If so, what's the difference between
them? It seems the first requires a call to fork(), while the second
does not; probably I am wrong but it's the only difference I can argue.
Can anyone explain how these type transitions occur (possibly everything
about type transitions in SELinux....)?

Thanks
Giorgio



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
