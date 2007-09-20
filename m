Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8LJtIbD023878
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 15:55:18 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8LJtECG000114
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 19:55:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l8LJo9da001329
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 15:50:09 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l8LJo9JE001328
	for selinux@tycho.nsa.gov; Fri, 21 Sep 2007 15:50:09 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8K4CQuM028930
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 00:12:26 -0400
Received: from twinlark.arctic.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8K4CHj5029471
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 04:12:18 GMT
Message-ID: <46F1F2EE.1010904@kernel.org>
Date: Wed, 19 Sep 2007 21:11:26 -0700
From: Andrew Morgan <morgan@kernel.org>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/3] CRED: Move the effective capabilities into the cred
 struct
References: <20070919161749.8334.26064.stgit@warthog.procyon.org.uk> <20070919161805.8334.96808.stgit@warthog.procyon.org.uk>
In-Reply-To: <20070919161805.8334.96808.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Howells wrote:
> Move the effective capabilities mask from the task struct into the credentials
> record.
> 
> Note that the effective capabilities mask in the cred struct shadows that in
> the task_struct because a thread can have its capabilities masks changed by
> another thread.  The shadowing is performed by update_current_cred() which is
> invoked on entry to any system call that might need it.

OOC If we were to simply drop support for one process changing the
capabilities of another, would we need this patch?

Thanks

Andrew
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFG8fLrQheEq9QabfIRApPOAKCHAoazhTTpY/qSjdmRZxDptqeqiACfd4Q7
mdIPx+xpG19ih9uiVv1NSBU=
=TfZd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
