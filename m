Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LDGGrT000887
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 09:16:16 -0400 (EDT)
Received: from mail.idtweb.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5LDG4Ng013583
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 13:16:04 GMT
Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Joshua D. Guttman disp: slinux'" <guttman@mitre.org>
Cc: "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>, <selinux@tycho.nsa.gov>,
   "'Amy L Herzog'" <aherzog@mitre.org>
Subject: RE: Fedora Core 2 setools RPM
Date: Mon, 21 Jun 2004 09:16:13 -0400
Message-ID: <004101c45791$ed8d2060$4d0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1087589345.27697.195.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> A different point is that the main value added of slat is much more
>> expressive security goals (even when restricted to the types info).
>> You're not just talking about accessibility of a type to information
>> flow from another, but also whether all the possible flows go through
>> a desired gate type.  And the key fact you mentioned at the end of
>> your last message
> 
> I may be wrong, but I think that you can determine this information
> via libapol as well.

Yes a transitive information flow analysis is what makes this difficult, both to
do and for a human to understand.  Libapol has supported a form of transitive
information flow analysis from the beginning of its information flow support.
It has evolved somewhat, and now has significant filtering capabilities as
discussed in the tool help.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
