Date: Wed, 19 Dec 2001 14:36:10 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <lonnie@outstep.com>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
In-Reply-To: <1008786485.3c20dc3520535@mail.outstep.com>
Message-ID: <Pine.GSO.4.33.0112191351410.5056-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 19 Dec 2001 lonnie@outstep.com wrote:

> Actually I found out that I had to use the original unchanged every.te as well
> as changing the be_domain back to domain in the be_user.te file.

No, that isn't right.  If you use the original every.te file and you keep
the "domain" attribute on your new domain, then the rules in every.te will
be applied to your new domain, which is more permissive than you want.  As
I said originally, you must either change every.te to exclude your new
domain or you must not use the "domain" attribute on your new domain.  The
first option seems preferable (changing every.te).

Please make sure that you've read the available documentation regarding
the policy before proceeding any further.  Randomly making changes without
any understanding of what you are doing is unlikely to produce the desired
result.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
