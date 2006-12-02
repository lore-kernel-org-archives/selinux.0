Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB20LS7F024537
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 19:21:28 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB20Khd3016335
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 00:20:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Linda Knippers <linda.knippers@hp.com>
Subject: Re: User home directory creation with useradd (rhbz#217441)
Date: Sat, 2 Dec 2006 11:21:43 +1100
Cc: James Antill <jantill@redhat.com>, selinux@tycho.nsa.gov
References: <1165003691.18588.103.camel@code.and.org> <457094DA.4080704@hp.com>
In-Reply-To: <457094DA.4080704@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612021121.45703.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 02 December 2006 07:47, Linda Knippers <linda.knippers@hp.com> 
wrote:
> > 1. Have an option for useradd to call semanage to add the selinux user,
> > and then do the restorecon.
>
> I think useradd should be able to either create the selinux user or map the
> linux user to an existing selinux user.  Right now you can't create an
> selinux user without a linux login

I think that this is a bug.  You should be able to create SE Linux users 
without Linux logins, if only for the case of a NIS/LDAP server being down at 
SE Linux user creation time.

> but I think I ought to be able to create 
> the selinux users separate and them map one or more linux login to each
> one, or have useradd create a unique linux user for me if I choose.  And if
> I don't choose, the linux user should end up with the correct home
> directory based on the default selinux user.

I think that part of the solution is to have semanage call useradd.

> > 2. Have semanage do the equivalent of a restorecon when doing an
> > add/modify (or just add) of SELinux user information.
>
> If the semanage is done after the useradd (could be weeks after), the
> user could have files that live outside the home directory (I think
> Dan pointed this out to me) so what files and directories would you
> run restorecon on?

Also for a MLS environment you can't just relabel the files unless the new 
sensitivity label dominates the old.  For a strict policy system it's 
generally acceptable for relabel the files, but for MLS that won't work.

> > 3. Have some kind of wrapper that does:
> > 	i. useradd
> > 	ii. semanage
> > 	iii. restorecon
>
> I don't like the wrapper idea because if we can do it in a wrapper,
> we can do it in useradd.

Or semanage, or do it in both and give the sys-admin a choice.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
