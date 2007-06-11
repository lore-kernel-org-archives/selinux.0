Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BDm5gQ014751
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 09:48:05 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BDlwQ2008376
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 13:47:59 GMT
Subject: RE: audit2allow module generation
From: Anand Patel <apatel@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1181317018.13633.4.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF00ED@exchange.columbia.tresys.com>
	 <1181317018.13633.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 09:47:33 -0400
Message-Id: <1181569653.3624.70.camel@helpervm>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-08 at 11:36 -0400, Karl MacMillan wrote:
> On Wed, 2007-05-30 at 10:44 -0400, Anand Patel wrote:
> > > -----Original Message-----
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > > Sent: Tuesday, May 29, 2007 5:12 PM
> > > To: Anand Patel
> > > Cc: SE Linux; Daniel J Walsh
> > > Subject: Re: audit2allow module generation
> > > 
> > > On Tue, 2007-05-29 at 16:25 -0400, Anand Patel wrote:
> > > > I am trying to use audit2allow to generate module out of audit
> > messages.
> > > >
> > > > So, I installed refpolicy headers first. Then tried sepolgen-ifgen
> > > >
> > > > %sepolgen-ifgen
> > > > % ... some output ...
> > > > %parsing file /usr/share/selinux/devel/include/services/snmp.if
> > > > %error parsing file
> > /usr/share/selinux/devel/include/services/snmap.if:
> > > > %could not parse text: "Syntax error on line 1 ( [type=OPAREN]"
> > > >
> > > > Parser had problem parsing almost all if files and generated above
> > > > error.
> > > 
> > > The problem is that the refpolicy "language" is far from fixed and
> > > parsing it cleanly is almost impossible because of M4. So the parser
> > > sometimes gets out of sync with refpolicy (hence the policyrep work).
> > > 
> > > I just need some more specific information about the refpolicy version
> > > you are using and I should be able to fix-up the parser.
> > 
> > I was using current release from oss.tresys.com/projects/refpolicy.
> > 
> 
> What version of sepolgen were you using? The latest (in rawhide) seems
> to work fine on the latest available refpolicy.
Version .1
It seems to work with pristine refpolicy. However, upon modifications to
policy, new macros and moduels, it generates error during interface
index parse.

I am currently investigating where it fails.


> 
> Karl
> 
> 
> 


-- 
Anand Patel
apatel@tresys.com
410-290-1411xt153

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
