Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17L6gLg002711
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:06:42 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l17L7no6002171
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 21:07:49 GMT
In-Reply-To: <45CA366B.1070801@us.ibm.com>
References: <45CA366B.1070801@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B4E50D01-92C0-4AC2-BDF6-542A5FE1B810@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Re: MLS concepts, relational question
Date: Wed, 7 Feb 2007 15:07:14 -0600
To: Michael C Thompson <thompsmc@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 7, 2007, at 2:28 PM, Michael C Thompson wrote:

> OK, so assume there are two labels:
> Label A -- s2:c1 - s15:c0.c1023
> Label B -- s0:c1,c3,c5,...,c1021,c1023 (odd repeating)

'Label' A is a range of two labels
'Label' B is what I think of as a label.

A(LOW) is incomparable with B
A(HIGH) dominates B

Your definition of incomp leaves out the level.

joe

>
> What is the relationship between A and B?
>
> As my understanding goes, and from a definition I found:
>
> A dom B, iff:
> level(A) >= level(B) and cat(A) <super set of> cat(B)
>
> A domby B, iff:
> level(A) <= level(B) and cat(A) <subset of> cat(B)
>
> A eq B, iff:
> level(A) == level(B) and cat(A) == cat(b)
>
> A incomp B, iff:
> cat(A) not <subset of> cat(B) AND
> cat(B) not <subset of> cat(A)
>
> Assuming all of those are accurate, label A does not DOM, DOMBY, or  
> EQ B, yet they are not INCOMP...
>
> Assuming all of the above is true, what do we call this relationship?
>
> Thanks,
> Mike
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to  
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
