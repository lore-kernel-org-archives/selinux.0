Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17LPTPZ003454
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:25:29 -0500
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17LQao6005314
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 21:26:37 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17LQart014682
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:26:36 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l17LQXUG387540
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 14:26:34 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l17LQXgp029399
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 14:26:33 -0700
Message-ID: <45CA4406.2060407@us.ibm.com>
Date: Wed, 07 Feb 2007 15:26:30 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS concepts, relational question
References: <45CA366B.1070801@us.ibm.com> <B4E50D01-92C0-4AC2-BDF6-542A5FE1B810@nall.com>
In-Reply-To: <B4E50D01-92C0-4AC2-BDF6-542A5FE1B810@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> 
> On Feb 7, 2007, at 2:28 PM, Michael C Thompson wrote:
> 
>> OK, so assume there are two labels:
>> Label A -- s2:c1 - s15:c0.c1023
>> Label B -- s0:c1,c3,c5,...,c1021,c1023 (odd repeating)
> 
> 'Label' A is a range of two labels

Ah yes, I failed to clarify what I meant... my interest was in the low 
(active) label.

> 'Label' B is what I think of as a label.
> 
> A(LOW) is incomparable with B
> A(HIGH) dominates B
> 
> Your definition of incomp leaves out the level.

So my source if faulty :)

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
