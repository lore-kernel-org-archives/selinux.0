Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA16223
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:51:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA23321
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:50:07 GMT
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.105])
	by jazzswing.ncsc.mil  with ESMTP id SAA23308
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:50:06 GMT
Subject: Re: IBM's Multics paper
To: Russell Coker <russell@coker.com.au>
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>,
        Paul A Karger <pkarger@us.ibm.com>
Message-ID: <OFD70BCFAD.752B81D5-ON85256C30.0066A0E9@us.ibm.com>
From: Trent Jaeger <jaegert@us.ibm.com>
Date: Tue, 10 Sep 2002 14:50:22 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

                                                                                                               
                                                                                                               
                                                                                                               


Last time for this note.

Russell replied:
>That sounds promising to me, but I'm not nearly as qualified as Steve et
al to
>comment on this...

>Also in regard to Steve's comment on the Multics paper, I didn't interpret
it
>as needlessly criticising SE Linux and other similar projects.  There are
>some valid criticisms of the approach we are taking.  Designing a new OS
from
>scratch will give better security.  Also I can understand that if someone
>writes an OS based on their ideas of the best way of doing things then
>naturally they will use it as an example of the way things should be done.

>However I think that the mention of SE Linux did not contain enough detail
for
>a fair comparison.  I think that given the nature of the paper it would
make
>more sense to just discuss the concept of adding security to an existing
Unix
>OS (which applies equally to Trusted Solaris, Trusted BSD, etc).  A good
>supporting point for this is that Sun is apparently going to make Trusted
>Solaris the only Solaris (I am surprised that this was not mentioned in
the
>paper).  This could have been done without judging the implementation of
>Trusted Solaris, but just on the basis that the senior management of Sun
have
>become convinced of some of the views expressed in that paper and backed
>their opinion with some significant investments in technology.

Russell, thanks for your comments.  I should have a quite preliminary
version of my paper in the near future.

I think that the only point of the paper that we can take away (since we
are not going to build a new OS from scratch on this list), is that the MAC
policy of SELinux is much larger than MAC policy of Multics according to
Paul.  It provides greater flexibility, yes, but sysadmins must be able to
verify that their mandatory security criteria are met by the MAC SELinux
policy.

BTW -- the number in the paper is the size of ss_policy for the entire
SELinux example policy.

Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
