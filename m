Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22300
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 14:42:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA05549
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:41:01 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA05545
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:41:01 GMT
Date: Tue, 29 Oct 2002 14:42:29 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: run_init
In-Reply-To: <200210282356.57410.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210291439100.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 28 Oct 2002, Russell Coker wrote:

> I have attached two patches to this message, one for pty issues and one for a
> bunch of other little things.

Ok, merged.  I also added the open_init_pty script and merged the run_init
patch with appropriate adjustments.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
