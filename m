Date: Fri, 5 Oct 2001 14:09:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Cron
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152420D@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0110051349220.29582-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 5 Oct 2001, Westerman, Mark wrote:

> When I place the backup in the crontab it will not execute.
> I get an ENTRYPOINT error on the crontab file for amanda.

The cron daemon was modified to check entrypoint permission between the
user's cron job security context (from /etc/security/cron_context) and
the security context on the crontab file.  This simulates the checking
that would occur if a crontab file were an executable script
rather than a configuration file.  It is done to ensure that a low
integrity crontab is not executed by a privileged user's cron job.
Otherwise, a superuser process in an unprivileged domain could potentially
create a bogus crontab for a privileged user.

Notice that the crontab program domains
(policy/domains/program/crontab.te) are set up to automatically label
user crontab files with a derived type based on user domain that ran the
crontab program.  For example, if a user_t process runs crontab (thereby
entering user_crontab_t), the resulting crontab will labeled
user_cron_spool_t and cannot be used for a sysadm_t cron job.  What
type are you using for your amanda domain's crontab files?

The crond domains (policy/domains/system/crond.te) are granted entrypoint
permission to the appropriate crontab file type.  The system_crond_t
domain is granted entrypoint permission to system_crond_script_t, which is
set for /etc/crontab and /etc/cron.d/* when you did the 'make relabel'.
The user crond domains are granted entrypoint permission to the appropriate
derived type, which is set when the crontab file is created as described
above.  Are you trying to run this job from one of the system crontab
files or from the amanda user's crontab file?  If the latter, what is the
amanda user's security context in /etc/security/cron_context?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com








--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
