Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71C0QrT006600
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 08:00:26 -0400 (EDT)
Received: from smtp809.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71Bxs52020642
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 11:59:54 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp809.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 12:00:25 -0000
Date: Sun, 1 Aug 2004 13:11:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040801121128.GH7384@lkcl.net>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <200407311143.19746.russell@coker.com.au> <20040731163515.GR3378@lkcl.net> <200408012031.37581.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408012031.37581.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 08:31:37PM +1000, Russell Coker wrote:

> Yes.  So we need to have different mounts of the shmfs get different types.
> 
> >  what _you_ are saying, russell, is that instead of increasing the
> >  permissions on the usage of tmpfs_t, is to mount a tmpfs mountpoint,
> >  then run setfiles on its contents prior to use, such that it will
> >  never be necessary to increase the permissions of tmpfs_t?
> 
> Yes.  In fact using tmp_t as the label on the root directory of /dev/shm so 
> that file/directory creation gets the same labels as it does under /tmp, 
> while we leave tmpfs_t with restrictive access.
> 
> >  because tmpfs_t is going to be temporary, you _have_ to do a setfiles
> >  (or a restorecon on each individual file) _anyway_.
> 
> If /dev/shm is mounted before the system goes to multi-user mode then there 
> will be no files under it and no need for labelling other than the root 
> directory.

 okay, so in fs_use i change
 
	 fs_use_trans tmpfs ....:tmp_t

 NOT the shm one :)

 got that the wrong way round first time i think.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
