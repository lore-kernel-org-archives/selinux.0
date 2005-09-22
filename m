Subject: Re: Getting started with SELinux and Slackware
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lee Lowder <friedbob@sbcglobal.net>
Cc: Timothy Wood <timothy@diyab.net>, selinux@tycho.nsa.gov
In-Reply-To: <43325C75.3060405@sbcglobal.net>
References: <43325C75.3060405@sbcglobal.net>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 08:28:27 -0400
Message-Id: <1127392107.19487.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-22 at 02:25 -0500, Lee Lowder wrote:
> I am using Slackware 10.2 with kernel 2.6.13.2, and am wanting to get 
> going with SELinux.  I know that Timothy Wood had made some packages in 
> the past, but his site (as listed on the SELinux for Distrubtions page) 
> gives a 403 error.

Yes, looks like the old URL is dead.  But looking at his top-level site
(which redirects to his blog now), I see a reference to
ftp://ftp.diyab.net/selinux/ as the new location for his Slackware
selinux packages.  Looks a little dated (based off the 9 March 2005
release of SELinux).

> I don't mind installing it all myself, but I am not sure where to start. 
>   I do know I will need PAM, as Slackware does not include it by default.

SELinux doesn't strictly require the use of PAM; you can port it to
Slackware without necessarily converting to PAM.  Using SELinux without
PAM (and pam_selinux) just requires policy modifications to allow direct
program reading of /etc/shadow and direct patching of login.
pam_selinux was actually introduced by Red Hat when they integrated
SELinux into Fedora Core; prior to that, login was directly patched for
SELinux.  So an alternative path is to resurrect the old login patch for
SELinux and adjust policy accordingly.

> If someone could point me to some info to help guide me through this, or 
> provide such info, I would greatly appreciate it.  Thank you.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
