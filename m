Date: Sat, 7 Jun 2003 10:53:10 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Rafal Wojtczuk <rafal@intruvert.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux (fwd)
Message-ID: <20030607005310.GC27123@snoopy.apana.org.au>
References: <20030606170611.GA701@emperor.intruvert.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030606170611.GA701@emperor.intruvert.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 06, 2003 at 10:06:11AM -0700, Rafal Wojtczuk wrote:
> Brian May> IIRC A process needs exec rights in order to use a shared library.
> Correct. That is why simple "LD_PRELOAD=./my_evil_library.so schfn" does not
> work.

I think the key mistake I made (im my sleep) is that libSegFault.so is
a libc6 library (that does what???), and it is installed on all Linux
systems.

What is libSegFault.so anyway?

The bug reported here is that any library in /lib can be used in
LD_PRELOAD. This would appear to be a potential problem for any exec
from a "untrusted" domain that changes the domain to one that grants
more access, not just schfn.

You could relabel every library, and only allow domains to execute
libraries that are required by the application, but unless this can be
automatated or semiautomated to some degree (eg. by looking at output of
ldd), I think this could be a tedious and error prone task.

Then you have issues that program X runs in a new domain, and may not
require library Z, but execs program Y in the same domain which does
require Z.

You could make every program that changes the domain statically linked,
but that would be painful.

You could remove every domain switch from an "untrusted" domain to
a domain with more access and replace them with communications to a
trusted process, I think this would be a lot of work (just how many
times does this occur anyway? Maybe some sort of tool to automatically
count this would be useful...). I think this would be an interesting
ideal all the same, but outside the scope of SE-Linux.

Which leaves the one last option: modifying /lib/ld-linux.so.2 to ignore
LD_PRELOAD if the domain has changed.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
