Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79I7mhU026494
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 14:07:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79I7kVe013844
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:07:47 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <162335.27499.qm@web36605.mail.mud.yahoo.com>
References: <162335.27499.qm@web36605.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 11/14] CacheFiles: Permit an inode's security ID to be obtained [try #2]
Date: Thu, 09 Aug 2007 19:06:55 +0100
Message-ID: <20932.1186682815@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> This is SELinux specific functionality. It should not be an LSM
> interface. 

This is what I worked out in conjunction with the denizens of the SELinux
mailing list.  What would you have me do differently?  Change things like:

	u32 (*act_as_secid)(u32 secid);

to something like:

	void (*act_as_secid)(const char *newsecdata, u32 newseclen,
			     char *oldsecdata, u32 *oldseclen);

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
