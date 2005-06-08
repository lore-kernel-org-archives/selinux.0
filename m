Message-Id: <200506081238.j58CcE5F028703@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'NSA Selinux Mailinglist'" <selinux@tycho.nsa.gov>,
   "'Chad Hanson'" <chanson@tcs-sec.com>
Subject: RE: couple validatetrans questions
Date: Wed, 8 Jun 2005 08:38:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118232410.26902.23.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> A trivial code change to make assuming there hasn't been extensive
>> use of validatetrans/mlsvalidatetrans. Until then I guess I'll just
>> have to work harder at explaining the subtle difference.
> 
> Not clear that this is justified, and would require a coordinated
> kernel change. 

I too am unsure that the change is justified (I know it would have been
easier if I caught it earlier). Just so you know, it became obvious when
writing a chapter on constraints and trying to make a single table for all
operators and their possible arguments, that I could not simply use the same
table for constrain and validatetrans statements since the semantic meaning
for t1 changed between the two. That's the conceptual barrier to
understanding I mentioned.

Nonetheless I agree with the philosophy to not change a semantic unless
there is a compelling reason and I'm not sure there is one. It'll just make
my chapter longer ;-) 

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
