Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB2JVTJf029761
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2008 14:31:29 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id mB2JTOAk023600
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2008 19:29:24 GMT
Subject: Re: [refpolicy] the new way of newrole
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <1228170742.2966.6.camel@unix>
References: <1228170742.2966.6.camel@unix>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 14:30:46 -0500
Message-Id: <1228246249.9691.32.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-12-01 at 14:32 -0800, Justin P. Mattock wrote:
> Hello;
> this new policy(svn) is killing me over here... 
> Am I supposed to be startingx
> like this:(after login a command prompt)
> newrole -r staff_r -- -c /usr/bin/startx

No, this won't work.  Newrole can only transition to user domains (eg
staff_t) and only by executing a shell.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
