Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4CBITRb027795
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2004 07:18:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4CBG85b027375
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2004 11:16:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4CBG8ql027372
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2004 11:16:08 GMT
Subject: RE: presentation results
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
In-Reply-To: <20040511232213.71C383A404E@abyss.simplyaquatics.com>
References: <20040511232213.71C383A404E@abyss.simplyaquatics.com>
Content-Type: text/plain
Message-Id: <1084360700.13073.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 May 2004 07:18:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-11 at 19:22, Ed Street wrote:
> When I covered file/socket/process labels and how the domains worked one
> person ask if this is like how the ntfs forest works.  I wasn't sure how to
> respond so I said yes and no, there are similarities but there's a vast
> amount of differences.

If I understand the question correctly, the answer is no.  TE domains
(an attribute of a process that organizes processes into security
equivalence classes) are completely unrelated and orthogonal to
administrative domains (groups of machines).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
