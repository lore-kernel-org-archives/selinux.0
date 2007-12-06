Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB61eG3h009790
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2007 20:40:16 -0500
Received: from web36613.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB61eFOu021498
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 01:40:15 GMT
Date: Wed, 5 Dec 2007 17:40:15 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 4/7] KEYS: Add keyctl function to get a security label
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Cc: dhowells@redhat.com, casey@schaufler-ca.com, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <25702.1196904505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <289732.78389.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > inode_getsecurity and getprocattr directly return the strings.
> > Admittedly, the whole interface could be cleaned up and made far more
> > consistent, but I don't think he necessarily has to go through the
> > getsecid + secid_to_secctx sequence if he only wants the secctx.
> 
> It's what Daniel Walsh wanted.

Name dropper. And we don't have a convention, really. So go ahead
with key_getsecurity or key_getsecctx, as you choose. At some point
we should either change inode_getsecurity to inode_getsecctx or
secid_to_secctx to secid_to_security. Not the problem of the day.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
