Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA8JOuGP022693
	for <selinux@tycho.nsa.gov>; Sun, 8 Nov 2009 14:24:56 -0500
Received: from mailhub249.itcs.purdue.edu (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nA8JNu89000823
	for <selinux@tycho.nsa.gov>; Sun, 8 Nov 2009 19:23:56 GMT
Received: from jacques-thomass-macbook-pro-17.local (c-98-228-29-202.hsd1.in.comcast.net [98.228.29.202])
	(authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.14.2/8.14.2/smtp-auth.purdue.edu) with ESMTP id nA8JOsYP023320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 8 Nov 2009 14:24:54 -0500
Message-ID: <4AF71B05.8030707@cs.purdue.edu>
Date: Sun, 08 Nov 2009 14:24:53 -0500
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Type boundaries: questions on the semantics / is the enforcement
 correct ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I am trying to document the semantics of bounded types, and I am puzzled 
by two things:


1/ The rationale for type boundaries on *target* types
I understand type boundaries on source types: the idea is that, if typeA 
is bounded by typeB, then typeA can not exert more permissions than 
typeB. This would be declared with the following statement in the source 
policy:
TYPEBOUND typeB typeA

What is a good use case for type boundaries on target types ?


2/ The logic of type_attribute_bounds_av in ss/services.c (kernel side)
This method is invoked to filter/limit an access vector according to the 
type boundaries. Its logic goes as follows:

if(source type has a bound){  // SOURCE
    ../..
    if(the bound is not violated)
        return
    ../..
}

if(target type has a bound){  // TARGET
    ../..
    if(the bound is not violated)
       return
    ../..
}

if(target and source types have a bound){ // BOTH
    ../..
    if(these bounds are not violated)
       return
    ../..
}

if(there was a violation){
    send audit message to user space
}

The early return statements seem to violate the intent of the code. For 
instance, suppose that the source type is bounded and no access bits 
violates these bounds, then the code will never evaluate whether bounds 
on the target type are violated.

It seems to me that the logic should be:

// BOTH
else // SOURCE
else // TARGET

Instead of:

// SOURCE
// TARGET
// BOTH

I am looking forward to your replies.

Best,
Jacques

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
