Subject: Re: Domain transition
From: Justin Smith <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 17 Dec 2002 07:52:15 -0500
Message-Id: <1040129546.1247.7.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think domain transition is one of the key security features of
SELinux:

The one domain with high privileges similar to the old root privileges
is the initrc_t domain. But transitions cause this domain to "cease to
exist" by the time Linux has completely booted.
--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
