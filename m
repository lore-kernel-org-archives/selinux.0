Date: Tue, 15 Oct 2002 18:18:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
cc: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: Sockets permissions
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8304ACC386@eammlnt051.lmc.ericsson.se>
Message-ID: <Pine.GSO.4.33.0210151809490.11172-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 15 Oct 2002, Eric Gingras (LMC) wrote:

> I've created a new domain for each of them. Running them as
> sysadm_u:sysadm_r in permissive mode they work fine. In enforcing mode, they
> both start and execute, but the messages don't achieve destination.  If I
> start them both and shift between permissive and enforcing, messages go
> through when in permissive and don't when in enforcing...

Then you should see avc denied audit messages in your /var/log/messages
file that indicate what permissions are being denied.  You can then use
that information to fix your policy, optionally using the newrules.pl
script to generate allow rules from the audit messages.

> 	allow HTTPClient_t HTTPServer_t:socket_class_set rw_socket_perms;

You don't want to authorize the client to directly access a socket labeled
with the server's type, so the above rule is wrong.  Try the following
macro instead:
	can_udp_send(HTTPClient_t, HTTPServer_t)

Of course, this is only meaningful for loopback or labeled networking.

> 	allow HTTPServer_t HTTPClient_t:socket_class_set
> create_socket_perms;

Likewise, you don't want to authorize the server to directly create and
access a socket labeled with the client's type.  You want:
	can_udp_send(HTTPServer_t, HTTPClient_t)

Again, the direct check between the client and server types is only
possible on loopback or with labeled networking between the hosts.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
