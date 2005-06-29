Subject: Re: Groups in the alternative user solution
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1120055713.3553.105.camel@moss-spartans.epoch.ncsc.mil>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
	 <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
	 <1119988230.7417.6.camel@celtics.boston.redhat.com>
	 <1120055713.3553.105.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:05:25 -0400
Message-Id: <1120057525.17121.23.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Groups are still fundamentally discretionary (group membership is
> usually administratively-defined, but assigning group ownership or group
> ACLs to files is at the discretion of the user or any program he runs).

Yes, but assigning group ownership to files does not translate to
the selinux user corresponding to that group getting access to the
files... Essentially the same group maps to both MAC and DAC access
control.

That groups are already used for various purposes seems beneficial to me
- you can refit your existing grouping system to deal with SELinux
without going through each user individually.

It's true that your group requirements for DAC may not be the same
as for selinux... but we don't know if that's the case.

> > >   Better to require them to manage that mapping
> > > separately.  
> > 
> > Well, that's certainly the easier approach...
> 
> Yes.  Of course, ultimately such a mapping has to allow for distributed
> management too.

That requires writing a different backend for manging those records.
How would the interface work for this - would the caller have to specify
backend, or would the selinux library determine what's appropriate?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
