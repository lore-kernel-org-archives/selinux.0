Subject: Re: Method to assign MCS Category without login.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Joshua.Kramer" <josh@globalherald.net>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0708191603500.15934@home-av-server.home-av>
References: <Pine.LNX.4.64.0708191603500.15934@home-av-server.home-av>
Content-Type: text/plain
Date: Mon, 20 Aug 2007 07:57:59 -0400
Message-Id: <1187611079.24940.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-08-19 at 16:06 -0400, Joshua.Kramer wrote:
> Hello,
> 
> I apoligize if this is too 'basic' or 'distro-specific' for this list, but 
> I have a question regarding MCS Category Access.
> 
> On page 509 of the RHEL5 manual, there's a note that states: "MCS category
> access is assigned during login."
> 
> What is the mechanism that does this?

The per-user category authorizations are defined via the semanage
command (semanage login) or system-config-selinux GUI (User Mapping),
and stored in /etc/selinux/$SELINUXTYPE/seusers.  Login and sshd consult
that mapping in order to set the user's initial security context at
login time, and crond does likewise for cron jobs.

> How can I assign MCS Category Access to an arbitrary Python script that is
> run as a certain user from Crontab (without being 'logged in')?

crond should consult the mapping and use it when starting the user's
cron job, so it should be possible to assign the categories to the
user's identity via semanage and then crond should use it.

That's the theory of operation.  As to whether it actually works in
RHEL5, I don't know - it might require subsequent LSPP updates that
would show up in 5.1.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
