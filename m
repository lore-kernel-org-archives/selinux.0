Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27166
	for <selinux@tycho.nsa.gov>; Tue, 17 Sep 2002 09:17:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA27640
	for <selinux@tycho.nsa.gov>; Tue, 17 Sep 2002 13:16:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA27634
	for <selinux@tycho.nsa.gov>; Tue, 17 Sep 2002 13:16:30 GMT
Date: Tue, 17 Sep 2002 09:17:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Washington <rwashington@crucialsecurity.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: http domain
In-Reply-To: <DPEPJAJGOCGHICPODIHPGEFFCBAA.rwashington@crucialsecurity.com>
Message-ID: <Pine.GSO.4.33.0209170915410.11411-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 12 Sep 2002, Ryan Washington wrote:

> Does the standard install of SELinux already have the domain set for http?
> If so, to get it started, all I need to do is to enforce the default policy?

Yes, although you may require some customization of the domain for your
particular setup.  There is an example policy for Apache originally
contributed by MITRE in selinux/policy/domains/program/apache.te.  The
policy is described in a paper available from
http://www.mitre.org/support/papers/tech_papers_01/gosselin_apache/index.shtml.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
