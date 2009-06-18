Subject: Re: Possible bug with fd class?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Johnson <jason.johnson.081@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <aa22f0200906172153n2c67abcj1309a76208c5b96e@mail.gmail.com>
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
	 <4A372B2F.9000804@ak.jp.nec.com>
	 <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
	 <1245182462.2512.58.camel@localhost.localdomain>
	 <aa22f0200906161413j5c9ffc8eo60ae175b3c8dd16@mail.gmail.com>
	 <1245241613.29288.1.camel@localhost.localdomain>
	 <aa22f0200906171128k7e4ed8ame6af9b34be654a41@mail.gmail.com>
	 <1245266012.3033.63.camel@localhost.localdomain>
	 <aa22f0200906172153n2c67abcj1309a76208c5b96e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 08:48:12 -0400
Message-Id: <1245329292.3033.89.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-06-18 at 06:53 +0200, Jason Johnson wrote:
> On Wed, Jun 17, 2009 at 9:13 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>         > On Wed, Jun 17, 2009 at 2:26 PM, Stephen
>         Smalley<sds@tycho.nsa.gov> wrote:
>         > >> >
>         
>         
>         This just means that logrotate invoked syslog-ng while holding
>         open a
>         descriptor to /dev/null.  Nothing more.
>         
>         
>         --
>         Stephen Smalley
>         National Security Agency
>         
>         
> 
> Ah!  I checked the logrotate configuration and I do see that daily it
> invokes:
> 
> /usr/sbin/invoke-rc.d syslog-ng reload >/dev/null
> 
> So that makes the /dev/null file descriptor that fd 2 (stdout) is
> opened to be logrotate_t?  Thanks very much for helping me understand
> how this is happening.
> 
> My one concern here is the solution.  What I would want to say from a
> high level is: "logrotate is allowed to run syslog-ng" or even more
> correct "logrotate is allowed to run the init.d syslog-ng script".
> What I actually have to say is: "syslog-ng is allowed to write to
> filedescriptors owned by logrotate".
> 
> I understand now why this situation happens, it just strikes me as an
> extremely low level interface.  What I have to do to allow logrotate
> to run syslog doesn't look very much like "let logrotate run
> syslog-ng's init.d script".  Further, since file descriptors are
> always inherited from the parent, wouldn't any program ran from any
> other program have a similar situation?  For example, if I took out
> the redirect to /dev/null then I would expect to get the same deny on
> whatever tty or file logrotate has connected to stdout.  Thoughts?
> 
> And thanks again everyone for your responses.

(restored cc line)

The policy already has rules to allow the transition from logrotate_t to
initrc_t when executing an init script, and from initrc_t to syslogd_t
when executing syslog-ng.  Further, the policy already has rules to
allow the initrc_t to inherit a descriptor from logrotate_t, and to
allow syslogd_t to inherit a descriptor from initrc_t.  What is missing
is a rule to allow syslogd_t to inherit a descriptor originally opened
by logrotate_t, as that is an indirect relationship.

If you really don't want to use the fd use controls, and only care about
the checks on the actual files, then you can disable the fd use controls
by enabling the allow_domain_fd_use boolean (at least in the Fedora
policy).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
