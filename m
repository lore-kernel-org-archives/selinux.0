Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9AHbsrT002265
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2004 13:37:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9AHboWN004833
	for <selinux@tycho.nsa.gov>; Sun, 10 Oct 2004 17:37:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policy patches
Date: Mon, 11 Oct 2004 03:37:46 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <200409292354.15227.russell@coker.com.au> <200410030614.57157.russell@coker.com.au> <41640F34.6090705@redhat.com>
In-Reply-To: <41640F34.6090705@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410110337.46190.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Oct 2004 01:28, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> >On Sat, 2 Oct 2004 20:16, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>Russell Coker wrote:
> >>>On Sat, 2 Oct 2004 06:45, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>>>Cleaned up patch with some of russells changes.
> >>>>
> >>>>chage has been updated to do a checkPasswdAccess(PASSWD__ROOTOK) now.
> >>>
> >>>+allow getty_t initrc_devpts_t:chr_file { read write };
> >>>
> >>>What is this for?
> >>
> >>I have been getting AVC messages for it.
> >
> >Please show me the AVC messages.

That's strange.  How do you reproduce this?

initrc_devpts_t can only be created by initrc_t, and getty_t can only be 
entered from init_t.  Somehow getty or init must be trying to open /dev/pts/0 
for some reason.

Something must have a bug, it would be good if we could track it down.

In the mean time if this entry is to be included in the policy it should have 
ifdef(`distro_redhat' or ifdef(`hide_broken_symptoms' around it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
