Date: Wed, 24 Apr 2002 16:19:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: your mail
In-Reply-To: <20020424182953.75A6C812DB@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0204241612160.18677-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Apr 2002, Debian User wrote:

> I just used the prel script. Now im working on the syntax. I have the two
> white papers with me. I think I need to define new types and domains.
> What would possibly be the criteria for the decision? A rule of thumb if
> i may say so.

First, read the selinux/README file, particularly the post-install
instructions (starting around step 18).  Make sure that you don't have any
system processes left in initrc_t, as mentioned in step 18.

Domains and types are security equivalence classes for processes and
objects, respectively.  In other words, all processes in the same domain
have the same permissions, and all objects with the same type (and class)
can be accessed in the same way.  You want to use a distinct domain or
type when you want to distinguish a process or an object from others in
the security policy.  Processes that have the same security properties can
be placed into the same domain.  Similarly for objects and types.

The new policy report should be helpful in getting you started, although
it still isn't at the level of a HOWTO, so I'm hoping that others will
start writing HOWTOs derived from it and expanding upon it.  I expect this
report to be released soon, but I'm not sure exactly when.  Some
people at Tresys Technology have started writing some white papers related
to the policy that you can find at http://www.tresys.com/selinux.html.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com














--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
