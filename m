Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17KRQMk001082
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 15:27:26 -0500
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17KSVf5026173
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 20:28:32 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17KSV5U024835
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 15:28:31 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l17KSVqr405098
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 13:28:31 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l17KSU7m007959
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 13:28:30 -0700
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.62.131])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l17KSTWl007800
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 13:28:30 -0700
Message-ID: <45CA366B.1070801@us.ibm.com>
Date: Wed, 07 Feb 2007 14:28:27 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: MLS concepts, relational question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

OK, so assume there are two labels:
Label A -- s2:c1 - s15:c0.c1023
Label B -- s0:c1,c3,c5,...,c1021,c1023 (odd repeating)

What is the relationship between A and B?

As my understanding goes, and from a definition I found:

A dom B, iff:
level(A) >= level(B) and cat(A) <super set of> cat(B)

A domby B, iff:
level(A) <= level(B) and cat(A) <subset of> cat(B)

A eq B, iff:
level(A) == level(B) and cat(A) == cat(b)

A incomp B, iff:
cat(A) not <subset of> cat(B) AND
cat(B) not <subset of> cat(A)

Assuming all of those are accurate, label A does not DOM, DOMBY, or EQ 
B, yet they are not INCOMP...

Assuming all of the above is true, what do we call this relationship?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
