Date: Mon, 13 Jun 2005 22:19:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Park Lee <parklee_sel@yahoo.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Valdis.Kletnieks@vt.edu, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux?
Message-ID: <20050613211951.GD17412@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com> <20050612021611.94597.qmail@web51501.mail.yahoo.com> <20050612114421.GA31033@lkcl.net> <1118666230.24565.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118666230.24565.1.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 13, 2005 at 08:37:10AM -0400, Stephen Smalley wrote:
> On Sun, 2005-06-12 at 12:44 +0100, Luke Kenneth Casson Leighton wrote:
> >  btw i should also raise - again - the wisdom of only utilising
> >  a 32-bit security descriptor in a networked environment.
> > 
> >  only 32-bit means that if you want to merge or join two secure
> >  environments together, well.... you basically can't: you have a clash
> >  of 32-bit SIDs.
> > 
> >  with NT / VAX-VMS style security descriptors (comprising 4of 32-bit
> >  "SIDs" for a domain and a 32-bit "RID" - relative ID) you can at least
> >  start creating inter-domain trust relationships.
> 
> As is clearly noted in all SELinux documentation, SIDs are purely non-
> global (node-local) and non-persistent handles to security contexts.
> And as of Linux 2.6, they are furthermore kernel-private (or in the case
> of the userspace AVC, application-private).

 so the security "context" label string is equivalent to an NT "RID".

 and - just to clarify: the DOI - domain of interpretation -
 is equivalent to the NT domain "prefix"?

 cheers,

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
