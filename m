Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118413116.3774.90.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118319901.10190.25.camel@localhost>
	 <1118342206.30110.132.camel@moss-spartans.epoch.ncsc.mil>
	 <1118413296.10190.312.camel@localhost>
	 <1118413116.3774.90.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 15:55:15 +0100
Message-Id: <1118415315.10190.329.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 10:18 -0400, Stephen Smalley wrote:
> On Fri, 2005-06-10 at 15:21 +0100, antoine wrote:
> > I am using this one from Gentoo 2004.1 (which has selinux support):
> > syslog-ng-1.6.7  -hardened +selinux -static +tcpd
> > (latest from amd64 stable) Which is supposed to have the same mods.
> 
> Is logrotate part of syslog-ng on Gentoo?  It is a separate package in
> Fedora.  
Nope, sorry, it's just me copying the wrong thing... I meant:
app-admin/logrotate	3.7.1-r1
sec-policy/selinux-logrotate	20050408

> 
> > logrotate.te contains:
> > 
> > # Set a context other than the default one for newly created files.
> > can_setfscreate(logrotate_t)
> > # Change ownership on log files.
> > allow logrotate_t self:capability { chown dac_override dac_read_search
> > kill fsetid fowner sys_resource sys_nice };
> 
> What about: 
> allow logrotate_t logfile:dir rw_dir_perms;
> allow logrotate_t logfile:file create_file_perms; 

It is all there, I found:

# grep logfile ./domains/program/logrotate.te
allow logrotate_t logfile:dir rw_dir_perms;
allow logrotate_t logfile:lnk_file read;
allow logrotate_t logfile:file create_file_perms;
can_exec(logrotate_t,logfile)

Not sure about the can_exec though? Why would you ever want to execute a
logfile?
> 
> > So I guess that my next question is: how do I figure out what is going
> > wrong?
> 
> You can always force a manual run of logrotate and trace/debug it in the
> usual manner.  Might want to ask on the gentoo lists as well since it
> may be specific to it.
Will do.

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
