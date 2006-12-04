Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4JYEfX032457
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 14:34:14 -0500
Received: from web36610.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kB4JWT5U026326
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 19:32:29 GMT
Date: Mon, 4 Dec 2006 11:34:39 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: User home directory creation with useradd (rhbz#217441)
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <457464A6.7000005@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <669208.32994.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Karl MacMillan <kmacmillan@mentalrootkit.com>
wrote:

> Casey Schaufler wrote:
> > --- Linda Knippers <linda.knippers@hp.com> wrote:
> > 
> > 
> >> I don't want more stuff in semanage.  We should
> be
> >> able to do it from
> >> useradd, and from one role.  Right now its a
> multi
> >> step operation and
> >> we can't run useradd and semanage from the same
> >> role.  Only sysadm_r
> >> can run useradd and only secadm_r can run
> semanage
> >> with the current
> >> MLS policy.
> > 
> > While this is inconvenient, it is consistant
> > with the separation of roles. You might want
> > a role explictitly for this function.
> > Experiance on other systems has been that
> > neither the secadm nor the sysadm roles are
> > sufficient for adding a user by themselves,
> > nor should they be.
> > 
> 
> It should be configurable via policy, which means
> the code should be 
> present in useradd. The vast majority of SELinux
> systems shipped don't 
> have a secadm role. For that configuration the
> sysadm should be able to 
> create a user and a user mapping in a single step.

Hmm. It that case you could rename the role,
maybe something simple and easy to spell.

How about "root"?

I started out on this thinking that I was
being clever, but I seriously think that is
what you ought to do, rather than trying to
define some role that is somehow restricted
yet able to add users. If the arguement is
that separated roles are too hard to deal
with* and that many people won't deal with
them, I say accept it, acknowlege it,
accomodate it, and move on.

------
* I don't like administrative role separation
  myself, but my predjudices are based on a
  long history with Unix and many many (mostly
  really bad) administrative interfaces.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
