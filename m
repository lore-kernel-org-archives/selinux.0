Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA27441
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 07:04:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA14918
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 11:03:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA14914
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 11:03:03 GMT
Date: Mon, 26 Aug 2002 07:03:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kernel patches from new release
In-Reply-To: <20020824171643.31517307F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208260653370.10972-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 24 Aug 2002, Russell Coker wrote:

> In the past we have been advised not to use the system calls for determining
> the SID of the process at the other end of a socket due to the code being
> incomplete.
>
> I notice that the new kernel patch for 2.4.19 in the 2002.08.23 release of SE
> Linux appears to have significant improvements in this regard, does this mean
> that we can now rely on the system calls related to socket contexts?  If not
> then what is the exact status of this work?  Can we rely on some of the
> system calls?  If so which ones?

Yes, the peer SID functionality (accept_secure and friends) should now be
reliable, as noted in http://www.nsa.gov/selinux/news.html.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
