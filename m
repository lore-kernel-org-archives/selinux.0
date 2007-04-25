Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PG1AcG031729
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 12:01:10 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PG15wY004400
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 16:01:05 GMT
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588B4043E@exchange.columbia.tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213721.090230000@tresys.com>
	 <1177444855.10744.25.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com>
	 <1177476585.3428.91.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71B39@exchange.columbia.tresys.com>
	 <1177514210.3428.117.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B40435@exchange.columbia.tresys.com>
	 <1177515622.3428.126.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B4043E@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 12:00:53 -0400
Message-Id: <1177516853.3428.131.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 11:52 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 

<snip>

> > > 
> > > How do you suppose we should serialize variables that are normally 
> > > size_t then? For example, a policy module is essentially a 
> > file that 
> > > gets sent across and has a length of size_t, all the policy module 
> > > functions (eg., sepol_load_policy, etc) use a size_t so we have to 
> > > serialize it and unserialize it in some way.
> > > 
> > 
> > You define the size as uint64_t or uint32_t and check for 
> > overflow everywhere you convert from size_t (or long for 
> > things like fseek).
> > 
> 
> *sigh* I must not be making myself clear. That's what we are doing.

No - it is about where you are doing the checking. This doesn't belong
in the generic layer because it obscures what the problem is. It belongs
at the call site that interprets the fields.

Offering to serialize size_t is not a good interface - it makes it look
like you are actually handling the problem when you are not. By forcing
all of the serialized data into fixed-width types you are bringing the
problem to the foreground.

That way the representation is always clear and valid and good error
messages can be generated.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
