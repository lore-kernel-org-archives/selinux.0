Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA23550
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 18:08:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA25677
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 22:06:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA25673
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 22:06:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: boot loader
Date: Tue, 23 Apr 2002 00:08:26 +0200
References: <Pine.GSO.4.33.0204221636350.28618-300000@raven>
In-Reply-To: <Pine.GSO.4.33.0204221636350.28618-300000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020422220826.EF5F645C95@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Apr 2002 22:39, you wrote:
> On Mon, 22 Apr 2002, Russell Coker wrote:
> > I've attached my new te file, and following is the lilo file_contexts
> > entries: /etc/lilo.conf                 
> > system_u:object_r:etc_bootloader_t /sbin/lilo.*                   
> > system_u:object_r:bootloader_exec_t
>
> Thanks.  I had to add a few permissions (search access to /dev, use
> descriptors created by newrole, write to the administrator's terminal) to
> bootloader.te.  The first attached patch shows the changes.  The second
> attached patch shows the changes to assert.te and admin_macros.te.

Thanks.

Also I added devfs_t to the following line:
allow bootloader_t { etc_t device_t devfs_t }:dir r_dir_perms;


-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
