Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9C9suK7030950
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 05:54:56 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9C9reW7009019
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 09:53:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: gdm ubuntu 8.10
Date: Sun, 12 Oct 2008 19:54:48 +1000
Cc: "SE Linux" <selinux@tycho.nsa.gov>
References: <dd18b0c30810112056r5c107307jbcab88d07a382233@mail.gmail.com>
In-Reply-To: <dd18b0c30810112056r5c107307jbcab88d07a382233@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810122054.50829.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 12 October 2008 14:56, "Justin Mattock" <justinmattock@gmail.com> 
wrote:
> Hello; for a while I've been using nubuntu,but now have decided
> to try a full loaded O.S. when using nubuntu  there is no automatic
> gnome-desktop-manager, normally just a login then choosing a context,
> then startx.
> Now with ubuntu there's an automatic login screen with bells and whistles,
>  what is the best way to add pam_selinux.so so I can choose my context,
> or should I adjust the policy to start in sysadm_r as the default
> instead of user_r?

Some of the *dm programs have SE Linux support merged (like sshd) so you don't 
need pam_selinux.so (it may cause problems).  Some of them don't have SE 
Linux code and therefore do need pam_selinux.so.  Some of them might have the 
old version of the code in which case the login->user mapping isn't done and 
things will go wrong (best not to use it in that case).

Run ldd and check for libselinux.so, if it's there then you don't want 
pam_selinux.so - so it's a matter of testing whether the code in question is 
new enough.  If there is no libselinux.so then you can safely use 
pam_selinux.so.

Some of the daemons have only recently been fixed in Lenny, so the broken 
versions may still be in Ubuntu.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
