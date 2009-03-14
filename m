Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2ENvuPu030807
	for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2009 19:57:56 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2ENvtj2022687
	for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2009 23:57:56 GMT
Received: by wf-out-1314.google.com with SMTP id 25so3264841wfa.30
        for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2009 16:57:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200903150952.54354.russell@coker.com.au>
References: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk>
	 <49BAFBF8.8070805@martinorr.name>
	 <dd18b0c30903141337u264d887as4c56f5bb61d8fb54@mail.gmail.com>
	 <200903150952.54354.russell@coker.com.au>
Date: Sat, 14 Mar 2009 16:57:54 -0700
Message-ID: <dd18b0c30903141657m49bc163m11e392529b2f71b9@mail.gmail.com>
Subject: Re: Unable to disable SELinux
From: Justin Mattock <justinmattock@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Mar 14, 2009 at 3:52 PM, Russell Coker <russell@coker.com.au> wrote:
> On Sun, 15 Mar 2009, Justin Mattock <justinmattock@gmail.com> wrote:
>> I would just use selinux=0 enforcing=0
>> as a boot param(but If the system doesn't boot
>> because of selinux=0) then enforcing=0 as a boot.
>
> I am not aware of any situation where "selinux=0" will make a machine fail to
> boot.

I've noticed this a while back as to where selinux=0
gave me an unable to mount root error(I'll have to see if this
still happens). It might also be caused by having selinux=0
enforcing=0 as a boot param and having
/etc/selinux/config(set in enforcing mode)
but I'll have to look and see when I get a chance.

>
> Anyway the request was for a way to "temporarily disable SELinux", in that
> case "selinux=0" is a bad idea as that will result in files without labels.
> So "enforcing=0" is a much better option.

agree

>
>> but then you still might receive a permissions denied
>> due to /etc/selinux/config saying "enforcing"
>
> If there is a program that uses /etc/selinux/config without regard
> to /selinux/whatever then it's probably buggy.  Please file a bug report if
> you discover such a program.

I meant the option in /etc/selinux/config
SELINUX=enforcing and/or permissive

>
>> (if this is the case then load a livecd mount the hard drive,
>> and use vim to edit /etc/selinux/config, and /boot/grub/* to
>> set everything in permissive.
>
> That's really not necessary.

no its not, but sometimes I found myself in a situation
as to using this approach helps out(that is depending how or what I
did to the system to make it unbootable).

>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
>

regards;

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
