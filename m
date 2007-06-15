Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5FFEPKu020533
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 11:14:25 -0400
Received: from web36609.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5FFEOoK029877
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 15:14:24 GMT
Date: Fri, 15 Jun 2007 08:14:08 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1181917726.17547.750.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <955428.96537.qm@web36609.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Second RFC on this patch, collects up discussion and changes so far.  If
> no objections, then this will be re-posted as just a [PATCH] on selinux
> and lkml.
> 
> ---
> 
> Extend SELinux to allow capabilities to be granted authoritatively
> based solely on SELinux policy, enabling users of SELinux to
> selectively reduce or fully eliminate the need for a "root" user and
> setuid executables.  This provides an alternative approach to file
> capabilities without conflicting with it.

Why don't you just work with the people who are getting the
file capabilities working and integrate that into SELinux?
Why do you have to take this tangent and confuse everything?

There. An objection. I do not believe you've demonstrated that
using the proposed file capabilities can't get you what you
want, and that we don't need two implementations of the same
thing.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
