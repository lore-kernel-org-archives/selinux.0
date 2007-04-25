Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PGPITx001164
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 12:25:18 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3PGPHYP017141
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 16:25:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
Date: Wed, 25 Apr 2007 12:25:15 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588B4044B@exchange.columbia.tresys.com>
In-Reply-To: <1177516853.3428.131.camel@localhost.localdomain>
References: <20070423213455.741326000@tresys.com> <20070423213721.090230000@tresys.com> <1177444855.10744.25.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com> <1177476585.3428.91.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588A71B39@exchange.columbia.tresys.com> <1177514210.3428.117.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588B40435@exchange.columbia.tresys.com> <1177515622.3428.126.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588B4043E@exchange.columbia.tresys.com> <1177516853.3428.131.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Wed, 2007-04-25 at 11:52 -0400, Joshua Brindle wrote:
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> 
> <snip>
> 
> > > > 
> > > > How do you suppose we should serialize variables that 
> are normally 
> > > > size_t then? For example, a policy module is essentially a
> > > file that
> > > > gets sent across and has a length of size_t, all the 
> policy module 
> > > > functions (eg., sepol_load_policy, etc) use a size_t so 
> we have to 
> > > > serialize it and unserialize it in some way.
> > > > 
> > > 
> > > You define the size as uint64_t or uint32_t and check for 
> overflow 
> > > everywhere you convert from size_t (or long for things 
> like fseek).
> > > 
> > 
> > *sigh* I must not be making myself clear. That's what we are doing.
> 
> No - it is about where you are doing the checking. This 
> doesn't belong in the generic layer because it obscures what 
> the problem is. It belongs at the call site that interprets 
> the fields.
> 
> Offering to serialize size_t is not a good interface - it 
> makes it look like you are actually handling the problem when 
> you are not. By forcing all of the serialized data into 
> fixed-width types you are bringing the problem to the foreground.
> 
> That way the representation is always clear and valid and 
> good error messages can be generated.
> 

So move boiler plate casting and checking to the call site? I guess we
can do that... :\


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
