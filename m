Subject: Re: beginner to SE Linux policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark <elihusmails@gmail.com>
Cc: shahbaz khan <shazalive@gmail.com>, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
In-Reply-To: <9f066ee90708071056j74618a8akd860ef084f055243@mail.gmail.com>
References: <9f066ee90707271204p2bfe6da7k4f8f50798c50c2e8@mail.gmail.com>
	 <7b740b700707280714u72d59b83j3f6c3065d15e2b79@mail.gmail.com>
	 <9f066ee90708071056j74618a8akd860ef084f055243@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 15:19:07 -0400
Message-Id: <1186514347.26457.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-07 at 13:56 -0400, Mark wrote:
> Thanks for the help.  I just want to become more familiar with SE
> Linux and understand the context of the te, fe, if..etc files and how
> I can modify them so that my programs are more secure.  There just
> seems to be alot of information that may or may not be related in
> order to help me.  For instance, there is the seedit tools, SLIDE and
> RedHat tools available.  Also, which is a better distribution to learn
> SE Linux, CentOS or Fedora Core? 

Fedora Core tracks the latest SELinux developments more closely.

The reference policy documentation should help you, online at
http://oss.tresys.com/projects/refpolicy/wiki/Documentation and if you
have selinux-policy installed, locally available docs
under /usr/share/doc/selinux-policy-x.y.z/.

SLIDE is an eclipse plugin that leverages reference policy and provides
the typical IDE-style auto-completion, interface lookup, wizards for
constructing domains, etc.  Useful if you are ok working in an IDE.

SEEdit is more about hiding the underlying abstractions and presenting a
very simple UI.  Requires switching to its own policy entirely, away
from the stock policy.

> I am an application developer who really just needs to learn how to
> write policies for the programs I am developing.  Things like
> policies, domains and domain transition are important areas I really
> want to learn. 

There are a number of resources, e.g. see
http://selinux.sourceforge.net/resources.php3 , but many of them predate
the reference policy.  Reference policy documentation and SLIDE are your
best bets right now, along with the book.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
