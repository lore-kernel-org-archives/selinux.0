Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0FMNG46024562
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 17:23:16 -0500
Received: from web36614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0FMNEJK002070
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 22:23:14 GMT
Date: Tue, 15 Jan 2008 14:23:14 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Daniel J Walsh <dwalsh@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <6778.1200434110@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <372376.51168.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > The cache files are created by the cachefiles kernel module, not by the
> > userspace daemon, and the userspace daemon doesn't need to directly
> > read/write them at all
> 
> That is correct.
> 
> > (but I think it does need to be able to unlink them?).
> 
> Indeed.
> 
> > The userspace daemon merely identifies the directory where the cache should
> > live as part of configuring the cache when enabling it.
> 
> That is the way it currently works, yes.
>  
> > Hence, it is fine to use a fixed label for the cache files (systemhigh
> > in a MLS world), and to let the directory's label serve as the basis for
> > it.
> 
> That is what I currently do.  SELinux rules are provided to grant the
> appropriate file accesses to the override label used by the kernel module, so
> that it can't go and stamp on files with the wrong label.
> 
> > Only the cachefiles kernel module directly reads and writes the files.
> 
> Correct.

Well, my bad, and thank you for clearing up my misunderstanding.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
