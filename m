Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA23114
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 07:40:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA04342
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 12:39:27 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id MAA04338
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 12:39:26 GMT
Date: Tue, 27 Nov 2001 07:39:40 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Errors in building lsm-selinux-200111191100.tgz
In-Reply-To: <1006814238.1215.0.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0111270737340.18809-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 26 Nov 2001, Justin Smith wrote:

> kernel panic: policydb version (6) does not match my version (7).

Did you do a 'make install' in the policy directory after installing the
new checkpolicy program (via the 'make install' in the module directory)?
There was a minor change in the policydb format in this release, so you
need to recompile the policy configuration with the new version of the
checkpolicy policy compiler.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
