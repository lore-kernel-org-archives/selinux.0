Subject: Re: I've got a problem in my installing selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: zheyeung <zheyeung@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200908301456154069423@gmail.com>
References: <200908301456154069423@gmail.com>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 08:30:39 -0400
Message-Id: <1251721839.16143.24.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-08-30 at 14:56 +0800, zheyeung wrote:
> Hi,everybody, I'm a beginner . I've got a problem in selinux
> installing.
>  
> At first, I install from selinux-policy-targeted.f11.rpm (which in
> release CD), then edit /etc/ selinux/config. change the mode
> to (enforcing,targeted),restart. everything is ok.
>  
> Then ,I download refpolicy.tar.gz from tresys.com. make and make
> install it  by Eclipse-Slide. Here the problem comes. No matter I
> running selinux in enforcing or in permissive, my F11 failed in
> rebooting .It stop at Init process, which can not enter the graphic
> terminal.
>  
> I guess , is there extra work I should do but I didn't ?

I'm not sure why it didn't work in permissive mode (boot with
enforcing=0 on the kernel command line), but you'll likely need to
relabel your filesystems (boot with autorelabel on the kernel command
line or touch /.autorelabel and reboot or just run fixfiles relabel
manually).

But why are you doing this in the first place?  What couldn't you do
with the Fedora policy via local policy modules or semanage
customizations?  Or why not start from the Fedora
selinux-policy .src.rpm to minimize your divergence?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
