Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4OLIJI4002044
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 17:18:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4OLHsuO010491
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 21:17:54 GMT
Received: from unicorn.lemuria.org (c145229.adsl.hansenet.de [213.39.145.229])
	by jazzswing.ncsc.mil  with ESMTP id h4OLHrlV010488
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 21:17:53 GMT
Date: Sat, 24 May 2003 23:16:01 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: some policy patches
Message-ID: <20030524231554.C8955@lemuria.org>
References: <20030524180730.C8251@lemuria.org> <200305250355.11583.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305250355.11583.russell@coker.com.au>; from russell@coker.com.au on Sun, May 25, 2003 at 03:55:11AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 25, 2003 at 03:55:11AM +1000, Russell Coker wrote:
> > # Added write access, not sure if it is required (Tom)
> > allow xdm_xserver_t xdm_var_lib_t:file { getattr read write };
> 
> Write access should not be required.  xdm should create the file and the 
> xserver should just read from it.

Thanks for this and other comments. I will investigate them and post a
cleaned-up version. I also notice that I should probably use userdomain
instead of user_t in many places.


> > # wdm just asks for read access
> > allow xdm_t memory_device_t:chr_file { read };
> 
> Bad.  XDM is not something that you want to allow reading all kernel memory.  
> It should use /dev/random instead if you block /dev/mem.

It actually accesses /dev/mem, not /dev/kmem. Shouldn't /dev/kmem have
its own type?


> > +# but xdm_xserver wants to write, too
> > +allow xdm_xserver_t memory_device_t:chr_file { read write };
> 
> That is only if you are not using the frame-buffer.  See the below snippet 
> from macros/program/xserver_macros.te (which is where you want to do this if 
> you want to support "startx" as well as an xdm).

The framebuffer support for sis chipsets is, to put it friendly,
slightly buggy. I have not yet found a way to use it in any reasonable
way on this machine. (it works, but it's not useable)


> > +allow user_t xdm_exec_t:file { entrypoint };
> 
> This is bad in several ways.  Firstly it's probably good style to use 
> domain_trans() for such things, then people who read your policy can find 
> what they expect to fine.  Secondly, why is an xdm_exec_t program being used?

wdm has several startup files in /etc/X11/wdm/ - I've labelled them
xdm_exec_t. Should they get their own type? They are, for all I can
see, executed after the domain transition has taken place.


> Finally, you should not use user_t in any policy.  unpriv_userdomain is one 
> option to use.  If you start hard-coding user_t in policy then it'll be very 
> painful when you want to add multiple user roles!

Yes, I noticed. I will fix this.



> I have attached a modified xdm.te based on your work along with the new 
> global_macros.te file it depends on.  I didn't include much of your patch, 
> about half of the rest may go in but we need to determine exactly what it's 
> for and put some decent comments in.
> 
> X is nasty.

Absolutely. My goal was to get a working policy and a working graphical
login. I've done that.
Many people on this list know more about policy details, X and kernel 
internals than I do, so I treasure all corrections.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
