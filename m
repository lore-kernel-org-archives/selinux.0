Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j32CTaDo019255
	for <selinux@tycho.nsa.gov>; Sat, 2 Apr 2005 07:29:36 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j32CPEkl025877
	for <selinux@tycho.nsa.gov>; Sat, 2 Apr 2005 12:25:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [ PATCH ] X clients cleanup Patch #3
Date: Sat, 2 Apr 2005 22:27:38 +1000
Cc: ivg2@cornell.edu, selinux@tycho.nsa.gov
References: <1112308113.17917.9.camel@cobra.ivg2.net> <1112416291.7982.7.camel@cobra.ivg2.net> <424E8A49.2090408@redhat.com>
In-Reply-To: <424E8A49.2090408@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504022227.40688.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 02 April 2005 22:04, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Do we want to remove tmpfs_domain from base_user_domain.  I would prever
> to have policy where X privs for users is optional.
> Think eventually about loadable modules, where you have a X user support
> module.  Server users need a lot less privs.

When you say "X is optional" do you mean to have a boolean or to have it 
optional at compile time?

If a boolean then we would probably have the boolean not stop tmpfs access.  
If optional at compile time then we certainly want tmpfs_domain in 
base_user_domain.

I think that in any case we probably want tmpfs_domain in base_user_domain 
just for best structure of policy.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
