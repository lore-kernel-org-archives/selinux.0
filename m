Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UDhBbo021977
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 09:43:11 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7UDhAAo027841
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 13:43:10 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: audit2allow module generation
Date: Thu, 30 Aug 2007 09:43:10 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010087D1@exchange.columbia.tresys.com>
In-Reply-To: <1181569653.3624.70.camel@helpervm>
From: "Anand Patel" <apatel@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl,

I found that sepol-ifgen parser fails when it sees multiple types in
type declaration statement.
e.g.
	type foo_t, hello_t;
Then I went back and change to following
	type foo_t;
	type hello_t;
and it parsed successfully.

-Anand Patel

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Anand Patel
Sent: Monday, June 11, 2007 9:48 AM
To: Karl MacMillan
Cc: SE Linux; Daniel J Walsh
Subject: RE: audit2allow module generation

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
> > > > So, I installed refpolicy headers first. Then tried
sepolgen-ifgen
> > > >
> > > > %sepolgen-ifgen
> > > > % ... some output ...
> > > > %parsing file /usr/share/selinux/devel/include/services/snmp.if
> > > > %error parsing file
> > /usr/share/selinux/devel/include/services/snmap.if:
> > > > %could not parse text: "Syntax error on line 1 ( [type=OPAREN]"
> > > >
> > > > Parser had problem parsing almost all if files and generated
above
> > > > error.
> > > 
> > > The problem is that the refpolicy "language" is far from fixed and
> > > parsing it cleanly is almost impossible because of M4. So the
parser
> > > sometimes gets out of sync with refpolicy (hence the policyrep
work).
> > > 
> > > I just need some more specific information about the refpolicy
version
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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
