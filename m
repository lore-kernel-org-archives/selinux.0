Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h438NhI4020907
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 04:23:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h438Nh7R027304
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 08:23:43 GMT
Received: from smtp-3.paradise.net.nz (smtp-3a.paradise.net.nz [202.0.32.196])
        by jazzband.ncsc.mil  with ESMTP id h438NfKP027301 for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 08:23:42 GMT
Received: from localhost.localdomain (203-79-76-1.ipn5.paradise.net.nz [203.79.76.1])
	by smtp-3.paradise.net.nz (Postfix) with ESMTP id 5C9DEAEFA6
	for <selinux@tycho.nsa.gov>; Sat,  3 May 2003 20:23:32 +1200 (NZST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Wesley Parish <wes.parish@paradise.net.nz>
To: selinux@tycho.nsa.gov
Subject: Re: Support for XWindows ?
Date: Sat, 3 May 2003 10:22:50 +1200
References: <20030503004232.1113.qmail@web20805.mail.yahoo.com> <200305031551.14261.russell@coker.com.au>
In-Reply-To: <200305031551.14261.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200305031022.50946.wes.parish@paradise.net.nz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm thinking of setting up a spare box for use with selinux as a spam-culler 
:( can't manage "spammer-culler" yet - damned nuisance Intel deleting the EOU 
and EORU instructions, don't you think?! ;), firewall and general over-all 
cop for a home network, preparatory to selling the NZ government etc, on 
using it.

I hadn't realized that you already had working policies for X-Window.  That 
does encourage me!

Wesley Parish

On Saturday 03 May 2003 05:51 pm, Russell Coker wrote:
> On Sat, 3 May 2003 10:42, Akshay Gangam wrote:
> > I have a running installed on a stand alone system,
> > with lsm2.4+selinux+RH8.0 on it.
> > The kernel is in permissive mode, but I have not moved
> > to enforcing mode, since I not sure of the support for
> > XWindows. Does changing is enforcing mode, leave me
> > deprived of Emacs/Xwindows to read documentation or to
> > open multiple terminal sessions ?
>
> Notice the xdm.te and xserver.te files in the policy source directory. 
> These provide the security policy for a patched XDM (not included in a base
> SE Linux installation) and for running "startx" from the command line.
>
> Note which email program that I am using to write this message...

-- 
Mau e ki, "He aha te mea nui?"
You ask, "What is the most important thing?"
Maku e ki, "He tangata, he tangata, he tangata."
I reply, "It is people, it is people, it is people."


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
