Subject: Re: Making libselinux depend on libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118945030.28244.8.camel@celtics.boston.redhat.com>
References: <1118944064.28244.4.camel@celtics.boston.redhat.com>
	 <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1118945030.28244.8.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 14:37:16 -0400
Message-Id: <1118947036.30202.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-16 at 14:03 -0400, Ivan Gyurdiev wrote:
> Right, this is all part of Dan's grand plan :)
> He has me working on integrating useradd utilities with 
> libselinux and libsepol, but net contexts are next on the list.
> 
> I'm changing the signature to this:
> 
> int security_map_policy(void** newdata, size_t newlen, int setbools)
> 
> Do you think it would be necessary/desirable to specify path locations
> in the caller also? This seems rather unnecessary to me - not sure..
> especially in a function designed to hide the details of the loading
> process.

In the common case, no.  For /sbin/init and most existing usage of
load_policy, it seems fine to have the library function internally
handle the path determination, the open and mmap of the binary policy
file, the runtime manipulation of the binary policy image for booleans,
users, and whatever, and the call to security_load_policy; thus, it
wouldn't even be necessary to return the final binary policy image to
the caller.  However, that would be a usage change for load_policy(8),
as it presently requires the caller to supply a path to the binary
policy file (and optionally allows a boolean file path to be specified
via -b, but I never bothered adding a similar option for the users
directory path).

But even if you do allow the caller to specify the paths (binary policy
file, booleans file, users directory), I'm not sure why you need to
return the final binary policy image to the caller and require them to
separately call security_load_policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
