Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14359
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:52:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1JHqJI00241
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:52:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1JHqIf00237 for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:52:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: Apache policy
Date: Wed, 19 Feb 2003 18:52:09 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0302191214530.8893-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0302191214530.8893-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302191852.09896.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Feb 2003 18:39, Wayne Salamon wrote:
> On Wed, 19 Feb 2003, Russell Coker wrote:
> > >   - Does $1_t need create permissions for script_exec_t? (around line
> > > 88)
> >
> > No.  I can't find that in the version I sent you or the one in my current
> > tree either.
>
>   I meant, do we need to add this rule so users can relabel files as
> httpd_user_script_exec_t? We also need a rule for sysadm_r to create
> httpd_sys_script_exec_t, right?

Yes.  I'll have to add that.

> > I've just removed httpadm.te entirely from my tree.  My changes remove
> > the need for it entirely.
>
>   OK, but doing that requires a change to our rbac file, and yours and our
> openca-ca.te, I think. You want to remove httpd_admin_r and httpd_admin_t
> entirely, right?

Yes, I've done that in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
