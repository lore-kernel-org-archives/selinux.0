Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAMMAJIi008320
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 17:10:19 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAMM8mlx012374
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 22:08:49 GMT
Subject: Re: Ok, I know this has been asked before, but why is there an
	ls_exec_t?
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux list <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <41A24D29.1010000@redhat.com>
References: <41A24D29.1010000@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 09:10:12 +1100
Message-Id: <1101161412.30097.85.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ls_exec_t is for ftpd.  But as ftp servers seem to either be moving in
the direction of minimal functionality and ls being built in or of
maximum functionality which includes automatically running tar and gzip
it seems that this isn't providing much benefit.

On Mon, 2004-11-22 at 15:33 -0500, Daniel J Walsh wrote:
> Is there really a good reason for hostname_exec_t?

Yes, it means that we can reduce the access granted to initrc_t.  But if
you have unlimitedRC then it provides no benefit.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
