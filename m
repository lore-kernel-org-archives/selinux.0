Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05983
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:55:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA01549
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 16:53:53 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA01545 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 16:53:51 GMT
Date: Tue, 1 Oct 2002 12:54:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: patch for home_root_t
In-Reply-To: <200209280154.44998.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011254080.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 28 Sep 2002, Russell Coker wrote:

> The attached patch makes home_root_t work.

I merged this patch, although some of the rules are redundant with the
corresponding rule in base_file_read_access, which is included by
every_domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
