MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Audit2allow + allow rule for 'granted' access
Date: Mon, 7 Apr 2008 08:41:56 -0700
Message-ID: <4AE25A7D8CBE4E4DA8E87173237DE27E7E50@blums0042.bluelnk.net>
From: "Karrels, Jeffrey J \(US SSA\)" <jeffrey.karrels@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

policycoreutils-1.33.12-12.el5

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, April 04, 2008 5:05 AM
> To: Karrels, Jeffrey J (US SSA)
> Cc: selinux@tycho.nsa.gov; Daniel J Walsh
> Subject: Re: Audit2allow + allow rule for 'granted' access
> 
> 
> On Thu, 2008-04-03 at 16:06 -0700, Karrels, Jeffrey J (US SSA) wrote:
> > Not that this is a big deal, but is there a way to stop audit2allow
> > from processing and creating rules for audits that are 'granted'?
> >
> >
> >
> > I turned on auditing for a couple of rules so I can keep an eye on
> > domain transitions. That creates some entries in the audit log such
> > as: "avc:  granted  { transition } for  pid=3409 ".
> >
> >
> >
> > When I run audit2allow on that entry, audit2allow creates a rule for
> > that entry as if the entry were a 'denied' rather than a 'granted'.
It
> > came into being an issue when I was ignoring the allow transition
> > entries, and there was an actual 'denied' audit (hidden amongst the
> > granted transitions [for mls reasons]) that I was not catching when
> > manually going through the logs.
> 
> That's a bug.  What version of policycoreutils?  Fixed upstream
already,
> I believe, so bugzilla it against RHEL.
> 
> --
> Stephen Smalley
> National Security Agency
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
