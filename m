Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18357
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 07:33:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA05820
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:31:57 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA05816 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:31:57 GMT
Date: Mon, 30 Sep 2002 07:33:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: patch for home_root_t
In-Reply-To: <200209280154.44998.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209300732490.15004-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 28 Sep 2002, Russell Coker wrote:

> The attached patch makes home_root_t work.

Most of this should already be covered by the rule in
base_file_read_access.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
