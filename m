Date: Wed, 29 Jun 2005 13:42:24 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, serue@us.ibm.com,
   linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: jail functionality
Message-ID: <20050629184224.GC19299@serge.austin.ibm.com>
References: <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil> <Xine.LNX.4.44.0506291402040.12494-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0506291402040.12494-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris (jmorris@redhat.com):
> On Wed, 29 Jun 2005, Stephen Smalley wrote:
> 
> > > The attached task-lookup patches?
> > 
> > Not sure it provides much value.
> 
> If yoy need this, why not look at proper isolation via Xen?

Xen may be overkill for some cases, as you need (almost) a whole OS
for each jail.  Zones and bsd jails (I believe) should easily be
able to run hundreds of jails - provided of course they don't all
peak at once.

Don't get me wrong, I'm a big fan of virtualization, and while I
don't get to right now, IBM is putting a lot of effort into Xen.

> LSM is about access control, not virtualization.

And jails require some amount of access control.  I don't want to
introduce a new LSM for this, but just put together the various
existing (and not-yet-existing) pieces into an easy to use package.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
