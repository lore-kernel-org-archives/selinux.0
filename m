Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15585
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 14:09:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA17110
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 18:08:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA17106
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 18:08:13 GMT
Date: Wed, 14 Aug 2002 14:01:44 -0400 (EDT)
From: Wayne Salamon <wsalamon@tislabs.com>
To: "M. H." <metalhead00@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: socket_secure fails with "Function not implemented"
In-Reply-To: <F92VHt8fddAkOhw2RlC000009e1@hotmail.com>
Message-ID: <Pine.LNX.4.33.0208141356300.27831-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Aug 2002, M. H. wrote:

> What is the status of the secure socket calls? What issues remain unresolved
> (I am most interested in finding out the sid of a UNIX domain socket peer.)
>

  For the LSM-Selinux, getpeername_secure() is implemented, but the SID
returned for the peer is not correct for Unix domain sockets. We have a
pending patch for LSM that will allow us to correctly set the peer SID on
Unix and INET sockets.


-- 
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
