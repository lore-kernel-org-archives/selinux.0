Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA19184
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 16:30:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA03831
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 21:27:16 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id VAA03827
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 21:27:15 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'Clem Skorupka'" <ragnor@mitre.org>,
        "'Wayne Salamon'" <wsalamon@tislabs.com>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: Core policy
Date: Mon, 24 Feb 2003 16:29:57 -0500
Message-ID: <004101c2dc4b$e93fddd0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200302242212.20796.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I suggest that we make the second line of each .te file contain a
comment
> stating which category it is in, with the possibility of policy being
in
> multiple categories.

Category names are a good idea (e.g., #CATEGORY <category name> ).  I
can see all sorts of ways to use that in configuration tools.

I'd like to suggest that the third list be #DEPENDS <list of .te file
upon which this module depends> so we can also manage dependencies with
configuration tools.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
