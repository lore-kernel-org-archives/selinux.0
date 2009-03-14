Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2EMr3Fx024257
	for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2009 18:53:03 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2EMr0j2012753
	for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2009 22:53:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: Unable to disable SELinux
Date: Sun, 15 Mar 2009 09:52:48 +1100
Cc: selinux@tycho.nsa.gov
References: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk> <49BAFBF8.8070805@martinorr.name> <dd18b0c30903141337u264d887as4c56f5bb61d8fb54@mail.gmail.com>
In-Reply-To: <dd18b0c30903141337u264d887as4c56f5bb61d8fb54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903150952.54354.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 15 Mar 2009, Justin Mattock <justinmattock@gmail.com> wrote:
> I would just use selinux=0 enforcing=0
> as a boot param(but If the system doesn't boot
> because of selinux=0) then enforcing=0 as a boot.

I am not aware of any situation where "selinux=0" will make a machine fail to 
boot.

Anyway the request was for a way to "temporarily disable SELinux", in that 
case "selinux=0" is a bad idea as that will result in files without labels.  
So "enforcing=0" is a much better option.

> but then you still might receive a permissions denied
> due to /etc/selinux/config saying "enforcing"

If there is a program that uses /etc/selinux/config without regard 
to /selinux/whatever then it's probably buggy.  Please file a bug report if 
you discover such a program.

> (if this is the case then load a livecd mount the hard drive,
> and use vim to edit /etc/selinux/config, and /boot/grub/* to
> set everything in permissive.

That's really not necessary.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
