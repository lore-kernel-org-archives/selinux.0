Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2DVjXZ005139
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 08:31:46 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2DVjAw016848
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 13:31:45 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, <selinux@tycho.nsa.gov>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Subject: RE: dynamic context transitions
Date: Tue, 2 Nov 2004 08:31:44 -0500
Message-ID: <00b601c4c0e0$4c637410$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <36282A1733C57546BE392885C06185924D91CE@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> Let me try another approach.  We're in the process of designing
>> language extensions that will be part of a policy management service
>> (building upon the binary module work that Karl should release later
>> tonight). One aspect of these extension will introduce a name
>> hierarchy  for types. Implicit in this hierarchy is the idea that a
>> subordinate type cannot exceed the access privileges of any of its
>> higher types.  For example, take types 'foo' and 'foo.bar' ("."
>> represents a hierarchy).  In this case, what we're planning (so far)
>> is that the type foo.bar can have the same or less, but not more,
>> access permission than the type foo in the policy.  There are many
>> reasons why such a semantic is useful. 
>> 
>> So if we had such a semantic implemented and enforced now, I would
>> feel a lot better if the type can only decrease down the hierarchy,
>> and never laterally or up the hierarchy.  Would this meet the need? 
>> This would certainly be more defensible in my mind [I know this is
>> somewhat hypothetical since the language extension does not yet
>> exist, and will be some time in coming]. 
> 
> This is one way a domain transitions could occur. I wouldn't want to
> prevent the ability to go up the heirarchy. In this example, a
> privilege bracketed program could start out in foo.unpriv transition
> back and forth a few times to foo and then transition to foo.unpriv'.
> foo.unpriv' is unable to transition to foo or foo.unpriv. foo.unpriv'
> could transition to foo.foo'. In a traditional privilege bracketed
> application you'll want to run in the subordinate domain most of the
> time. 

Even if we allowed changes up and down, this "feels" like a better approach.
There would have to be some means of defining the brackets allowed for a context
change (how far up and down), much as in Multics ring brackets.  As an
evaluator, for a given domain I would only ever look at the top of the bracket
to analyze the security trustedness of a type domain.  The sub-types would just
be discretionary "safety" domains used to help a program from doing something
unintentional, and not a real impact on the process' privilege (as with
privilege bracketing).  But the implicit constraints on the privileges of
sub-types, enforced by the compiler (probably) gives me more confidence that the
mechanism won't be abused in poor, arbitrary ways, and tranquility would largely
be preserved.

Frank




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
