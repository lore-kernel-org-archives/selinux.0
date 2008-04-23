Date: Thu, 24 Apr 2008 09:47:57 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov, mszeredi@suse.cz,
        casey@schaufler-ca.com
Subject: Re: [PATCH -v3] LSM/SELinux: show LSM mount options in /proc/mounts
In-Reply-To: <1208980437.2985.120.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0804240947260.4325@us.intercode.com.au>
References: <1208980437.2985.120.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Apr 2008, Eric Paris wrote:

> This patch causes SELinux mount options to show up in /proc/mounts.  As
> with other code in the area seq_put errors are ignored.  Other LSM's
> will not have their mount options displayed until they fill in their own
> security_sb_show_options() function.
>     
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-linus


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
