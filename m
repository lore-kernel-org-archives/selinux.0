Subject: Re: does mv need a --context=CTX (-Z) option, too?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Meyering <jim@meyering.net>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <44DB4585.3070500@redhat.com>
References: <87hd0kc308.fsf@rho.meyering.net>
	 <1155218058.1123.301.camel@moss-spartans.epoch.ncsc.mil>
	 <874pwkll7v.fsf@rho.meyering.net>  <44DB4585.3070500@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:03:16 -0400
Message-Id: <1155225796.8018.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-10 at 10:41 -0400, Daniel J Walsh wrote:
> Jim Meyering wrote:
> > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >   

<snip>

> > Stepping back a little, if mv doesn't need the option, then why
> > does cp need it?  After all, cp has no option to set classic
> > permissions.
> >
> >   
> I agree cp should not need this qualifier.  It should either be preserve 
> or get the new default context.
> mv should just try to preserve

Agreed.

> install should use the matchpathcon similar to rpm.

Though this should be optional because it is fairly expensive. Also,
there is at least some existing software that uses install --context, so
I would hate to see that go.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
