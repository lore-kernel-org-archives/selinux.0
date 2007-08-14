From: David Howells <dhowells@redhat.com>
In-Reply-To: <861956.50630.qm@web36613.mail.mud.yahoo.com>
References: <861956.50630.qm@web36613.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
Date: Tue, 14 Aug 2007 18:58:00 +0100
Message-ID: <9409.1187114280@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Whoops, sorry. You leave the process label alone and explicitly
> set the file label using the xattr interfaces.

That's the wrong way to do things.  There'd then be a window in which
cachefilesd (the userspace daemon) could attempt to view the file when the
file has the wrong label attached.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
