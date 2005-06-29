Subject: Re: Execmem boolean
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1120070997.3553.172.camel@moss-spartans.epoch.ncsc.mil>
References: <1119822163.4357.9.camel@localhost.localdomain>
	 <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>
	 <42C2DB70.2070204@redhat.com>
	 <1120070997.3553.172.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 14:54:23 -0400
Message-Id: <1120071263.20484.45.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>  Strict policy likely
> shouldn't allow execmod to anything but texrel_shlib_t, and can thus
> omit the boolean altogether.

Please don't break strict policy :(

I still have some hope left to be able to 
run it on my home machine. The level of "strictness"
should be configurable.

We could kill the allow_execmod/allow_execmem booleans,
allow execmod to texrel, allow exemem for X,
and then have per app booleans for other things we don't trust
(like Java applets?). 





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
