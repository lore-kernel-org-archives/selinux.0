Subject: Re: Possible bug with fd class?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Johnson <jason.johnson.081@gmail.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <aa22f0200906161413j5c9ffc8eo60ae175b3c8dd16@mail.gmail.com>
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
	 <4A372B2F.9000804@ak.jp.nec.com>
	 <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
	 <1245182462.2512.58.camel@localhost.localdomain>
	 <aa22f0200906161413j5c9ffc8eo60ae175b3c8dd16@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 08:26:53 -0400
Message-Id: <1245241613.29288.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-16 at 23:13 +0200, Jason Johnson wrote:
> On Tue, Jun 16, 2009 at 10:01 PM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
> >
> > In this particular case it doesn't appear to be a problem, but often
> > programs unwittingly leak file descriptors when they exec a child
> > program.  Thus, this permission check has often been helpful in catching
> > such unintentional leaks, which can ultimately prove to be
> > security-relevant (leaking access to some resource that shouldn't be
> > accessible to the new program).
> >
> > There are two checks applied:
> > - the fd use check, which controls whether a process can use a
> > descriptor originally opened by a process in a different security
> > context, and
> > - the file read/write/append checks, which control whether the process
> > can access the file in accordance with the open file flags.
> >
> > If either set of checks fails, then the descriptor is closed and
> > replaced with a reference to the null device (to avoid application
> > misbehavior).
> >
> > Naturally, if the passing of the descriptor is intentional and valid,
> > you can allow it in policy.
> 
> So are you saying that this /dev/null access by syslog-ng is actually
> because some other access actually failed?

No, that would show up as a separate AVC, and would
reference /selinux/null rather than /dev/null.

> I don't see how this could be either:
> 
> # semanage fcontext -l|grep logrotate
> /etc/cron\.(daily|weekly)/sysklogd                 regular file
> system_u:object_r:logrotate_exec_t:s0
> /var/lib/logrotate(/.*)?                           all files
> system_u:object_r:logrotate_var_lib_t:s0
> /usr/sbin/logrotate                                regular file
> system_u:object_r:logrotate_exec_t:s0
> 
> Note that the odd sysklogd entry doesn't exist in either of those two
> directories.

Some entries in file_contexts are for other distributions and may not
apply to your particular filesystem.  That's ok - it doesn't do any
harm.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
