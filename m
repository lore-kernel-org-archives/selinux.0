Subject: Re: Execmem boolean
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <42C2F865.2040102@redhat.com>
References: <1119822163.4357.9.camel@localhost.localdomain>
	 <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>
	 <42C2DB70.2070204@redhat.com>
	 <1120070997.3553.172.camel@moss-spartans.epoch.ncsc.mil>
	 <1120071263.20484.45.camel@celtics.boston.redhat.com>
	 <42C2F865.2040102@redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:07:03 -0400
Message-Id: <1120075623.20484.79.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Ok.
> Should be a boolean allow_X_execmem.  Most people don't need execmem for 
> X.  (Only nvidia binary drivers)

Are you sure? I thought it was always needed...
I recall bringing this up in the first place, because I ran into
this problem at work (where I don't use Nvidia binary modules).

I've had execmem enabled forever on my home computer.

I can recheck...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
