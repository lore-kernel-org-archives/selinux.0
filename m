Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0FIGsd5023889
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 13:16:54 -0500
Received: from web36613.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0FIGr70004125
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 18:16:53 GMT
Date: Tue, 15 Jan 2008 10:10:12 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <32507.1200412997@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <286481.40953.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > >  (3) Check that the kernel may create files as a particular secid (this
> > >      could be specified indirectly by specifying an inode, which would
> > >      hide the secid inside the LSM).
> > 
> > I don't think this check is on the kernel per se but rather the ability
> > of the daemon to nominate a secid for use on files created later by the
> > kernel module.
> 
> Hmmm...  At the moment the cachefiles module works out for itself what the
> file label should be by looking at the root directory it was given and
> assuming the label on that is what it's going to be using.  Are you
> suggesting
> this should be specified directly instead by the daemon?

Oh my. While there will be cases where the label of the file
will match the label of the containing directory, and in fact
for most label based LSMs that will usually be the case, you
certainly can't count on it. The only place that you can find
the correct label for a file with any confidence in from the
xattr (assuming the LSM uses xattrs) on the file itself. I can
imaging an LSM for which it would make sense to derive the
label from the root directory, but I know Smack isn't one of
them, and I don't think that SELinux is either, although I
would defer a definitive answer on that to Stephen.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
