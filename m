Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7BFkrdV007224
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 11:46:53 -0400
Received: from web36610.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k7BFkgmM029217
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 15:46:43 GMT
Message-ID: <20060811154646.36452.qmail@web36610.mail.mud.yahoo.com>
Date: Fri, 11 Aug 2006 08:46:46 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1155308294.8018.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Karl MacMillan <kmacmillan@mentalrootkit.com>
wrote:

> >   There is
> > no option to let install(1) apply XATTR
> attributes.
> 
> Is there a need for this? I have no idea.

The Irix xattr experiance, wherein inst(1) did
not do extended attributes, leads me to suggest
strongly that install(1) be enhanced to do so.

> 
> >   Nor mkdir, mkfifo,
> > mknod.  Similarly for the ACL support that's
> widely available, there is
> > no option to let those programs apply a specified
> ACL.  Why should
> > SELinux security contexts be treated differently?

When an attribute is optional (e.g. an ACL)
and the object is useful without it, there's
no issues. Whan an attribute is required
(e.g. a sensitivity label) it's a fish of
another color. Since every file needs a
sensitivity, and the install program is
responsible for the initial state of the
file, install needs to set it. Sure, you
can put together a multipass scheme if
you can't put it in install, but that's
another divergence.

> Acls are a discretionary mechanism and it is,
> therefore, appropriate for
> them to be applied by users after file creation.
> 
> SELinux is fundamentally different as a mandatory
> mechanism and a core
> property is that objects should be labeled correctly
> at creation time.

Yes. My experiance with xattrs backs Karl's
arguments from here.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
