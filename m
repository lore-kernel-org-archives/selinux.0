MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: How should I run genfscon in my module?
Date: Wed, 1 Nov 2006 10:27:59 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158851492D@exchange.columbia.tresys.com>
In-Reply-To: <1162394514.29617.5.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Dawid Gajownik" <gajownik@gmail.com>, <fedora-selinux-list@redhat.com>,
        "SELinux List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> > > I looked at fixing this by changing genfscon to use 
> user_identifier 
> > > instead of identifier (they are the same except user_identifier 
> > > includes "-"). This made checkpolicy generate a syntax 
> error for all 
> > > genfscon statements - haven't tracked down what the 
> problem is. The 
> > > grammer still seems to be unambiguous.
> > 
> > Use "user_id" instead.  Otherwise, you'll get a syntax 
> error when the 
> > token is classified as an IDENTIFIER (first match) and the grammar 
> > says that it must be a USER_IDENTIFIER.
> 
> Right as usual.
> 

Maybe make user_id more generic as it is no longer only used for users..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
