Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91E49sJ025242
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 10:04:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h91E487d005857
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 14:04:08 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h91E3tRn005817 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 14:03:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: shlib_t vs lib_t for symbolic links
Date: Thu, 2 Oct 2003 00:03:47 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310012152.38059.russell@coker.com.au> <1065014575.350.24.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065014575.350.24.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310020003.47098.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003 23:22, Stephen Smalley wrote:
> On Wed, 2003-10-01 at 07:52, Russell Coker wrote:
> > Is there any reason why the symbolic links under /lib and /usr/lib have
> > type shlib_t instead of lib_t?
>
> No, this is just a result of the types.fc entries for shared object
> (.so) files not being limited to regular files.

OK, that's already fixed.  ;)

I've just gone through the file_contexts tree, specified the type of every 
entry where it was possible to do so, I've tested about the core stuff and 
I'll test most of the rest tomorrow (apart from things like vmware which I 
don't use).

> As a side note, for least privilege, it would be good to split up
> shlib_t and bind specific programs to executing specific shared objects,
> particularly for programs that are privileged.

Do you have any particular examples in mind?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
