Date: Wed, 10 Oct 2001 15:04:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jon Crowley <jonathan@mitre.org>
cc: Frank Mayer <mayerf@tresys.com>, <SELinux@tycho.nsa.gov>,
        <slinux@scotty.mitre.org>
Subject: Re: Security policy analysis
In-Reply-To: <3BC47F1C.B24952C4@mitre.org>
Message-ID: <Pine.GSO.4.33.0110101456450.16839-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Oct 2001, Jon Crowley wrote:

> Steve also suggested incorporating these functions into checkpolicy.
> With the interactive query front-end, this would become the policy
> analysis tool.  However, our take on checkpolicy is that it is intended
> to compile policies and to assist in debugging specific to security
> identifiers.  We are thinking it might be cleaner to keep policy
> analysis tools separate from a policy compiling/debugging tool.  Though
> perhaps we have the wrong take on checkpolicy.  More thoughts on this?

The -d option to the checkpolicy progam can be used to determine how the
security server would respond if it were using the policy without actually
loading the policy into the kernel security server.  Currently, it simply
allows you to exercise the security server functions, which are
essentially primitive queries on the policy.  I don't see why you wouldn't
want to add additional support for more complex queries to it.  Creating
separate tools (with their own code and data structures) will make
maintenance harder and increase the likelihood that the policy analysis
tools will have a different interpretation of the policy than the security
server.

> The problem with building a separate tool is that both tools will share
> some of the same code.  Does it makes sense to pull out commonly-used
> code in checkpolicy, specifically the code that reads in the binary and
> text versions of the policy into data structures, and put this code into
> some sort of library?  It seems this code may be useful to future
> applications, and it would be easier to maintain and more accessible if
> it was in a library.

This could be done, but it isn't necessary if you merge your tools into
checkpolicy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
