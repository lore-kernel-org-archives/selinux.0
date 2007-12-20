Subject: Re: Getting started with SELinux and Slackware
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Martin J. Green" <mail@martinjgreen.me.uk>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <54EE10FFA0116B408D3A5172CB52729FBF526E155A@exchange.home.martinjgreen.me.uk>
References: 
	 <54EE10FFA0116B408D3A5172CB52729FBF526E155A@exchange.home.martinjgreen.me.uk>
Content-Type: text/plain
Date: Thu, 20 Dec 2007 09:48:03 -0500
Message-Id: <1198162083.32563.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-20 at 13:40 +0000, Martin J. Green wrote:
> > From: Timothy <timothy_at_diyab.net>
> > Date: Thu, 22 Sep 2005 14:02:29 -0400
> >
> > All of the modified slackware sources that I used to build that old release are available on that ftp site (ftp.diyab.net/selinux). I haven't had time to update any of it > in a while but it generally just requires checking the newer patches and rebuilding the tgz from the slackbuild script.
> > I included PAM because I think it has good advantages so all of the packages I built include PAM support. Not sure what would be involved in building without PAM. Most >likely it just requires removing the configure flags to enable PAM from the build scripts.
> > I'll be more than happy to help you out if you want.
> > Timothy
> 
> 
> I appreciate this is an old post, but I'm in the process of updating your build scripts for the latest selinux, however I'm also looking for the old login patch so I don't have to use PAM.
> 
> I would of course be happy to make the build scripts available (I'll also build for i486 and upload to linuxpackages.net when I get time - I'm building for p4 & x86_64 for myself).
> 
> Can anyone point me in the right direction to find the necessary patch(es)? I've found some FC4 patches in the fedora CVS tree that don't seem to refer to PAM, but not sure when PAM was introduced to redhat/fedora, so not quite sure what I'm looking for. I want to modify slack as little as possible.

The switch from using a direct patch to login to using pam_selinux
happened back in 2003, so I think Fedora might have always used
pam_selinux (since Fedora first included SELinux in Fedora Core 2, which
came out later).  You can tell by whether or not the
util-linux-selinux.patch included a diff to login.c or not.

Of course, pam_selinux has undergone a lot of changes since that time,
so you may want to consider just back porting its logic into login.c,
removing its pam'isms.

google on util-linux-selinux.patch found a copy that still had the
login.c mods at:
http://mirror.caoslinux.org/cAos-1/creation/util-linux-2.11y-31.1/SOURCES/util-linux-selinux.patch
among other places.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
