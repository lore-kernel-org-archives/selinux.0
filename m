Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00815
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 08:22:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA23572
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 12:21:29 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA23568
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 12:21:29 GMT
Date: Mon, 23 Sep 2002 08:22:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Michael Zimmermann <zim@vegaa.de>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SElinux newbie seeks starter paper(s)
In-Reply-To: <200209222212.18437.zim@vegaa.de>
Message-ID: <Pine.GSO.4.33.0209230816010.9579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 22 Sep 2002, Michael Zimmermann wrote:

> as a SElinux newbie I'm feeling a little bit lost with
> those rather technical papers in the SElinux documentation.
>
> Are there some starter docs available?

Not really.  I would recommend skimming through the two published papers
available from http://www.nsa.gov/selinux/docs.html, and skimming through
the Configuring the SELinux Policy report available both from that page
and in the SELinux archive (selinux/doc/policy).  Tresys Technology has
written a few policy whitepapers, available from their site
http://www.tresys.com/selinux, but I think that they were based on an
older release of SELinux, and haven't tracked more recent developments.

We would welcome contributions of HOWTO-style documents.  In creating such
documents, please don't start from scratch; you should be able to leverage
some of the content of the existing papers and reports.  The published
papers and older technical reports were originally written in LaTeX, and
the newer technical reports were written in DocBook.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
