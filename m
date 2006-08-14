Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7EEuxYU023111
	for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2006 10:56:59 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7EEukmN025164
	for <selinux@tycho.nsa.gov>; Mon, 14 Aug 2006 14:56:47 GMT
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <87irkzfcgr.fsf@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155308294.8018.59.camel@localhost.localdomain>
	 <87irkzfcgr.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 10:56:44 -0400
Message-Id: <1155567404.23601.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-11 at 18:45 +0200, Jim Meyering wrote:
> Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> 

<snip>

> >>   Nor mkdir, mkfifo,
> >> mknod.  Similarly for the ACL support that's widely available, there is
> >> no option to let those programs apply a specified ACL.  Why should
> >> SELinux security contexts be treated differently?
> >
> > Acls are a discretionary mechanism and it is, therefore, appropriate for
> > them to be applied by users after file creation.
> >
> > SELinux is fundamentally different as a mandatory mechanism and a core
> > property is that objects should be labeled correctly at creation time.
> 
> If using chcon is sometimes not an option for a user who must be able
> to create files in a non-default context, then we have to choose between:
> 
>   1) adding the --context=CTX (-Z) option to many of the programs
>       that create a named output file.
> 
>   2) providing a tool to change the fscreate context for an exec'd program
> 
> The latter seems much cleaner.
> Is there any hope on that front?
> The problem is that if I add an options upstream, it's
> a big deal/hassle to remove it later, if a more appropriate
> mechanism becomes available.  As long as there's a hint
> of hope for a cleaner approach, I'm extremely reluctant
> to impose on the coreutils something that looks like a kludge.
> 

So your thinking is that the user would have to run a tool - e.g.:

fscon -t httpd_sys_content_t touch foo.html

Whether this is cleaner from an implementation perspective I think is
questionable, particularly because the restrictions (must have same
context as caller) will be confusing. This is especially with MLS.
Additionally, how are we going to then handle cases where the contexts
don't match (for example, running install in a different context to
limit what contexts it can set)?

More importantly to me, though, is that this mechanism will be much
harder to find for users and will break several years of documented
behavior. I think that the explicit options are the correct model from a
user perspective.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
