Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22467
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 13:30:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA19202
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 18:28:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA19197
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 18:28:05 GMT
Message-Id: <200301081838.NAA13755@moss-shockers.ncsc.mil>
Date: Wed, 8 Jan 2003 13:38:01 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: RE: Policy Language
To: sguttman@mitre.org, selinux@tycho.nsa.gov, Mark.Westerman@csoconline.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I am asking to remove context sensitive meaning from tokens in the language.
> 
> Taken from "info bison".
> 
> "The Bison paradigm is to parse tokens first, then group them into
> larger syntactic units.  In many languages, the meaning of a token is
> affected by its context.  Although this violates the Bison paradigm,
> certain techniques (known as "kludges") may enable you to write Bison
> parsers for such languages."

The meaning of the tokens is not context sensitive.  The fact that the keyword 
'class' can occur in two different statements does not present a problem in 
scanning and parsing the configuration.  The policy language grammar does not 
rely on any of the "kludges" described in the referenced section of the bison 
manual.  Token parsing does not depend on semantic or syntactic context.

You can use the provided grammar (or a subset of it) as a basis for developing 
your own policy tools, as has already been done by others such as Tresys and 
MITRE.  

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
