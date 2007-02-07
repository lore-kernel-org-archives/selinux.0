Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17LDkLu002959
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:13:46 -0500
Received: from web36605.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l17LErf5006385
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 21:14:53 GMT
Message-ID: <20070207211438.8683.qmail@web36605.mail.mud.yahoo.com>
Date: Wed, 7 Feb 2007 13:14:38 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: MLS concepts, relational question
To: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45CA366B.1070801@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Michael C Thompson <thompsmc@us.ibm.com> wrote:

> OK, so assume there are two labels:
> Label A -- s2:c1 - s15:c0.c1023

This is an SELinux MLS range label. It
will not fit in the definitions you have
below because the definitions you have
are for discrete value labels. 

> Label B -- s0:c1,c3,c5,...,c1021,c1023 (odd
> repeating)
> 
> What is the relationship between A and B?
> 
> As my understanding goes, and from a definition I
> found:
> 
> A dom B, iff:
> level(A) >= level(B) and cat(A) <super set of>
> cat(B)
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


The definition I always used for incomp was
A incomp B if not (A dom B) and not (B dom A)

> Assuming all of those are accurate, label A does not
> DOM, DOMBY, or EQ 
> B, yet they are not INCOMP...
> 
> Assuming all of the above is true, what do we call
> this relationship?

Illegal, except in Sweden?

I don't know that it makes sense to apply
descrete label terminology to vector label
values.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
