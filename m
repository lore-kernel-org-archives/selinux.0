Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17908
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 14:44:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OJi4I05862
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 19:44:04 GMT
Received: from fapp01.csoconline.com (csoc-mail-smtp.csoconline.com [140.169.2.146])
        by jazzband.ncsc.mil  with SMTP id h1OJi2f05857 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 19:44:03 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015244E1@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Wayne Salamon'" <wsalamon@tislabs.com>,
        SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: Core policy
Date: Mon, 24 Feb 2003 13:43:34 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I agree with Wayne, 
There needs some real work done on policy managemnet. 
Core policy and addons seem to be a good idea.

>Macros
>======
> The use of macros has grown to be a large problem. 
> ......
> The use of parameterized macros makes it very difficult to analyze the
policy
> source files. Also, there are several instances of rules being duplicated
> in the generated policy due to macro usage.

In tring to run conversions on the policy file to xml I run into problem
with the macro usage. 


Mark Westerman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
