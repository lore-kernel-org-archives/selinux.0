Date: Fri, 12 Apr 2002 13:04:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412185044.A6824@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204121303000.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Tom wrote:

> I have that. However, trying to log in via ssh fails with the same SID
> error message I had earlier for tom when I didn't have tom in the
> default_context. So this was my first idea - but not luck. I also do
> have that user_u in the users role file (I didn't modify the default
> very much yet).

Seems to work here for me.  I added a user who has no entry in
policy/users or /etc/security/default_contexts, then logged in
as that user using ssh and ended up with my context as
user_u:user_r:user_t.  Again, this is with the upstream distribution, not
the Debian selinux package.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
