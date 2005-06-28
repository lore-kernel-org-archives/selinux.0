Subject: Re: Groups in the alternative user solution
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
	 <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 15:50:30 -0400
Message-Id: <1119988230.7417.6.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'd actually suggest that we not try to map Unix/Linux groups to SELinux
> users at all, and require explicit Linux user -> SELinux user mappings.
> Unix groups and SELinux user identities serve very different purposes,

I thought they both served the purpose of grouping together
things that should have the same security properties, and 
isolating things that should have different ones.

> and I can't see a good reason to link them together (and definite danger
> in doing so).

Why is that?

>   Better to require them to manage that mapping
> separately.  

Well, that's certainly the easier approach...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
