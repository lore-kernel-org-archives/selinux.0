Date: Mon, 17 Sep 2007 14:56:46 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: Improving SELinux read/write performance
In-Reply-To: <1190061915.4034.78.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0709171456150.16840@us.intercode.com.au>
References: <20070914092048.C8F1.YNAKAM@hitachisoft.jp>
 <1190061915.4034.78.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Sep 2007, Stephen Smalley wrote:

> > It reduces the selinux overhead on read/write by only revalidating
> > permissions in selinux_file_permission if the task or inode labels have
> > changed or the policy has changed since the open-time check.  A new LSM
> > hook, security_dentry_open, is added to capture the necessary state at
> > open time to allow this optimization.
> > 
> > Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
> 
> Thanks, looks good.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
