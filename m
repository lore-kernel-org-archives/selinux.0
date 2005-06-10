Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118342206.30110.132.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118319901.10190.25.camel@localhost>
	 <1118342206.30110.132.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 15:21:36 +0100
Message-Id: <1118413296.10190.312.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-09 at 14:36 -0400, Stephen Smalley wrote:
> On Thu, 2005-06-09 at 13:25 +0100, antoine wrote:
> > Some more questions:
> > 7) What can I do to logrotate.te to make it rotate my mysql logfiles but
> > have the correct label on the new /var/log/mysql/mysql.log file. As it
> > is now it comes up as var_log_t rather than mysql_var_log_t
> 
> Does type mysqle_var_log_t have the logfile attribute?
It is created using 'log_domain(mysqld)':
#grep mysqld_log_t policy.conf
type mysqld_log_t, file_type, sysadmfile, logfile;
allow mysqld_t mysqld_log_t:file { create ioctl read getattr lock write
setattr append link unlink rename };
type_transition mysqld_t var_log_t:file mysqld_log_t;
allow initrc_t mysqld_log_t:file { write append setattr ioctl };

So I'm not sure why it does not behave, here is the syslog-ng.d/mysql:

/var/log/mysql/mysql.err /var/log/mysql/mysql.log /var/log/mysql/mysqld.err {
monthly
create 660 mysql mysql
notifempty
size 5M
sharedscripts
missingok
postrotate
/bin/kill -HUP `cat /var/run/mysqld/mysqld.pid`
endscript
}


>   If so, then
> logrotate.te should be allowing logrotate the necessary permissions to
> re-create the file with that type.  Of course, your logrotate program
> has to be modified to preserve types on log files; the one in Fedora
> should have such modifications.
I am using this one from Gentoo 2004.1 (which has selinux support):
syslog-ng-1.6.7  -hardened +selinux -static +tcpd
(latest from amd64 stable) Which is supposed to have the same mods.
logrotate.te contains:

# Set a context other than the default one for newly created files.
can_setfscreate(logrotate_t)
# Change ownership on log files.
allow logrotate_t self:capability { chown dac_override dac_read_search
kill fsetid fowner sys_resource sys_nice };

So I guess that my next question is: how do I figure out what is going
wrong?

> > 8) How can I allow daemons to write to /dev/log?
> > allow psad_t devlog_t:sock_file write;
> > Is not allowed...
> 
> Add the 'privlog' attribute to the domain for the daemon.
Ah Thanks.

> > 9) One of my scripts needs to kill a few processes by name (if they
> > exist) so it does something like 'ps -ef | grep "someLongUniqueString in
> > processName"' but that triggers all sorts of violations. Is there a
> > better way?
> 
> I'm not sure why you wouldn't use killall, but I don't think that will
> help with the denials anyway.
I probably could (just that the long grep restricts more than what
killall allows - it feels safer)
>   Notice that the existing policy often
> dontaudit's such attempts to avoid generating noise, e.g.
> 	dontaudit foo_t domain:dir search;
> Note that if you are in enforcing mode, then it will stop trying after
> the search failure, so you won't get the subsequent denials on the
> attempts to read files under the directory.  So don't assume that you
> need to add more dontaudit rules just because of the output while in
> permissive mode.
Good, I hadn't thought of that.

Many thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
