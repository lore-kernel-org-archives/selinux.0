Date: Wed, 23 Jan 2002 00:18:15 +0100
From: Tom <tom@lemuria.org>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: restricted guest domain accounts
Message-ID: <20020123001815.B29234@lemuria.org>
References: <20020121091553.A28411@lemuria.org> <Pine.GSO.4.33.0201221410110.20295-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0201221410110.20295-100000@raven>; from sds@tislabs.com on Tue, Jan 22, 2002 at 02:28:51PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 22, 2002 at 02:28:51PM -0500, Stephen Smalley wrote:
> It seems like using SELinux on this system would be beneficial even
> without a special guest user domain.  The example policy provides a user_t
> domain for ordinary users that is already limited, e.g. even if such a
> user obtains superuser privileges, he cannot modify the system software,
> configuration files, or logs.  The issue is not what programs can be run
> by the user but what permissions are granted to domains that can be
> entered by the user.  You could strip the user_t domain down further if
> desired, but you need to consider whether you are really improving
> security by doing so.  With regard to system calls, SELinux doesn't
> interpose on system calls - it provides low-level controls over the actual
> kernel operations on kernel objects.

thanks - as I said, I still haven't understood all of it.

what I want is, essentially, a user that can do exactly two things: log
in, and connect out again, with a small set of tools (ssh and telnet,
currently). that's it. he shouldn't be able to run anything else on the
machine. no looking at the process table, no ping'ing, no starting
daemons, nothing.

I'm not so much troubled about the users obtaining root, as the users
using the machine for a purpose other than the one specified.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
