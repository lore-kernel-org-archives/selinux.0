Subject: [RFC] Remove init_context_translations() from libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 21 Feb 2007 12:20:29 -0500
Message-Id: <1172078429.14363.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think we've talked about this before, but never followed through.
Is there any reason to retain the init_context_translations() function
in libselinux, which sends a SETRANS_INIT message to mcstransd, gets a
response, and discards it?  Can we drop it and the call to it from the
library constructor/initializer?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
