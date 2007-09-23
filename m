Subject: Re: [PATCH -v4] kernel: selinux: policy selectable handling of
	unknown classes and perms
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov,
        sgrubb@redhat.com
In-Reply-To: <Xine.LNX.4.64.0709231431320.23411@us.intercode.com.au>
References: <1190399830.3451.145.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0709231431320.23411@us.intercode.com.au>
Content-Type: text/plain
Date: Sun, 23 Sep 2007 19:02:41 -0400
Message-Id: <1190588561.3451.165.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-09-23 at 14:39 -0700, James Morris wrote:

> > +
> > +	unsigned int reject_unknown : 1;
> > +	unsigned int allow_unknown : 1;
> > +	u32 *undefined_perms;
> 
> Why two separate bitfields ?

You mean why did we split from a single "handle_unknown" to using 2
separate bits?  See the message from Eamon

http://marc.info/?l=selinux&m=119033791127455&w=2


> > +int security_get_reject_unknown(void)
> > +int security_get_allow_unknown(void)
> 
> Can you make these static inline?

These are used in selinuxfs.c  and aren't we trying to let the compiler
make inline choices these days?
> 
> 
> What sort of testing has this had?

The patch (minus the bit field split) testing is explained in

http://marc.info/?l=selinux&m=118969604021576&w=2

After the bit field split I merely tested missing classes, I did not
retest all the scenarios described in the above message (namely i didn't
test missing perms alone), but the meat of the patch has not changed
since version 2.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
