Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m37NHKmx003711
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 19:17:20 -0400
Received: from QMTA06.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m37NHJZK017726
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 23:17:19 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH 0/2] Labeled networking tweaks for 2.6.26
To: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Mon, 07 Apr 2008 19:16:23 -0400
Message-ID: <20080407231143.8087.77531.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Pretty small pile of patches (are two patches even a pile) this time around,
but they should make things a little faster.  The first patch addresses a
gripe Casey had about an extra allocation/copy for the NetLabel secattr and
the second tries to address the Labeled IPsec stack ugliness pointed out by
Jamal and Dave.

I'm posting these as RFC patches for right now because I haven't had a chance
to really beat on these changes, however, with 2.6.26 getting close I wanted
to get these out so people could start looking at them.  Casey, Jamal, would
you mind checking these changes out in your respective configurations?

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
