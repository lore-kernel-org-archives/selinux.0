Date: Thu, 29 Aug 2002 14:15:32 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
cc: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: (no subject)
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8304ACC35A@eammlnt051.lmc.ericsson.se>
Message-ID: <Pine.GSO.4.33.0208291353390.18584-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 29 Aug 2002, Eric Gingras (LMC) wrote:

> I'm quite a newbie to SELinux. Up to now, I've install the system and I've
> look at the configuration files. As a first test, I've try to configure an
> application called HTTPServer using it's own type(domain) and it's own file
> type.

I'd suggest that you send questions regarding SELinux only to the selinux
mailing list, not to the LSM mailing list.  The LSM list is for discussion
of the LSM kernel patch, not for module-specific discussions.  I've
dropped the LSM list from my reply.

As you may have already noticed, there is a httpd_t domain in the example
policy configuration that was written by MITRE for the Apache web server.
See selinux/policy/domains/program/apache.te.  However, it has not been
converted over to using some of the newer macros like daemon_domain, so
you  might want to also look at some other daemon domains in the example
policy like named.te.

> When using the sysadm_r role, starting HTTPServer, and checking the process
> with ps --context, the domain of the process is "HTTPServer_t".  So
> everything looks normal.  But when using the user_r role, starting
> HTTPServer, and checking the process with ps --context, the domain of the
> process is "user_t".

Based on your .te file, this is correct.  You do not define a domain
transition from user_t or authorize the user_r role, so the process
remains in user_r:user_t.  User domains are given the ability to execute
most programs by the example policy via the can_exec_any() macro.
Limiting what a user domain can execute won't do much good unless you are
also preventing the user from compiling their own programs, downloading
programs from elsewhere, etc.  As David Caplan explained, it doesn't
matter whether an ordinary user can run the program, as long as the user
doesn't gain any particular permissions by doing so (and this doesn't
happen, since the domain is left unchanged).

Please also note that you should authorize system_r for a daemon domain
and define a domain transition from initrc_t if you want to start your
daemon during system initialization.  You can then remove
direct authorization for sysadm_r and the domain transition from sysadm_t,
instead using run_init to start the daemon by hand if necesssary.

I'll assume that you have already read the Configuring the SELinux Policy
report provided in the release and available from the NSA SELinux web
site.  If not, RTM.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
