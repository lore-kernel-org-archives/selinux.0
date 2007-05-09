From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] Coalesce setfiles and restorecon into a single program
Date: Wed, 9 May 2007 10:51:33 +1000
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <1178306387.677.14.camel@moss-spartans.epoch.ncsc.mil> <1178637238.25354.29.camel@localhost.localdomain> <1178638454.6056.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1178638454.6056.58.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705091051.36742.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 May 2007 01:34, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Ok.  Does anyone have any comments on the policy issue for setfiles vs.
> restorecon?  Should we just collapse restorecon_t and restorecon_exec_t
> down to typealiases for setfiles_t and setfiles_exec_t for
> compatibility?  Or do we need to keep them separated?  In the past, some
> people have suggested that restorecon is "safer" since it doesn't let
> the caller specify the file contexts file, but I tend to view that as
> illusory.

It makes sense to me, both collapsing the domains and merging the two 
programs.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
