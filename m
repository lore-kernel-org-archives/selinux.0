Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA20890
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:25:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA28447
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 17:23:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA28439 for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 17:23:39 GMT
Date: Tue, 29 Oct 2002 12:25:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: sulogin_exec_t
In-Reply-To: <200210291721.52497.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210291224350.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Oct 2002, Russell Coker wrote:

> Is there any reason why sulogin_exec_t doesn't have the exec_type attribute?

No.  Feel free to add it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
