Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OK9IRb025724
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 15:09:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OK7QlM009670
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:07:43 GMT
Subject: Re: [selinux] Re: identity
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1077634629.21221.80.camel@moss-spartans.epoch.ncsc.mil>
References: 
	<Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
	<1077634629.21221.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-2
Date: 24 Feb 2004 21:03:52 +0100
Message-Id: <1077653032.22405.36.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I tend to view "auditing framework" as a subset of "security framework",
and think that separating access control and audit is either unfeasible
or impossible, given that most of the stuff to be audited is access
control decision. Plus the access control logic can benefit from the
additional data which should be available for auditing purposes.
First it is a PITA that one have to dig out file name or IP address,
but you will soon realise that you can do access control decisions
based the data just mined out if you want.

On the other hand, there are some data (those which have to be used
for access control decisions) which should be dug out twice if you
want to separate auditing from access control.

And on the third hand:
Just tell me that FAU_GEN is not an aim of SELinux, and I will forget
the project forever.

2004-02-24, k keltezéssel Stephen Smalley ezt írta:

> > How would the kernel know the IP address you're logged in from?  Would you 
> > also want to log the serial device if that's how the user logged in?
> 
> I tend to view this discussion as more appropriate for an auditing
> framework rather than SELinux. 

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
