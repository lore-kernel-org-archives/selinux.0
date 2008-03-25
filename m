From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
Date: Tue, 25 Mar 2008 15:25:16 +1100
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>
References: <47E7E7A5.6090603@manicmethod.com> <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803251525.19624.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 25 March 2008 07:15, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The real issue with run_init isn't the re-authentication stage, as that
> can always be disabled via pam config (and was just a weak form of
> confirming user intent, not an authorization mechanism), but rather the
> difficulty in transparently interposing it into all situations where
> services get started/re-started.  Only Gentoo seemed to have a good
> story there.

In Red Hat distributions the command "service" is well documented, and last 
time I checked it was the only documented way of restarting daemons.

If the "service" command was modified to call run_init then a large part of 
that problem would be solved.  It would not be unreasonable to demand that 
people who use the strict or mls policy also exclusively use "service" 
instead of running the script directly.

> I'm not sure why anyone needs to add users to policy via semanage users
> given the base set of generic users and the ability to map Linux users
> to them via seusers aka semanage login.

Roles?

Also I like to be able to run "ls -Z" to see the SE Linux identity of the 
person who created the file.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
