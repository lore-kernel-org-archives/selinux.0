Subject: Re: SElinux vs. Grsecruity vs. RSBAC (vs. TrustedBSD?)
From: Justin Smith <jsmith@drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1062089800.87968.7.camel@vorpal.mcs.drexel.edu>
Mime-Version: 1.0
Date: Thu, 28 Aug 2003 12:56:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an interesting topic as I recently installed FreeBSD 5.1.

Points about TrustedBSD:
 
 1. All of the features will be folded into the FreeBSD 5 series. Most
of them are already in, except for the SEBSD (the implementation of
FLASK, a la SELinux). Unfortunately, I haven't been able to find any
sample policies for the components that are present.  Some, like ACL's
are fairly straightforward, but others like capabilities and mandatory
access control require a fair amount of configuration. Documentation
seems to have lagged behind software development.
 
2. FreeBSD, being a complete OS, incorporates all userland programs so
the inclusion of FLASK also includes modifications to userland. The
question of upstream incorporation of FLASK modifications becomes moot
(unless one talks of modifying programs not part of the distribution
like apache...).
-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
