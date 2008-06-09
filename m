Date: Tue, 10 Jun 2008 09:37:40 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: more user friendly unknown handling printk
In-Reply-To: <1213044697.4597.26.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0806100937240.25308@us.intercode.com.au>
References: <1213044697.4597.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Jun 2008, Eric Paris wrote:

> I've gotten complaints and reports about people not understanding the
> meaning of the current unknown class/perm handling the kernel emits on
> every policy load.  Hopefully this will make make it clear to everyone
> the meaning of the message and won't waste a printk the user won't care
> about anyway on systems where the kernel and the policy agree on
> everything.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Looks good to me, applied.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
