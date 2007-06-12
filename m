Message-ID: <D709A20F2164C84E8B7014B0301F5EF81BFA3B@HAVOC.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: RE: [RFC][PATCH] selinux:  enable authoritative granting of capab
	ilities
Date: Tue, 12 Jun 2007 09:36:08 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
I agree as well. I like the fact you don't need to have a SUID application
to generate an audit record, when an uid transition isn't needed.

-Chad

> 
> On Mon, 11 Jun 2007, Stephen Smalley wrote:
> 
> > Extend SELinux to allow capabilities to be granted authoritatively.
> > Introduces a new cap_override access vector to indicate when the 
> > secondary module (i.e. capability or dummy) check should be skipped.
> > Handle the new class gracefully even if the policy does not 
> yet have 
> > it defined.
> 
> Looks good to me.
> 
> --
> James Morris
> <jmorris@namei.org>
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
