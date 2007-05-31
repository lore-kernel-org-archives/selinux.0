Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VG5kk8016171
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 12:05:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VG5jdA020532
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 16:05:45 GMT
Subject: RE: audit2allow module generation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Anand Patel <apatel@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF00ED@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF00ED@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 12:05:42 -0400
Message-Id: <1180627542.3534.41.camel@localhost.localdomain>
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

Ok - Chris, any chance you can start running sepolgen-ifgen on refpolicy
and alerting me to breakage?

> So, every new version of refpolicy will require tweaks to audit2allow
> parser.

No - only when the refpolicy "language" changes (or there is just a new
M4 usage, etc). Basically - I'm trying to parse an informal language
based on M4 which is a pain.

>  What tweaks does it require? Where does it fail? Can you give me
> some insight of how parser works?
> 

See refparser.py in sepolgen.

Karl

> Thanks,
> 
> 
> > 
> > Thanks - Karl
> > 
> > > It would been helpful if error included correct line number.
> > > Is it parser bug?
> > > Am I doing anything wrong?
> > > Is there any documentation available on how to use this policy
> > > generation tools?
> > > What are the dependencies these tools have?
> > >
> > >
> > > Thanks,
> > >
> > > Anand Patel
> > > Tresys Technology
> > > apatel@tresys.com
> > > 410-290-1411xt153
> > >
> > >
> Anand Patel
> Tresys Technology
> apatel@tresys.com
> 410-290-1411xt153


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
