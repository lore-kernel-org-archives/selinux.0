Date: Thu, 20 Mar 2008 02:24:53 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, chrisw@sous-sol.org,
        hch@lst.de, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nfsv4@linux-nfs.org
Subject: Re: [RFC]Introduce generalized hooks for getting and setting inode
 secctx v3
In-Reply-To: <522307.23148.qm@web36604.mail.mud.yahoo.com>
Message-ID: <Xine.LNX.4.64.0803200224100.7096@us.intercode.com.au>
References: <522307.23148.qm@web36604.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Mar 2008, Casey Schaufler wrote:

> Oh, cut the crap. What part of my explainations don't you understand?
> 
> I understand the functionality. That is not my point. My point is
> that inode_notifysecctx() explicitly prohibits the LSM from providing
> integrity of the security attributes by introducing a differentiation
> between the "in-core" and "on-disk" values, and making it explicit
> that the one is set, but not the other.
> 
> Clearly this is the direction you intend to go. Have fun with it.
> I've raised the issue, y'all aren't seeing it. Maybe I'm wrong,
> it has happened before.

Please stop trolling.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
