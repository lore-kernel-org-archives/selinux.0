Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA24981
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 15:58:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA11876
	for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 19:57:03 GMT
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.102])
        by jazzband.ncsc.mil  with ESMTP id TAA11870 for <selinux@tycho.nsa.gov>; Wed, 4 Sep 2002 19:57:02 GMT
Subject: Re: Buildproblems
To: Stephen Smalley <sds@tislabs.com>
Cc: Magnus Johansson <magnusj@it.uu.se>, <selinux@tycho.nsa.gov>
Message-ID: <OF18B3CFD4.46DA5256-ON85256C2A.006B8ABD@us.ibm.com>
From: Trent Jaeger <jaegert@us.ibm.com>
Date: Wed, 4 Sep 2002 15:58:30 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

                                                                                                               
                                                                                                               
                                                                                                               


Hi,

So you are saying that if libtermcap is not installed, then configure uses
libcurses.  This doesn't seem to have been my (or Magnus') case -- if so,
it would have worked, right?

As best I can recall, I had neither libtermcap or libcurses installed on my
machine, so I assume that configure guessed libtermcap.  At some point
before building 'more', I installed libcurses (hence the motivation for the
change).

configure looks like it will complain if libcurses is not there, so maybe I
missed it...  Other than complaining louder (brighter), not much can be
done.

Regards,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595



Stephen Smalley <sds@tislabs.com>@tycho.nsa.gov on 09/04/2002 10:24:51 AM

Sent by:    owner-selinux@tycho.nsa.gov


To:    Magnus Johansson <magnusj@it.uu.se>
cc:    <selinux@tycho.nsa.gov>
Subject:    Re: Buildproblems




On Wed, 4 Sep 2002, Magnus Johansson wrote:

> I just tried to build the latest tarball, but ran into problems compiling
> 'more'. However, I found both the problem and the solution in the
> mailinglist archive from January. I just want to point out that the
problem
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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
 the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
