Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06078
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 07:05:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19343
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:03:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA19338
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:03:45 GMT
Date: Thu, 31 Oct 2002 07:05:12 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Chris Wright <chris@wirex.com>
cc: James W Carter <jwcart2@epoch.ncsc.mil>, <linux-security-module@wirex.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: SELinux Kernel Oops
In-Reply-To: <20021030152926.B8483@figure1.int.wirex.com>
Message-ID: <Pine.GSO.4.33.0210310702140.23380-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, Chris Wright wrote:

> Hmm, this is an ugly one.  Primarily because it touches into the fs
> specific code.  I don't see a good way to do this any differently aside
> from introducing a wrapper like f_release that just conditionally calls
> f->release and ->file_free_security...

Yes, that would be straightforward.  Maybe a put_private_file function in
fs/file_table.c that makes these two calls, analagous to fput?

> BTW, you missed the DTE instance of init_private_file.

Shouldn't matter, since DTE doesn't allocate or use a security field for
file structures, and it can't be stacked with SELinux.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
