Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0PCfssj004134
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 07:41:55 -0500 (EST)
Subject: Re: Problem logging into GDM after SELinux enable
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom Wesley <tom@tomaw.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41F6048C.1010309@tomaw.org>
References: <41F6048C.1010309@tomaw.org>
Content-Type: text/plain
Message-Id: <1106656539.21318.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 25 Jan 2005 07:35:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 03:34, Tom Wesley wrote:
> Hi,
> 
> Hopefully I've managed to follow the "conversion guide" on the Gentoo 
> website and have run into a problem after the initial setup.
> 
> When logging in using GDM I get a message saying "Unable to set default 
> execution context" and it returns me to the login screen.
> 
> I'm also getting
> 
> Jan 21 22:54:08 tom GDM[30170]: SELinux GDM login: unable to obtain 
> default security context for tom.
> 
> in /var/log/messages.
> 
> I have
> 
>    user tom roles { staff_r staff_r sysadm_r };
> 
> in my users file and have rebuilt the profile, loaded it and relabeled 
> the file system but am still getting the same message.
> 
> Does anyone have any ideas what I should try next?

I was under the impression that Hardened Gentoo only supports SELinux on
servers, not desktop systems.  Thus, they may not include the portions
of the example policy related to X, [xgk]dm, etc.  Do you have an
xserver.te and xdm.te file in your policy/domains/program directory, and
xserver_macros.te under policy/macros/program?  If not, you could try
porting from the example policy, but that is likely to be difficult
given the amount of divergence between the policies.  Fedora Core 3
includes support (but remember to switch to strict policy, as the
default is targeted).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
