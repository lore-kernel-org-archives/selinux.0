Subject: Re: A vulnerability in SELinux (fwd)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: Rafal Wojtczuk <rafal@intruvert.com>, SELinux@tycho.nsa.gov
In-Reply-To: <20030607005310.GC27123@snoopy.apana.org.au>
References: <20030606170611.GA701@emperor.intruvert.com>
	 <20030607005310.GC27123@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1055160503.1068.12.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jun 2003 08:08:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-06-06 at 20:53, Brian May wrote:
> You could relabel every library, and only allow domains to execute
> libraries that are required by the application, but unless this can be
> automatated or semiautomated to some degree (eg. by looking at output of
> ldd), I think this could be a tedious and error prone task.
> 
> Then you have issues that program X runs in a new domain, and may not
> require library Z, but execs program Y in the same domain which does
> require Z.

Despite the potential difficulties, I'd still recommend partitioning the
shared libraries into multiple types and limiting especially privileged
domains to a subset of the complete set of shared library types.  Given
a small set of privileged domains (and a small set of code that needs to
run in those domains), this should be feasible.

> Which leaves the one last option: modifying /lib/ld-linux.so.2 to ignore
> LD_PRELOAD if the domain has changed.

Yes, changing ld.so to clear the sensitive LD_* vars on SID/context
transitions is desirable.  We could also provide a kernel mechanism for
doing a complete purge/reset of the environment on certain SID/context
transitions, but that would be far less fine-grained.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
