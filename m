Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1LXvXZ000731
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:33:58 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1LWZCE007993
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 21:32:37 GMT
Message-ID: <36282A1733C57546BE392885C06185924D91CE@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Frank Mayer <mayerf@tresys.com>, Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Subject: RE: dynamic context transitions
Date: Mon, 1 Nov 2004 16:33:47 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Frank Mayer wrote:
> > The addition of a dynamic transition
> > provides an extra ability, only when necessary, to tighten the
> > security of a process.
> 
> Let me try another approach.  We're in the process of 
> designing language
> extensions that will be part of a policy management service 
> (building upon the
> binary module work that Karl should release later tonight).  
> One aspect of these
> extension will introduce a name hierarchy  for types.  
> Implicit in this
> hierarchy is the idea that a subordinate type cannot exceed the access
> privileges of any of its higher types.  For example, take 
> types 'foo' and
> 'foo.bar' ("." represents a hierarchy).  In this case, what 
> we're planning (so
> far) is that the type foo.bar can have the same or less, but 
> not more, access
> permission than the type foo in the policy.  There are many 
> reasons why such a
> semantic is useful.  
> 
> So if we had such a semantic implemented and enforced now, I 
> would feel a lot
> better if the type can only decrease down the hierarchy, and 
> never laterally or
> up the hierarchy.  Would this meet the need?  This would 
> certainly be more
> defensible in my mind [I know this is somewhat hypothetical 
> since the language
> extension does not yet exist, and will be some time in coming].
> 

This is one way a domain transitions could occur. I wouldn't want to prevent
the ability to go up the heirarchy. In this example, a privilege bracketed
program could start out in foo.unpriv transition back and forth a few times
to foo and then transition to foo.unpriv'.  foo.unpriv' is unable to
transition to foo or foo.unpriv. foo.unpriv' could transition to foo.foo'.
In a traditional privilege bracketed application you'll want to run in the
subordinate domain most of the time.

-Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
