Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA21927
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 14:17:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA04194
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:16:01 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA04190
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:16:00 GMT
Date: Tue, 29 Oct 2002 14:16:52 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: mysql policy
In-Reply-To: <20021028161207.B8537@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210291407460.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 28 Oct 2002, Tom wrote:

>+allow initrc_t mysqld_db_t:dir { write };

I'm not clear as to the purpose of this rule in isolation.  Without other
directory permissions (e.g. add_name, remove_name), directory write
permission is useless.  What exactly is the rc script doing to this
directory?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
