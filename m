Date: Tue, 29 Jan 2002 10:32:01 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: applications and ports
In-Reply-To: <2137.192.168.1.12.1012313346.squirrel@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0201290944230.11892-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Jan 2002, Lonnie Cumberland wrote:

> If I add a new application to my system or a new service to my
> xinet.d services then in order for SELinux to impose the security
> policy on it I would guess that I have to make a TE file for it and
> rerun the make, right?
>
> Would this also mean that there are applications and service that
> might not be under the SELinux security policy that exist on my
> machine and that could potentially cause problems?

Every process is controlled by the SELinux security policy.  However, if
you allow a domain to execute a program type and you do not specify a
domain transition for that (domain, type) pair, then the process will
remain in the original domain.  This can potentially result in the process
having more permissions than desired or in the process having too few
permissions to function.

Step 17 of the README discusses this issue for the daemons started by the
rc scripts.  For xinetd, there is an example domain for the xinetd daemon
(inetd_t in inetd.te) and some example domain transitions for some of the
programs run by it (e.g. tcpd, rlogind, rshd, ftpd).  All other
/usr/sbin/in\.*d programs are currently placed into the generic
inetd_child_t domain, but you can split out new domains for services
that you require.

For user applications (as opposed to system services), you only need to
assign a particular domain if the application should run with different
permissions than the user (e.g. newrole is run in a domain that has
greater permissions so that it can change roles, while netscape is run in
a more restricted domain so that it cannot tamper with the user's files
outside of a particular sandbox).

To add a new domain, you need to define the new domain in the policy
configuration (e.g. create a new .te file) and load it (via 'make load'
in the policy directory).  You also need to assign the program type
associated with the domain to the program in the file_contexts
configuration and run 'make relabel' in the setfiles directory.
Alternatively, you can directly set the label on a program via chcon, but
it is a good idea to also update the file_contexts configuration in case
you later do a 'make relabel'.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
