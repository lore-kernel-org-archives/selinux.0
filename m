Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PFra4a031129
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 11:53:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3PFrYwY002695
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 15:53:34 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
Date: Wed, 25 Apr 2007 11:52:16 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588B4043E@exchange.columbia.tresys.com>
In-Reply-To: <1177515622.3428.126.camel@localhost.localdomain>
References: <20070423213455.741326000@tresys.com> <20070423213721.090230000@tresys.com> <1177444855.10744.25.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com> <1177476585.3428.91.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588A71B39@exchange.columbia.tresys.com> <1177514210.3428.117.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588B40435@exchange.columbia.tresys.com> <1177515622.3428.126.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Wed, 2007-04-25 at 11:21 -0400, Joshua Brindle wrote:
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > > 
> > > On Wed, 2007-04-25 at 10:14 -0400, Joshua Brindle wrote:
> > > > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > > 
> > > <snip>
> > > 
> > > > > > 
> > > > > > SEPOL_SERIAL_SIZE_T is always 64 bits. We should be
> > > checking if it
> > > > > > tries to serialize into a smaller type, if not that's a bug.
> > > > > > 
> > > > > 
> > > > > How can that be? On a 64bit platform I can represent 
> a size that 
> > > > > can't be represented by a 32bit size_t. How can I
> > > transfer this data
> > > > > to a 32bit system? I can't put it in a data structure
> > > with size_t -
> > > > > it would have to be unint64_t.
> > > > > So why not just use that?
> > > > > 
> > > > 
> > > > That's why I said "We should be checking if it tries to
> > > serialize into
> > > > a smaller type, if not that's a bug"
> > > > 
> > > > IIRC we needed something that could 
> serialize/unserialize size_t 
> > > > because its used in some components that we serialize. We
> > > could always
> > > > cast to uint64_t and serialize it that way (which is pretty
> > > much what
> > > > we are doing anyway).
> > > > 
> > > 
> > > Something is going wrong in our communication here. You _cannot_ 
> > > reliably transfer size_t from a 64bit system to a 32bit system 
> > > (assuming that size_t is 64 and 32 bits respectively). That means 
> > > that you cannot reliably serialize data structures that 
> use size_t - 
> > > you must change the data structures. Otherwise the 
> serialized data 
> > > will not be valid on all systems.
> > > 
> > > There is no way to check "if it tries to serialize into a smaller 
> > > type"
> > > - you will always hit this condition at some point.
> > > 
> > > As for the size, C99 says:
> > > 
> > > "The value of the result [of sizeof] is 
> implementation-defined, and 
> > > its type (an unsigned integer
> > > type) is size_t,"
> > > 
> > > Later it says:
> > > 
> > > "The types used for size_t and ptrdiff_t should not have 
> an integer 
> > > conversion rank greater than that of signed long int unless the 
> > > implementation supports objects large enough to make this 
> > > necessary."
> > > 
> > > I read that to say that the width of size_t is implementation 
> > > defined and could be larger that 64 bits.
> > 
> > How do you suppose we should serialize variables that are normally 
> > size_t then? For example, a policy module is essentially a 
> file that 
> > gets sent across and has a length of size_t, all the policy module 
> > functions (eg., sepol_load_policy, etc) use a size_t so we have to 
> > serialize it and unserialize it in some way.
> > 
> 
> You define the size as uint64_t or uint32_t and check for 
> overflow everywhere you convert from size_t (or long for 
> things like fseek).
> 

*sigh* I must not be making myself clear. That's what we are doing.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
