Date: Mon, 11 Mar 2002 09:07:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Samarth  Sharma <samarth7880@rediffmail.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: your mail
In-Reply-To: <20020310093940.30150.qmail@mailFA9.rediffmail.com>
Message-ID: <Pine.GSO.4.33.0203110836020.25401-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 10 Mar 2002, Samarth  Sharma wrote:

> 1.On login i get the following message :
>   [ avc: denied {write} for pid=647 exe=/bin/login
>   path=/var/log/wtmp dev=03:07 ino=182350
>   scontext=system_u:system_r:local_login_t
>   tcontext=system_u:object_r:cron_log_t tclass=file ]
> what does this mean and how can i get around it.
>   i get similar messages while loading 'atd'.

This indicates that your /var/log/wtmp file has the wrong security context
(system_u:object_r:cron_log_t rather than system_u:object_r:wtmp_t).
Run 'make verbose' in your setfiles directory after logging into the
sysadm_r role and sysadm_t domain to ensure that all of your file security
contexts are set properly.  You should have done this originally as step
15 of the README after you first booted SELinux.  You still need to figure
out why this happened to prevent a recurrence.  Some possible
explanations:

1) You have a cron job set up to rotate wtmp (and other log files) using
something other than the SELinux-modified logrotate program.  The
SELinux-modified logrotate program ensures that rotated files retain the
security context of the original file.  If you are rotating wtmp in some
other way, then it will pick up the cron_log_t type by default, as noted
by Russell Coker.  In this case, you need to ensure that you preserve
security contexts on log files when you rotate them.

2) You've switched back-and-forth between running an ordinary Linux kernel
and the SELinux kernel, and the wtmp file was re-created (possibly
rotated) while running the ordinary Linux kernel.  In this case, it is
sufficient to run 'make verbose' in the setfiles directory to ensure that
the file security contexts are set properly.

> 2.Can u give me a specific example where SElinux is able to solve
> a security flaw in normal Linux

I'd suggest reading the FAQ (esp. question #2,
http://www.nsa.gov/selinux/faq.html#l2) and the two published papers
about SELinux from http://www.nsa.gov/selinux/docs.html.
The Inevitability of Failure background paper
(http://www.nsa.gov/selinux/inevit-abs.html) provides a good explanation
of why mandatory access controls are necessary in general.  Two simple
examples are confining malicious mobile code that exploits a flaw in your
web browser and confining an exploit of a flaw in apache, bind, sendmail,
or any other system service.

> 3.i tried loading the selinux kernel on an amd machine.
> however the machine keeps rebooting immediately after the lilo
> screen. Linux 7.1 (redhat) runs fine on this machine.

Make sure that you set up your Processor type and features correctly in
the kernel configuration before building the SELinux kernel.  You could
try using the default RedHat kernel configuration from the RedHat SRPM
with just a few alterations for the SELinux-related options.

> 4.how do u add a user to the system. i added a new user in the
> ../policy/users file with appropriate context and compiled the
> policy but security context for that user was not initialized.

You also need to update the /etc/security/default_context and
/etc/security/cron_context files to define default login and cron job
security contexts for the user.  These files will become obsolete pending
some ongoing work, so at some point, you will only need to update
policy/users.  Also, we've merged support for a generic unprivileged user
that will show up in the next public release, so you will no longer need
to update any of these files if the new user only requires unprivileged
access and does not need to be separated from other such users by the
policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
