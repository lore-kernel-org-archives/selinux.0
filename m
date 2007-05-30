Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UEixFc001881
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 10:45:00 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4UEivuk025760
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 14:44:58 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: audit2allow module generation
Date: Wed, 30 May 2007 10:44:50 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588BF00ED@exchange.columbia.tresys.com>
In-Reply-To: <1180473119.10202.10.camel@localhost.localdomain>
From: "Anand Patel" <apatel@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> Sent: Tuesday, May 29, 2007 5:12 PM
> To: Anand Patel
> Cc: SE Linux; Daniel J Walsh
> Subject: Re: audit2allow module generation
> 
> On Tue, 2007-05-29 at 16:25 -0400, Anand Patel wrote:
> > I am trying to use audit2allow to generate module out of audit
messages.
> >
> > So, I installed refpolicy headers first. Then tried sepolgen-ifgen
> >
> > %sepolgen-ifgen
> > % ... some output ...
> > %parsing file /usr/share/selinux/devel/include/services/snmp.if
> > %error parsing file
/usr/share/selinux/devel/include/services/snmap.if:
> > %could not parse text: "Syntax error on line 1 ( [type=OPAREN]"
> >
> > Parser had problem parsing almost all if files and generated above
> > error.
> 
> The problem is that the refpolicy "language" is far from fixed and
> parsing it cleanly is almost impossible because of M4. So the parser
> sometimes gets out of sync with refpolicy (hence the policyrep work).
> 
> I just need some more specific information about the refpolicy version
> you are using and I should be able to fix-up the parser.

I was using current release from oss.tresys.com/projects/refpolicy.

So, every new version of refpolicy will require tweaks to audit2allow
parser. What tweaks does it require? Where does it fail? Can you give me
some insight of how parser works?

Thanks,


> 
> Thanks - Karl
> 
> > It would been helpful if error included correct line number.
> > Is it parser bug?
> > Am I doing anything wrong?
> > Is there any documentation available on how to use this policy
> > generation tools?
> > What are the dependencies these tools have?
> >
> >
> > Thanks,
> >
> > Anand Patel
> > Tresys Technology
> > apatel@tresys.com
> > 410-290-1411xt153
> >
> >
Anand Patel
Tresys Technology
apatel@tresys.com
410-290-1411xt153


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
