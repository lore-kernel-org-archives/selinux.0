Date: Wed, 12 Mar 2008 09:05:25 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: printk normalization
In-Reply-To: <1205265613.5297.131.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0803120903030.8423@us.intercode.com.au>
References: <1205265613.5297.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Mar 2008, Eric Paris wrote:

> Attach a KERN_* to the front of every printk and make sure that every
> printk ends with a \n
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Nack.  

I just removed all of the "security:" prefixes in the for-akpm branch -- 
please patch against that.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
