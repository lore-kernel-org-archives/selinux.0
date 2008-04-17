Date: Fri, 18 Apr 2008 09:12:24 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, steved@redhat.com,
        jlayton@redhat.com, sds@tycho.nsa.gov, chuck.lever@oracle.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] NFS/LSM: Make NFSv4 set LSM mount options
In-Reply-To: <1208441091.2985.8.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0804180911570.23675@us.intercode.com.au>
References: <1204744818.3216.254.camel@localhost.localdomain>
 <1208441091.2985.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 17 Apr 2008, Eric Paris wrote:

> NFSv3 get_sb operations call into the LSM layer to set security options
> passed from userspace.  NFSv4 hooks were not originally added since it
> was reasonably late in the merge window and NFSv3 was the only thing
> that had regressed (v4 has never supported any LSM options)
> 
> This patch makes NFSv4 call into the LSM to set security options rather
> than just blindly dropping them with no notice to the user as happens
> today.  This patch was tested in a simple NFSv4 environment with the
> context= option and appeared to work as expected.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by: James Morris <jmorris@namei.org> 


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
