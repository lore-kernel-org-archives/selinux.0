MIME-Version: 1.0
In-Reply-To: <1245182462.2512.58.camel@localhost.localdomain>
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
	 <4A372B2F.9000804@ak.jp.nec.com>
	 <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
	 <1245182462.2512.58.camel@localhost.localdomain>
Date: Tue, 16 Jun 2009 23:13:14 +0200
Message-ID: <aa22f0200906161413j5c9ffc8eo60ae175b3c8dd16@mail.gmail.com>
Subject: Re: Possible bug with fd class?
From: Jason Johnson <jason.johnson.081@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 16, 2009 at 10:01 PM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
>
> In this particular case it doesn't appear to be a problem, but often
> programs unwittingly leak file descriptors when they exec a child
> program.  Thus, this permission check has often been helpful in catching
> such unintentional leaks, which can ultimately prove to be
> security-relevant (leaking access to some resource that shouldn't be
> accessible to the new program).
>
> There are two checks applied:
> - the fd use check, which controls whether a process can use a
> descriptor originally opened by a process in a different security
> context, and
> - the file read/write/append checks, which control whether the process
> can access the file in accordance with the open file flags.
>
> If either set of checks fails, then the descriptor is closed and
> replaced with a reference to the null device (to avoid application
> misbehavior).
>
> Naturally, if the passing of the descriptor is intentional and valid,
> you can allow it in policy.

So are you saying that this /dev/null access by syslog-ng is actually
because some other access actually failed?

I don't see how this could be either:

# semanage fcontext -l|grep logrotate
/etc/cron\.(daily|weekly)/sysklogd                 regular file
system_u:object_r:logrotate_exec_t:s0
/var/lib/logrotate(/.*)?                           all files
system_u:object_r:logrotate_var_lib_t:s0
/usr/sbin/logrotate                                regular file
system_u:object_r:logrotate_exec_t:s0

Note that the odd sysklogd entry doesn't exist in either of those two
directories.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
