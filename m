Date: Mon, 25 Jun 2001 10:54:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Darrell McGuire <dmcguire@pegasys.cc>
cc: SELinux@tycho.nsa.gov
Subject: Re: SELinux with acl.bestbits.at ext2fs patch
In-Reply-To: <3B34C7A1.DBBD5E6F@pegasys.cc>
Message-ID: <Pine.SOL.3.95.1010625103236.28102H-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 23 Jun 2001, Darrell McGuire wrote:

> Have any of you attempted a dual patch of both the POSIX ACL patch
> from Andreas Gruenbacher (acl.bestbits.at) and SELinux?

We have not.  SELinux currently provides its own support for
binding security attributes to files.  If support for extended
attributes were integrated into the mainstream kernel, then
we would naturally investigate using that support instead.

> Second question, as a follow up, does the dev. team for SELinux
> few this technology as a way to help harden a firewall, or as more
> of a general purpose OS security tool?

You can configure the SELinux access controls to meet a variety of
needs.  So you can use SELinux to harden a firewall or a web/mail/DNS
server.  You can also use SELinux on client systems to protect users
against malicious code.  However, it will naturally be easier to
configure the security policy for firewalls and dedicated server systems
than for client systems.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
