Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l58FaqId028546
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2007 11:36:52 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l58FapfR004613
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2007 15:36:51 GMT
Subject: RE: audit2allow module generation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Anand Patel <apatel@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF00ED@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF00ED@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 11:36:58 -0400
Message-Id: <1181317018.13633.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:44 -0400, Anand Patel wrote:
> > -----Original Message-----
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > Sent: Tuesday, May 29, 2007 5:12 PM
> > To: Anand Patel
> > Cc: SE Linux; Daniel J Walsh
> > Subject: Re: audit2allow module generation
> > 
> > On Tue, 2007-05-29 at 16:25 -0400, Anand Patel wrote:
> > > I am trying to use audit2allow to generate module out of audit
> messages.
> > >
> > > So, I installed refpolicy headers first. Then tried sepolgen-ifgen
> > >
> > > %sepolgen-ifgen
> > > % ... some output ...
> > > %parsing file /usr/share/selinux/devel/include/services/snmp.if
> > > %error parsing file
> /usr/share/selinux/devel/include/services/snmap.if:
> > > %could not parse text: "Syntax error on line 1 ( [type=OPAREN]"
> > >
> > > Parser had problem parsing almost all if files and generated above
> > > error.
> > 
> > The problem is that the refpolicy "language" is far from fixed and
> > parsing it cleanly is almost impossible because of M4. So the parser
> > sometimes gets out of sync with refpolicy (hence the policyrep work).
> > 
> > I just need some more specific information about the refpolicy version
> > you are using and I should be able to fix-up the parser.
> 
> I was using current release from oss.tresys.com/projects/refpolicy.
> 

What version of sepolgen were you using? The latest (in rawhide) seems
to work fine on the latest available refpolicy.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
