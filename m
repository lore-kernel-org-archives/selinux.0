Date: Wed, 12 Dec 2001 08:54:46 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: Undefined refs in compile attempt
In-Reply-To: <20011212014335.GA16538@vnl.com>
Message-ID: <Pine.GSO.4.33.0112120840590.6865-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 12 Dec 2001, Dale Amon wrote:

> Not sure why I'm getting failures in the compile. I applied all
> of the patches before starting:
>
>   532  tar zxf sm-selinux-200111191100.tgz

Although this isn't related to your problem, you might want to use the
latest release (2001121010).  Of course, you will still need to apply
the module.patch and the util-linux.patch that I posted yesterday after
that release was made.

>   541  cd selinux
>   542  patch -p1 < ../delete.patch
>   543  patch -p1 < ../avc.patch
>   544  patch -p1 < ../module.patch

This should have failed.  The module.patch posted yesterday was relative
to the latest release, so it expected the module to already be in the lsm
tree (the SELinux module has been merged into the main LSM tree, and no
longer lives in the selinux archive).

>   545  patch -p1 < ../util-linux.patch
>   547  cd module
>   548  make insert
>   549  cd ../../lsm
>   550  patch -p1 < ../module.patch

Ok, it looks like you reapplied the patch correctly here.

> At which point a make install fails:
>
> cc -o checkpolicy ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o checkpolicy.o -lfl
> policydb.o: In function `user_destroy':
> /usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:357: undefined reference to `mls_user_destroy'

These errors indicate that you enabled the MLS option without making the
other changes described in the README.MLS file.  See the help text for
this option and the README.MLS file for more information.  As noted there,
the MLS policy component is considered experimental and has not been
configured for use.  Unless you really want to experiment with it, I
wouldn't recommend it.  Our focus has been on the RBAC and TE policies.
Of course, you can even express a MLS policy as a TE configuration if you
want, although the state space explodes if you have a lot of MLS levels.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
