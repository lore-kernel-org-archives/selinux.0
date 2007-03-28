Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
	applet)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <200703282026.41228.russell@coker.com.au>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1175011333.19343.33.camel@localhost.localdomain>
	 <1175021034.29300.67.camel@sgc>  <200703282026.41228.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 08:17:01 -0400
Message-Id: <1175084221.29300.79.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-28 at 21:26 +1100, Russell Coker wrote:
> On Wednesday 28 March 2007 04:43, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
> > > > > same boolean states.  The only time it boots is because the battery
> > > > > was just dead, or you force it because the system is locked up (or
> > > > > some similar reason). Both reset the device state too, and then
> > > > > falling back to the defaults would be the anticipated behavior.  If a
> 
> Except of course if it's not desired.
> 
> > > > > lock down is supposed to survive even that, I would argue that its
> > > > > not a state, its a configuration and that the tunables are the way to
> > > > > go.
> 
> I can imagine a situation where a wireless PDA device has booleans set when 
> leaving a secure area.  When returning to a secure area an RSA based 
> authentication mechanism could be used to inform a management program to 
> change the boolean values.

I've already stated my position on this.  I don't think this is any
different than Karl's docked/undocked example.

> > A PDA is going to have more backed storage than RAM.
> 
> This is wrong.  I have two iPaQ's that have 32M of flash and 64M of RAM.  I am 
> not running out of either and expect that which you find limiting would 
> depend greatly on application.

I disagree, I think this is the past.  Especially now that PDAs have
memory card slots so you can put 2GB+ into them.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
