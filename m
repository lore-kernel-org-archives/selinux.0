Date: Wed, 6 Feb 2002 09:34:28 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Running sshd shells in sysadm_t
In-Reply-To: <1012958279.1816.3.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0202060932200.27827-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 5 Feb 2002, Justin Smith wrote:

> I noticed that sshd shells are, by default, run in user_t and are
> allowed to be run in sysadm_t as well.
>
> Is there some way to make them run in sysadm_t by default when certain
> users log in?

This is determined by the /etc/security/default_context file.  At present,
sshd simply uses the default security context for the user (rather than
prompting for a context), since it can be used non-interactively for
remote commands or remote copies.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
