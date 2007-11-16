Date: Sat, 17 Nov 2007 09:12:13 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        alan@redhat.com, chrisw@redhat.com, hpa@zytor.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] security: allow capable check to permit mmap or low
 vm space
In-Reply-To: <1195250840.2924.113.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0711170911140.31014@us.intercode.com.au>
References: <1195246545.2924.88.camel@localhost.localdomain>
 <Xine.LNX.4.64.0711170845050.22208@us.intercode.com.au>
 <1195250009.2924.103.camel@localhost.localdomain>
 <Xine.LNX.4.64.0711170856200.22208@us.intercode.com.au>
 <1195250840.2924.113.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Nov 2007, Eric Paris wrote:

> When this protection was originally concieved it intentionally was
> offing something even without an more 'full featured' LSM.  That was the
> whole reason I had to drop the secondary stacking hook inside the
> selinux code.
> 
> While I now understand the question, I think that this is the behavior
> most people would want.  I'll revert the security enhancement for
> non-LSM systems if others agree with James, but I think adding another
> small bit of protection against kernel flaws for everyone who wants
> security is a win.  (and remember, in kernel we still default this to
> off so noone is going to 'accidentally' see and security checks in the
> dummy hooks)

If it's off by default and generally useful across LSMs, why not just put 
it in the base kernel code?


- James
-- 
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
