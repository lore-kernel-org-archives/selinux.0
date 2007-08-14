From: David Howells <dhowells@redhat.com>
In-Reply-To: <462850.65153.qm@web36605.mail.mud.yahoo.com>
References: <462850.65153.qm@web36605.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
Date: Tue, 14 Aug 2007 10:39:57 +0100
Message-ID: <1079.1187084397@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> With Smack you can leave the label alone, raise CAP_MAC_OVERRIDE,
> do your business of setting the label correctly, and then drop
> the capability. No new hooks required.

That sounds like a contradiction.  How can you both leave it alone and set it?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
