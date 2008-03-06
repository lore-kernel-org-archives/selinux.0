Date: Fri, 7 Mar 2008 01:25:36 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
 LSM security context information.
In-Reply-To: <20080306140713.GA20087@infradead.org>
Message-ID: <Xine.LNX.4.64.0803070124160.2139@us.intercode.com.au>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
 <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov> <20080306123013.GB4648@lst.de>
 <1204811422.1397.205.camel@moss-spartans.epoch.ncsc.mil>
 <20080306135444.GA5216@infradead.org> <1204812304.1397.213.camel@moss-spartans.epoch.ncsc.mil>
 <20080306140713.GA20087@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 6 Mar 2008, Christoph Hellwig wrote:

> Ok, this makes a lot more sense.  These defintively should be different
> hooks in that case, and no matter what name they have (no good ideas
> from me either currently)

Perhaps setsecctx and storesecctx ? 



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
