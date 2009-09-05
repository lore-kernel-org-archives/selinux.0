Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n857qYBl013537
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 03:52:34 -0400
Received: from mail-pz0-f189.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n857puQC013970
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 07:51:56 GMT
Received: by pzk27 with SMTP id 27so1443285pzk.9
        for <selinux@tycho.nsa.gov>; Sat, 05 Sep 2009 00:52:33 -0700 (PDT)
Message-ID: <4AA218CF.9040601@gmail.com>
Date: Sat, 05 Sep 2009 00:52:47 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Dennis Wronka <linuxweb@gmx.net>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: can't login in enforcing mode for some reason.
References: <dd18b0c30909042230r3da58c1ay996b7f0fbac361d0@mail.gmail.com> <200909051515.20822.linuxweb@gmx.net>
In-Reply-To: <200909051515.20822.linuxweb@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think I got it, looking at the inittab from
clfs
they have:

|1:2345:respawn:/sbin/agetty -I '\033(K' tty1 9600|

and from lfs its:|

1:2345:respawn:/sbin/agetty tty1 9600|

maybe the|  -I '\033(K' was causing issues.
once I loaded the regular lfs inittab the
policy loaded as it should as well as system_u:system_r:local_login_t
for the login.

Thanks for the info, if it wasn't for you I wouldn't have looked
in inittab.
|
:^)


Dennis Wronka wrote:
> Is that on a regular distro or on your custom compile?
>
> If the latter: Which getty are you using? I had serious problems with agetty,
> but could get around those by switching to mingetty.
>
> Also I think there are two version of login, the one you're using may depend
> on the compile-order. I think one is in the shadow-package and one is in util-
> linux-ng. For a reason that I don't remember I think I am now using the one in
> util-linux-ng.
>
>    


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
