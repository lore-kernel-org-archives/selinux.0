Date: Sun, 23 Sep 2007 16:08:04 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov,
        sgrubb@redhat.com
Subject: Re: [PATCH -v4] kernel: selinux: policy selectable handling of
 unknown classes and perms
In-Reply-To: <1190588561.3451.165.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0709231606340.14361@us.intercode.com.au>
References: <1190399830.3451.145.camel@localhost.localdomain>
 <Xine.LNX.4.64.0709231431320.23411@us.intercode.com.au>
 <1190588561.3451.165.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 23 Sep 2007, Eric Paris wrote:

> On Sun, 2007-09-23 at 14:39 -0700, James Morris wrote:
> 
> > > +
> > > +	unsigned int reject_unknown : 1;
> > > +	unsigned int allow_unknown : 1;
> > > +	u32 *undefined_perms;
> > 
> > Why two separate bitfields ?
> 
> You mean why did we split from a single "handle_unknown" to using 2
> separate bits?  See the message from Eamon

No, I misread the patch, ignore.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
