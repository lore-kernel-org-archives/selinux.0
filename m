Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0NBIJFX022114
	for <selinux@tycho.nsa.gov>; Sun, 23 Jan 2005 06:18:20 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0NBI1Q5006276
	for <selinux@tycho.nsa.gov>; Sun, 23 Jan 2005 11:18:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: Fedora Rawhide mplayer policy
Date: Sun, 23 Jan 2005 22:17:47 +1100
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
References: <1106432170.18789.7.camel@cobra.ivg2.net>
In-Reply-To: <1106432170.18789.7.camel@cobra.ivg2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501232217.51369.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 23 January 2005 09:16, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> I filed a bug on mplayer not being able to read /dev/rtc, and dwalsh
> advised that I should try to write a mplayer policy.
>
> So, this is what I came up with...
> It's tailored to Fedora Rawhide 1.21.2-7 strict + the livna mplayer
> packages. It also assumes Daniel Walsh has added nscd_client_domain to
> x_client_macros.te.
>
> Comments? I've never written a policy before, so I borrowed as much as I
> could from others.

ifdef(`mplayer.te', `mplayer_domain($1)')
ifdef(`mplayer.te', `mencoder_domain($1)')

The above is better written as:
ifdef(`mplayer.te', `mplayer_domain($1)
mencoder_domain($1)')

It might be better still to have the mplayer_domain() macro just call the 
mencoder_domain() macro.

Why have a special type for the mplayer configuration files?  Is it expected 
that secret data will be in such files or that programs which are not 
permitted to write to other files under /etc will be permitted to write to 
them?

dontaudit $1_mplayer_t *:dir_file_class_set { getattr };

The "*" should be replaced by "file_type" to reduce the size of the policy 
binary.


It seems that the main benefit given by the mplayer domain is to prevent 
user_t from reading /dev/rtc.  But that is minimal, maybe it would be better 
to just have a tunable for whether userdomain should be permitted to read 
clock_device_t:chr_file.  mencoder may be a different case however as it's 
got to write data and read from V4L devices etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
