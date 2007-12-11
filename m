Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBLIJX5016213
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 16:18:19 -0500
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBBLIHEe022291
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 21:18:18 GMT
Date: Tue, 11 Dec 2007 13:18:12 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
To: David Howells <dhowells@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <9789.1197405725@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <395440.2938.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

...
> 
> How about I just stick the context in /etc/cachefilesd.conf as a textual
> configuration item and have the daemon pass that as a string to the
> cachefiles
> kernel module, which can then ask LSM if it's valid to set this context as an
> override, given the daemon's own security context?  That seems entirely
> reasonable to me.

Works for Smack. I can't say definitively, but I think it will
work for SELinux. Beyond that and we're into the fuzzy bit of the
LSM.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
