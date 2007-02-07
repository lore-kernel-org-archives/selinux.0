Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17LTnUV003669
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:29:49 -0500
Received: from e34.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17LUso6005733
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 21:30:54 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l17LU9sQ022135
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 16:30:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l17LU9a7436310
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 14:30:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l17LU8Jx020889
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 14:30:09 -0700
Message-ID: <45CA44DE.3060700@us.ibm.com>
Date: Wed, 07 Feb 2007 15:30:06 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS concepts, relational question
References: <20070207211438.8683.qmail@web36605.mail.mud.yahoo.com>
In-Reply-To: <20070207211438.8683.qmail@web36605.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Michael C Thompson <thompsmc@us.ibm.com> wrote:
> 
>> OK, so assume there are two labels:
>> Label A -- s2:c1 - s15:c0.c1023
> 
> This is an SELinux MLS range label. It
> will not fit in the definitions you have
> below because the definitions you have
> are for discrete value labels. 

>> Label B -- s0:c1,c3,c5,...,c1021,c1023 (odd
>> repeating)
>>
>> What is the relationship between A and B?
>>
>> As my understanding goes, and from a definition I
>> found:
>>
>> A dom B, iff:
>> level(A) >= level(B) and cat(A) <super set of>
>> cat(B)
>>
>> A domby B, iff:
>> level(A) <= level(B) and cat(A) <subset of> cat(B)
>>
>> A eq B, iff:
>> level(A) == level(B) and cat(A) == cat(b)
>>
>> A incomp B, iff:
>> cat(A) not <subset of> cat(B) AND
>> cat(B) not <subset of> cat(A)
> 
> 
> The definition I always used for incomp was
> A incomp B if not (A dom B) and not (B dom A)

That makes sense, the source I was getting my definition from only 
included categories... is the above definition widely used?

>> Assuming all of those are accurate, label A does not
>> DOM, DOMBY, or EQ 
>> B, yet they are not INCOMP...
>>
>> Assuming all of the above is true, what do we call
>> this relationship?
> 
> Illegal, except in Sweden?

So then, using Joe's notation:
A(LOW) incomp B
A(HIGH) dom B
A illegal B ? :)

Guess I need to explain what I'm looking for better next time...
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
