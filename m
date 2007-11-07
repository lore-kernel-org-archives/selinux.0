Date: Thu, 8 Nov 2007 09:22:53 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] selinux:  add more validity checks on policy load
In-Reply-To: <1194448080.3956.28.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0711080922320.12061@us.intercode.com.au>
References: <1194448080.3956.28.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Nov 2007, Stephen Smalley wrote:

> Add more validity checks at policy load time to reject malformed
> policies and prevent subsequent out-of-range indexing when in permissive
> mode.  Resolves the NULL pointer dereference reported in
> https://bugzilla.redhat.com/show_bug.cgi?id=357541.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-linus


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
