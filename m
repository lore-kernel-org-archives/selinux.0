Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96JK7Wt007448
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 15:20:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h96JK67d025319
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 19:20:06 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
        by jazzband.ncsc.mil  with ESMTP id h96JK5Rn025313 for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 19:20:05 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id D551E168FD4B
	for <selinux@tycho.nsa.gov>; Mon,  6 Oct 2003 21:20:04 +0200 (CEST)
Date: Mon, 6 Oct 2003 09:33:12 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: libselinux-1.2 and const usage
Message-ID: <20031006073312.GA3261@suse.de>
References: <20031003063614.GA20539@suse.de> <1065205090.4080.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065205090.4080.177.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

On Fri, Oct 03, Stephen Smalley wrote:

> On Fri, 2003-10-03 at 02:36, Thorsten Kukuk wrote:
> > Hi,
> > 
> > when trying to add selinux support to some of my applications, I
> > found out that the libselinux interface does not make usage of
> > "const", which ends in a lot of compiler warnings.
> > 
> > Attached is a patch for libselinux to solve this.
> 
> Thanks, I've merged this into our internal CVS tree as well as the
> sourceforge CVS tree.  I'd be interested in knowing what applications
> you are modifying and how you are adapting them for SELinux, if you're
> willing to share...

I try to add SELinux support to pam_login, pwdutils and some of my
PAM modules with the help of the already existing selinux patches
for util-linux, shadow and passwd. pam_login is already done, the
others will come later.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
