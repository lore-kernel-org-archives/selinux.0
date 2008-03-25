Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>
In-Reply-To: <200803251525.19624.russell@coker.com.au>
References: <47E7E7A5.6090603@manicmethod.com>
	 <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
	 <200803251525.19624.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 25 Mar 2008 07:42:31 -0400
Message-Id: <1206445351.3302.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-25 at 15:25 +1100, Russell Coker wrote:
> On Tuesday 25 March 2008 07:15, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > The real issue with run_init isn't the re-authentication stage, as that
> > can always be disabled via pam config (and was just a weak form of
> > confirming user intent, not an authorization mechanism), but rather the
> > difficulty in transparently interposing it into all situations where
> > services get started/re-started.  Only Gentoo seemed to have a good
> > story there.
> 
> In Red Hat distributions the command "service" is well documented, and last 
> time I checked it was the only documented way of restarting daemons.
> 
> If the "service" command was modified to call run_init then a large part of 
> that problem would be solved.  It would not be unreasonable to demand that 
> people who use the strict or mls policy also exclusively use "service" 
> instead of running the script directly.

That was what we thought originally, and IIRC, Dan originally modified
service to invoke run_init during early Fedora SELinux integration.
Only to find out just how many things bypass it, like rpm %post
scriptlets and admins from the shell ;)

> 
> > I'm not sure why anyone needs to add users to policy via semanage users
> > given the base set of generic users and the ability to map Linux users
> > to them via seusers aka semanage login.
> 
> Roles?
> 
> Also I like to be able to run "ls -Z" to see the SE Linux identity of the 
> person who created the file.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
