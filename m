Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04849
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2001 13:28:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA28459
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2001 18:27:55 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil  with ESMTP id SAA28454
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2001 18:27:54 GMT
Date: Tue, 6 Mar 2001 12:28:12 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103061828.MAA92699@tomcat.admin.navo.hpc.mil>
To: schroema@hotmail.com, <selinux@tycho.nsa.gov>
Subject: Re: Thoughts on the list...
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

> 
> Am I the only one who wishes the email list daemon added some recognizeable
> text to the subject so as to filter the email easier?  For instance,
> 
> Subject: [selinux] Re: blah blah subject
> 
> Just curious.

Please don't - the subject lines tend to get long enough already.
Filtering should be done based on the "From " line anyway. If your
mail handler is stripping it off - get a better mail handler.

There are entirely too many limitations to MS mail support. I use
the full header information for tracing, and identification. Only
the first line of a mail message can be trusted (the "From " header)
All else is provided as an aid for debugging/tracing. I suspect
that your MS Outlook Express, is stripping it all off- without the
first line you cannot reliably identify the source (or transfer point)
of the message. If you don't have some trust in the rest of the headers
(the "Received:" headers) you have no way to track how far the message
has gone. Or detect when a message is in a loop

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
