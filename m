Subject: Re: Making libselinux depend on libsepol
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
References: <1118944064.28244.4.camel@celtics.boston.redhat.com>
	 <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 14:03:50 -0400
Message-Id: <1118945030.28244.8.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> No, it seems fine, and it is already the case that /sbin/init is
> depending on libsepol (for the same reason).  This should simplify the
> SELinux patch for /sbin/init and avoid the need to keep customizing it
> whenever we add another form of runtime policy manipulation (e.g. in
> addition to booleans and local users, there have also been requests to
> allow local customizations of network contexts).

Right, this is all part of Dan's grand plan :)
He has me working on integrating useradd utilities with 
libselinux and libsepol, but net contexts are next on the list.

I'm changing the signature to this:

int security_map_policy(void** newdata, size_t newlen, int setbools)

Do you think it would be necessary/desirable to specify path locations
in the caller also? This seems rather unnecessary to me - not sure..
especially in a function designed to hide the details of the loading
process.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
