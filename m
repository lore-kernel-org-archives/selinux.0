Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA22220
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 10:25:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA17842
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 14:24:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA17838
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 14:24:08 GMT
Date: Wed, 4 Sep 2002 10:24:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Magnus Johansson <magnusj@it.uu.se>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Buildproblems
In-Reply-To: <200209041601.07772.magnusj@it.uu.se>
Message-ID: <Pine.GSO.4.33.0209041022160.18204-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 4 Sep 2002, Magnus Johansson wrote:

> I just tried to build the latest tarball, but ran into problems compiling
> 'more'. However, I found both the problem and the solution in the
> mailinglist archive from January. I just want to point out that the problem
> still exists in the current tar-ball (lsm-2.4-selinux-2002082308.tgz).

This is only an issue if you don't have libtermcap installed on your
system (in which case the configure script will fall back to using
libcurses).  In any event, this is an issue with the base util-linux
package, not in the SELinux patch to it.  Builds fine for us on RH7.1 and
RH7.2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
