Subject: Re: Groups in the alternative user solution
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1120057525.17121.23.camel@celtics.boston.redhat.com>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
	 <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
	 <1119988230.7417.6.camel@celtics.boston.redhat.com>
	 <1120055713.3553.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1120057525.17121.23.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:38:45 -0400
Message-Id: <1120059525.3553.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 11:05 -0400, Ivan Gyurdiev wrote:
> Yes, but assigning group ownership to files does not translate to
> the selinux user corresponding to that group getting access to the
> files... Essentially the same group maps to both MAC and DAC access
> control.

Right, such overloading could yield confusion and improper granting of
MAC access.  That's my concern.

> That groups are already used for various purposes seems beneficial to me
> - you can refit your existing grouping system to deal with SELinux
> without going through each user individually.

Possibly.  More likely you will just map whatever groups you already
have defined to SELinux.

> It's true that your group requirements for DAC may not be the same
> as for selinux... but we don't know if that's the case.

Seems unlikely to me, given the difference between DAC and MAC.
But I'm open to other opinions on the subject.

> That requires writing a different backend for manging those records.
> How would the interface work for this - would the caller have to specify
> backend, or would the selinux library determine what's appropriate?

Ideally libselinux would hide it, much as existing interfaces for
looking up users, groups, and hosts hide what backend is used to obtain
that information.  Another service in /etc/nsswitch.conf?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
