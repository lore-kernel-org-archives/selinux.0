Date: Fri, 12 Apr 2002 12:35:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412172954.A30349@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204121232150.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Tom wrote:

> actually, one more question: What am I doing wrong if the generic user
> entries don't work? i.e. I create a new user - can't log in remotely. I
> add him to /etc/security/default_context - still no luck. I add him to
> the policy (/etc/selinux/users) and it works.

At present, if you want to use the generic user support, you also need an
entry for user_u in /etc/security/default_context (i.e.
user_u:user_r:user_t).  Such an entry is in the example default_context
file in the upstream SELinux distribution.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
