Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA11774
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 13:08:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA21783
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 17:08:10 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA21779
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 17:08:09 GMT
Date: Tue, 25 Jun 2002 13:07:33 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: macros like dir_file_class_set
In-Reply-To: <20020625165846.137142492@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206251305340.7048-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 25 Jun 2002, Russell Coker wrote:

> Steve, could macros like dir_file_class_set be changed to expand to a single
> line?
>
> The reason is that I find it very conveniant to have all lines in the policy
> file be independant.  Sure it's good to have the policy file be free-form to
> enable the user to write such policy files, but for generated code I think
> that every line should be atomic, so that for example I can do "grep -v
> dontaudit" if I want to test something.

Yes, we can certainly make this change for the *_class_set macros.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
