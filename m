Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08239
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 12:01:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA16182
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 16:00:47 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA16178
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 16:00:46 GMT
Date: Tue, 10 Apr 2001 12:00:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Joey Mitchell Comeau <aw096@chebucto.ns.ca>
cc: selinux@tycho.nsa.gov
Subject: Re: build-apps trouble.
In-Reply-To: <Pine.GSO.3.95.iB1.0.1010409232809.13843A-100000@halifax.chebucto.ns.ca>
Message-ID: <Pine.SOL.3.95.1010410115545.27235F-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


If you only have 'spasswd' and 'newrole' in slinux/utils, then
you don't have a complete release.  You can either download
the one large archive with everything or you can individually
download the support files archives plus the individual
modified packages (as a patch or a complete archive).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



On Mon, 9 Apr 2001, Joey Mitchell Comeau wrote:

> I'm working through the installation of selinux and the build-apps tool is
> quitting with 
> stat*: no match. 
> 
> I looked in utils and there are no directories that start with stat, only
> spasswd and newrole


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
