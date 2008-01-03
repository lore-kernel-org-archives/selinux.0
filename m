Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03G7RFc005293
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 11:07:27 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m03G7Q61024196
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 16:07:26 GMT
Subject: Re: cant SSH/Console Login and no deny/error messages
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: Justin Mattock <justinmattock@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <1198712532.4073.871.camel@bluejay.goodinassociates.com>
References: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
	 <dd18b0c30712261459q178f2755g2427f57e1b791aa@mail.gmail.com>
	 <1198712532.4073.871.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 11:06:25 -0500
Message-Id: <1199376385.12626.312.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-26 at 17:42 -0600, Jeremiah Jahn wrote:
> Although that did produce a number of additional deny messages, even
> allowing all of them, still does not allow me to login from the console
> or ssh. doesn't matter if I'm root a standard user or a selinux user.
> 
> 
> Does any one know of a simple way to get RHEL4 targeted to recognize se
> users? I can't quite figure out where they are setting the default
> domain transition. Like I said before, I just need to keep root away
> from a few programs and a data file. I've set up a type and a user,
> relabled the fs with the new types etc etc. added my user to users, it
> matches the name in /etc/passwd exactly.
> 
> 
> I think I generally understand whats going on, I think I'm just
> suffering from use of an out of date tool chain. 

Without an updated toolchain, seusers will not work.  You have to add
selinux users to the policy that match the linux username.  That will
determine the set of the roles for the user just like seusers does now.

> On Wed, 2007-12-26 at 14:59 -0800, Justin Mattock wrote:
> > Hello I think you need to; make enableaudit in the policy. with
> > selinux-policy-default the location would be /etc/selinux/src with
> > refpolicy-strict I'm not too sure. 
> > regards;
> >              --Justin P. Mattock
> > On Dec 26, 2007 1:35 PM, Jeremiah Jahn <jeremiah@goodinassociates.com>
> > wrote:
> >         I've trying to get SELinux strict up and running on a RHEL4-U4
> >         box and
> >         not having much luck. I have one account and 3 programs that I
> >         need to
> >         protect from root. I was unable to get targeted to login under
> >         the user 
> >         that I created, something about the policy always defaulting
> >         to user_u.
> >         So Fine, I tried to install the strict/ref policy from the
> >         tresys and
> >         cips. Dues to this being an x86_64 system, that didn't go well
> >         either. 
> >         Trying plan C  I went with the FC3 strict policy. Obviously
> >         some
> >         improvemtns have been made since then, but this was the first
> >         strict
> >         policy I was able to install without completely hosing my
> >         system. sshd
> >         and login seem to really like having libselinux(64) around. 
> >         
> >         
> >         So my question here has to possible answers:
> >         
> >         1) where the heck can I find some rpms for RHEl4 -x86_64 and
> >         the most
> >         recent ref policy.
> >         
> >         --OR--
> >         
> >         2) what could possibly be causing no [avc denied] messages to
> >         be logged. 
> >         Most of the messages I have used with audit2allow to to try
> >         and get
> >         everything to work. Finally I go to the point of having no
> >         more messages
> >         even when rebooting the machine. If I put things into passive
> >         mode
> >         still no more messages, this is with constant reloading of the
> >         policy to
> >         clear the avc cache.
> >         
> >         help please.
> >         
> >         
> >         
> >         
> >         
> >         
> >         
> >         
> >         "A fractal is by definition a set for which the Hausdorff
> >         Besicovitch 
> >         dimension strictly exceeds the topological dimension." --
> >         Mandelbrot,
> >         "The Fractal Geometry of Nature"
> > 
> A fool-proof method for sculpting an elephant: first, get a huge block
> of marble; then you chip away everything that doesn't look like an
> elephant.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
