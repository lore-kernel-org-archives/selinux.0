Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i19FnQRb004307
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 10:49:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i19FnPOi026523
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 15:49:25 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i19FnOWW026516 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 15:49:24 GMT
Date: Mon, 9 Feb 2004 15:48:55 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Problem with defaulting answers to selinux-policy-default
Message-ID: <20040209154855.GF22989@vnl.com>
References: <20040208163236.GF10500@vnl.com> <200402091602.48538.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402091602.48538.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 09, 2004 at 04:02:48PM +1100, Russell Coker wrote:
> Sorry for the delay.

You've got a great deal on your plate... I run into your
trail all over opensourcistan.... :-)
 
> > Using policy installation method "Semi-Automatic"
> > Copying the sample /usr/share/selinux/policy/current directory from
> > /usr/share/selinux/policy/default
> > Removal of unwanted policy files
> > Removing "current/domains/program/gnome-pty-helper.te"
> > Include "Checkpolicy - SELinux policy compliler"
> > (current/domains/program/checkpolicy.te) in policy? (References known
> > installed packages: checkpolicy)
> >  Yes/No/Display/Background [Y/n/d/b]?
> 
> What I probably need to do is to have a debconf setting allowing you to say 
> "c" to all questions about policy changes, and then get Colin's code working 
> for installing new .te files IFF they are needed.

I still don't really understand though why my

	yes "" | <etc>

didn't cause the default Y answer to be taken. I will
naturally take a closer look at my own scripts to see
if anything broke, but I do not remember doing anything
that should have affected this.

(Of course anything that makes it easier for me to
 build my from scratch test systems is welcome!)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
