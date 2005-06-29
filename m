Subject: Re: Groups in the alternative user solution
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1119988230.7417.6.camel@celtics.boston.redhat.com>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
	 <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
	 <1119988230.7417.6.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 10:35:13 -0400
Message-Id: <1120055713.3553.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-28 at 15:50 -0400, Ivan Gyurdiev wrote:
> > I'd actually suggest that we not try to map Unix/Linux groups to SELinux
> > users at all, and require explicit Linux user -> SELinux user mappings.
> > Unix groups and SELinux user identities serve very different purposes,
> 
> I thought they both served the purpose of grouping together
> things that should have the same security properties, and 
> isolating things that should have different ones.

Groups are still fundamentally discretionary (group membership is
usually administratively-defined, but assigning group ownership or group
ACLs to files is at the discretion of the user or any program he runs).

> > and I can't see a good reason to link them together (and definite danger
> > in doing so).
> 
> Why is that?

Because people are already using groups for a variety of purposes, and
will tend to just re-use existing groups and map them onto SELinux user
identities/roles blindly without really considering what is appropriate,
e.g. the assumption that everyone in group wheel should be mapped to
staff/sysadm is dangerous.

> >   Better to require them to manage that mapping
> > separately.  
> 
> Well, that's certainly the easier approach...

Yes.  Of course, ultimately such a mapping has to allow for distributed
management too.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
