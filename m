Message-ID: <005901c1518a$48d3c7a0$0101000a@praefect>
From: "Julien Palardy" <palj@praefect-sys.com>
To: "Carl Carpenter" <ccarpenter@hillcountry.org>,
        "SELinux" <SELinux@tycho.nsa.gov>
References: <DIECIJMLKGOOCPBJIBKJAELJCEAA.ccarpenter@hillcountry.org>
Subject: Re: Problems with eth0
Date: Wed, 10 Oct 2001 14:47:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been working on kernel-lsm with both SELinux patch and kernel module,
and in both ways there does not seem to be any problem with the network
interfaces.

Maybe you should take a look at your kernel config. May have missed a driver
or something.

And yes, you do see good. SELinux provides terrific security ;)

---
Julien Palardy <palj@praefect-sys.com>
1AC7 1DB0 FEA6 93C2 6731  0AB1 07BA B3C7 458E E234


> I have discovered how SELinux provides such terrific security--it doesn't
> load the eth0 drivers, thereby keeping the server off the network.
> Seriously, I have a problem when running the SELinux kernel in that the
eth0
> module can't be found during bootup (modprobe:  can't locate module eth0).
> I'm running 2.4.10-lsm on RH 7.1 (I386).  It works fine in normal mode.  I
> followed the install instructions step-for-step, selecting the preferred
> method of building the SELinux module as part of the kernel.  If I got any
> error messages, I didn't see them with all the other messages on the
screen.
> I'm fairly new to Linux, so this may be an easy fix, but it's beyond me at
> the moment.  Thanks in advance for any help.
>
> Carl Carpenter
> IT Manager
> Hill Country Community MHMR Center
> "Hiroshima 1945, Chernobyl 1986, Windows 2000"
>
> ---
> Outgoing mail is certified Virus Free.
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.285 / Virus Database: 151 - Release Date: 10/5/2001
>
>
>
> --
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
