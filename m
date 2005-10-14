Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9E7M8Ns003609
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 03:22:08 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9E7KHTX011479
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 07:20:17 GMT
Message-ID: <434F5E8C.1050708@cornell.edu>
Date: Fri, 14 Oct 2005 03:30:20 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>
Subject: Record keys
References: <434F5E3A.5030003@cornell.edu>
In-Reply-To: <434F5E3A.5030003@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(resent with correct list address this time)
> Please help me decide what to do with the record key for the record 
> structures which I've added into libsepol and libsemanage. Stephen has 
> now exported those functions into the shared library, so after an 
> official release, it would be good not to be changing those APIs.
>
> The job of the key is to identify a record uniquely among a collection 
> of the same record type.
> They do this by the record.compare(key) function. Currently the key is 
> required to be a subset of the record fields (so it has to be 
> contained within the record...does that make it useless? could this 
> change in the future, and how?)
>
> ================
> I added the key structure, because it just seemed wrong to pass an 
> "incomplete" record structure containing just the key fields 
> into..say...a query() handler. Note that the key constructor forces 
> the caller to specify all the fields (since this is a key, all fields 
> are required), while splitting this up into set calls to a record 
> structure could result in invalid keys.
>
> Currently keys are contained _within_ the record - they're a subset of 
> the record's fields. That's the primary reason why I ask whether keys 
> should be kept or not - a method called extract_key is supported....If 
> the key can be extracted from the record, you can use that on 
> modify(), and add() to pass a single argument (the record). That also 
> makes it easier for the caller (specify key fields in only one place, 
> instead of both in key and record). It's easy to just add the record, 
> but then the API just *looks* wrong..  also that prevents use of keys 
> that are not contained within the record in the future... but I'm not 
> clear as to whether this will ever change.
>
> If such "external" keys are to be used, then the extract_key method 
> can't be used (but there's nothing to require this method
> for each record - it's just expected internally to be implemented - 
> internals can easily change to fit what's required). Basically, I'm 
> trying to imagine a scenario where the key would not be contained 
> within the record, and what would be required to support that.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
