Subject: Re: Possible bug with fd class?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Johnson <jason.johnson.081@gmail.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
	 <4A372B2F.9000804@ak.jp.nec.com>
	 <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 16:01:02 -0400
Message-Id: <1245182462.2512.58.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-16 at 19:31 +0200, Jason Johnson wrote:
> 2009/6/16 KaiGai Kohei <kaigai@ak.jp.nec.com>:
> >
> > The "fd" class represents a file descriptor object, not any filesystem
> > objects. For example, if you open the /tmp/aaa, this file belongs to
> > "file" class, but the file descriptor of the file belongs to "fd" class.
> 
> I figured it was something like that, but I didn't see any actions I
> could take on fd's.
> 
> > It seems to me the policy does not allow:
> >
> >  logrotate_use_fds(syslogd_t)
> >
> > The fd class inherits the security context of the process which opened
> > itself.
> 
> Ok, fair enough, but why is syslog-ng seeing /dev/null as a
> logrotate_t target?  If logrotate opens /dev/null (as it probably
> does) that shouldn't affect any other process that opens that same
> device.  If it does that sounds like a potential security problem.

In this particular case it doesn't appear to be a problem, but often
programs unwittingly leak file descriptors when they exec a child
program.  Thus, this permission check has often been helpful in catching
such unintentional leaks, which can ultimately prove to be
security-relevant (leaking access to some resource that shouldn't be
accessible to the new program).

There are two checks applied:
- the fd use check, which controls whether a process can use a
descriptor originally opened by a process in a different security
context, and
- the file read/write/append checks, which control whether the process
can access the file in accordance with the open file flags.

If either set of checks fails, then the descriptor is closed and
replaced with a reference to the null device (to avoid application
misbehavior).

Naturally, if the passing of the descriptor is intentional and valid,
you can allow it in policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
