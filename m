Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06758
	for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2002 15:36:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA01088
	for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2002 20:34:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA01084
	for <selinux@tycho.nsa.gov>; Mon, 30 Dec 2002 20:34:22 GMT
Message-Id: <200212302044.PAA08457@moss-shockers.ncsc.mil>
Date: Mon, 30 Dec 2002 15:44:20 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux To Do list
To: selinux@tycho.nsa.gov, KAMUELA.D.GUERRA@saic.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> According to http://www.nsa.gov/selinux/todo.html there is still work to be
> done on the documentation tasks.
> 
> What still needs to be done and how can I help?

I don't think anyone has written any of the three documents listed on the 
todo.html page.  Prior to starting to work on any such documentation, you should 
review the existing papers and technical reports available from the NSA site 
(http://www.nsa.gov/selinux/docs.html).  Tresys Technology has also written a 
few policy whitepapers, available from their site 
(http://www.tresys.com/selinux), but be aware that some things have changed 
since those whitepapers were written.

We would welcome contributions of HOWTO-style documents.  In creating such
documents, please don't start from scratch; you should be able to leverage
some of the content of the existing papers and reports.  The published
papers and older technical reports were originally written in LaTeX, and
the newer technical reports were written in DocBook.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
