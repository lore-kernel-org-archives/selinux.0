Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA05325
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2001 22:50:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA19032
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 02:50:02 GMT
Received: from halifax.chebucto.ns.ca (chebucto.ns.Ca [192.75.95.75])
	by jazzband.ncsc.mil  with ESMTP id CAA19026
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 02:50:01 GMT
Date: Mon, 9 Apr 2001 23:50:01 -0300 (ADT)
From: Joey Mitchell Comeau <aw096@chebucto.ns.ca>
To: selinux@tycho.nsa.gov
Subject: build-apps trouble.
In-Reply-To: <m14mjx3-00005EC@zuul.dsndata.com>
Message-ID: <Pine.GSO.3.95.iB1.0.1010409232809.13843A-100000@halifax.chebucto.ns.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi.

I'm working through the installation of selinux and the build-apps tool is
quitting with 
stat*: no match. 

I looked in utils and there are no directories that start with stat, only
spasswd and newrole

Everything in build-apps.log looks like

-----------PASTE
make[1]: Entering directory
`/root/slinux/slinux/syscalls/unix_stream_client'
gcc  -c -I../../include -I../../kernel/include unix_stream_client.c
unix_stream_client.o be done...
-----------/PASTE

Which I assume means a-ok.
The following got printed to stderr when it was running,

-------------PASTE
msgwrite.c: In function `main':
msgwrite.c:103: warning: passing arg 2 of `msgsnd_secure' from
incompatible pointer type
------------/PASTE

Has something gone wrong earlier in the process?

I am working with the support files tarball from the nsa page, 
as well as the full tree for 2.2.18 from same page.

So far the only change I've had to make is substituting the redhat-gcs
references for mandrake/2.95.2 references in the makefiles in syscalls

any help or pointers would be greatly appreciated.

joey



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
