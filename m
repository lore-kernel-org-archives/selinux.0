Date: Tue, 27 Nov 2007 08:42:59 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: [patch 1/1] selinux:  detect dead booleans
In-Reply-To: <1196093573.26679.4.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0711270842420.4363@us.intercode.com.au>
References: <1196093573.26679.4.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Nov 2007, Stephen Smalley wrote:

> Instead of using f_op to detect dead booleans, check the inode index
> against the number of booleans and check the dentry name against the
> boolean name for that index on reads and writes.  This prevents
> incorrect use of a boolean file opened prior to a policy reload while
> allowing valid use of it as long as it still corresponds to the same
> boolean in the policy.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
