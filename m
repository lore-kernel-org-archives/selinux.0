Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <955428.96537.qm@web36609.mail.mud.yahoo.com>
References: <955428.96537.qm@web36609.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 11:27:12 -0400
Message-Id: <1181921232.17547.775.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-15 at 08:14 -0700, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Second RFC on this patch, collects up discussion and changes so far.  If
> > no objections, then this will be re-posted as just a [PATCH] on selinux
> > and lkml.
> > 
> > ---
> > 
> > Extend SELinux to allow capabilities to be granted authoritatively
> > based solely on SELinux policy, enabling users of SELinux to
> > selectively reduce or fully eliminate the need for a "root" user and
> > setuid executables.  This provides an alternative approach to file
> > capabilities without conflicting with it.
> 
> Why don't you just work with the people who are getting the
> file capabilities working and integrate that into SELinux?
> Why do you have to take this tangent and confuse everything?
> 
> There. An objection. I do not believe you've demonstrated that
> using the proposed file capabilities can't get you what you
> want, and that we don't need two implementations of the same
> thing.

I don't think you've taken the time to read and understand the
description or the code, or you might realize that your characterization
above is false.

I did provide feedback to Serge on the file capabilities support as it
was being developed.  It will work with SELinux, with or without this
change.  But it doesn't solve the same problem.  Read it again.  Please.
And Serge, who authored the file capability support, understands that,
and appears to like our patch from his comments on list.  So there is no
conflict between us and the "file capabilities" people, only between us
and people who don't bother to take the time to understand what they are
commenting on...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
