Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ID0jrT016496
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 09:00:45 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ID0Zpw022033
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 13:00:35 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5ID0gl32004
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 09:00:42 -0400
To: "Karl MacMillan" <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Fedora Core 2 setools RPM
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 18 Jun 2004 09:00:33 -0400
In-Reply-To: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
Message-ID: <ogtpt7x10ni.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Karl MacMillan" <kmacmillan@tresys.com> writes:

> ...  We will be putting an interim release out soon and will include
> the installation of the include files and libraries (shared and
> static).

Great news.  I would greatly appreciate it if the libapol API includes
access to CONSTRAIN statements in a policy file.  I strongly suspect
the API could then be used to provide slat all the information it
needs to analyze a policy.

I also noticed that it appears that none of the setools documentation
tells users that your flow analysis ignores CONSTRAIN statements in a
policy.  I think users should know this fact.

$ grep -i constrain */*.in
docs-src/apol_help_text.in:	You can use any regular expression to constrain the search. So 
$ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
