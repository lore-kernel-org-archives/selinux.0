Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118319901.10190.25.camel@localhost>
References: <1118281858.9481.4.camel@localhost>
	 <1118319901.10190.25.camel@localhost>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 14:36:46 -0400
Message-Id: <1118342206.30110.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-09 at 13:25 +0100, antoine wrote:
> Some more questions:
> 7) What can I do to logrotate.te to make it rotate my mysql logfiles but
> have the correct label on the new /var/log/mysql/mysql.log file. As it
> is now it comes up as var_log_t rather than mysql_var_log_t

Does type mysqle_var_log_t have the logfile attribute?  If so, then
logrotate.te should be allowing logrotate the necessary permissions to
re-create the file with that type.  Of course, your logrotate program
has to be modified to preserve types on log files; the one in Fedora
should have such modifications.

> 8) How can I allow daemons to write to /dev/log?
> allow psad_t devlog_t:sock_file write;
> Is not allowed...

Add the 'privlog' attribute to the domain for the daemon.

> 9) One of my scripts needs to kill a few processes by name (if they
> exist) so it does something like 'ps -ef | grep "someLongUniqueString in
> processName"' but that triggers all sorts of violations. Is there a
> better way?

I'm not sure why you wouldn't use killall, but I don't think that will
help with the denials anyway.  Notice that the existing policy often
dontaudit's such attempts to avoid generating noise, e.g.
	dontaudit foo_t domain:dir search;
Note that if you are in enforcing mode, then it will stop trying after
the search failure, so you won't get the subsequent denials on the
attempts to read files under the directory.  So don't assume that you
need to add more dontaudit rules just because of the output while in
permissive mode.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
