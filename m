Subject: Re: [PATCH 3/3] security: allow capable check to permit mmap or
	low vm space
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        alan@redhat.com, chrisw@redhat.com, hpa@zytor.com,
        akpm@linux-foundation.org
In-Reply-To: <Xine.LNX.4.64.0711170911140.31014@us.intercode.com.au>
References: <1195246545.2924.88.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0711170845050.22208@us.intercode.com.au>
	 <1195250009.2924.103.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0711170856200.22208@us.intercode.com.au>
	 <1195250840.2924.113.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0711170911140.31014@us.intercode.com.au>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 11:54:41 -0500
Message-Id: <1195577681.2912.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-11-17 at 09:12 +1100, James Morris wrote:
> On Fri, 16 Nov 2007, Eric Paris wrote:
> 
> > When this protection was originally concieved it intentionally was
> > offing something even without an more 'full featured' LSM.  That was the
> > whole reason I had to drop the secondary stacking hook inside the
> > selinux code.
> > 
> > While I now understand the question, I think that this is the behavior
> > most people would want.  I'll revert the security enhancement for
> > non-LSM systems if others agree with James, but I think adding another
> > small bit of protection against kernel flaws for everyone who wants
> > security is a win.  (and remember, in kernel we still default this to
> > off so noone is going to 'accidentally' see and security checks in the
> > dummy hooks)
> 
> If it's off by default and generally useful across LSMs, why not just put 
> it in the base kernel code?

It was placed in CONFIG_SECURITY so that users can (If their given LSM
supports it) selectively allow this stuff.  Some LSMs are fine grained
enough to allow applications like dosemu and X to use low pages without
globally disabling.  I can't think of any reasonable way to move all of
this into base kernel code while still allowing overrides.

I'd love to hear suggestions on how to move all of this out of the
security code and into the base kernel while not neglecting those few
users who need this functionality.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
