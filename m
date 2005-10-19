Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9JGgbNs021283
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 12:42:37 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9JGdpjJ012127
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 16:39:51 GMT
Message-ID: <43567968.6020803@cornell.edu>
Date: Wed, 19 Oct 2005 12:50:48 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Record keys
References: <434F5E3A.5030003@cornell.edu> <434F5E8C.1050708@cornell.edu> <4356520D.7050603@tresys.com>
In-Reply-To: <4356520D.7050603@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I can't think of any time a key wouldn't be within the record. I don't 
> know what the problem is though, the record will always be serialized 
> some way into a flat text file
You keep keep referring to the problem I'm trying to solve as 
parsing/writing a flat text file. Please realize that records are 
supposed to be backend-independent data structures. In particular, I 
currently use them for transfer with a flat file, or a policydb object. 
I am hoping you can use them over the wire for the policy server... 
so..no, the record will not always go in a text file.

I understand the serialization argument...
There's the same problem with policy - the key is a bunch of primitives 
that need to be assembled together (and disassembled).
> so you have to key_extract either way, if you keep a key around you do 
> it once on read, if you don't you do it anytime there is a query, set, 
> etc, it seems better to do it once.
Sepol doesn't have much use for the key structure - it's mostly to 
benefit semanage polymorphism. Sepol would just disassembles the key 
back into its components to do a query. I need to add a function to do 
that, since currently the key is opaque.

Also, if the key is separate from the record, the user can do something 
stupid, like add a record with a mismatch key.
=======

Anyway, there's no significant problem here - either way is fine. I'm 
just trying to finalize the API.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
