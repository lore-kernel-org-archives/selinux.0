Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05153
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 12:46:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA08425
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 17:43:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id RAA08419
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 17:43:54 GMT
Message-Id: <200301061751.MAA12214@moss-shockers.ncsc.mil>
Date: Mon, 6 Jan 2003 12:51:47 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: Policy Language
To: sds@epoch.ncsc.mil, selinux@tycho.nsa.gov, mark.westerman@westcam.com,
        Mark.Westerman@csoconline.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I used the wrong terminology (ambiguous) Your are absolutely
> correct that it is not ambiguous. While the following foo.y 
> is easily handled in a (yacc) file, it is not so easily handled
> in other languages. While I am asking could we put a ';' at the
> end of all statements ? 
> 
> For a regular expression on the two statements.
> 
> CLASS identifier
> CLASS identifier { identifier_list }
> 
> To identify the second from the first I have to look
> for a { and not just a white space or a ;

Sounds like you are using the wrong tool for the job (regular expressions rather 
than a grammar).  While it would be straightforward to implement the changes you 
suggest to the language, such changes don't seem to be justified by your 
explanation, and others have already developed policy management and analysis 
tools based on the current language definition.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
