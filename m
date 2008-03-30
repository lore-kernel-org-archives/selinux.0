Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2UCkChp023339
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 08:46:13 -0400
Received: from mtaout03-winn.ispmail.ntl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2UCkAiE002429
	for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 12:46:11 GMT
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080330124939.BPQK1244.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 13:49:39 +0100
Received: from [192.168.1.102] (really [82.18.189.14])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080330125205.INOX26699.aamtaout03-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Sun, 30 Mar 2008 13:52:05 +0100
Message-ID: <47EF8B89.6080007@martinorr.name>
Date: Sun, 30 Mar 2008 13:46:01 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Lisa R." <lraykow@cox.net>
CC: selinux@tycho.nsa.gov
Subject: Re: Login Identities not applied when logging in...
References: <20080329145240.CDLBH.81847.imail@fed1rmwml42>
In-Reply-To: <20080329145240.CDLBH.81847.imail@fed1rmwml42>
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 29/03/08 18:52, Lisa R. wrote:
> I realized that I need to run a restorecon after I semanage fcontext so
> that resolved my labeling issue.
> 
> However, I still have a problem with my logins.  They aren't being
> applied when I login.
> 
> When I semanage user -l as root I see my custom "selinux user" associated
> with the custom label.
> 
> When I semange login -l as root I see my custom "selinux user" associated
> with the "login name" that I created with adduser.
> 
> However, when I login and run id -Z as my new user I see the default
> security context set when I created the user under root.

This is because the PAM in etch (and even sid) is too old to work with
semanage login.  You need to set the login context by editing
/etc/selinux/refpolicy-strict/context/users/<user>
(I forget the details).

Alternatively if you want to use semanage login (I had some problems with
the old way, but I forget what) you need to upgrade to PAM 0.99.9 or better.
 I have made Debian packages of this at
http://www.martinorr.name/2007/pam/
and Vaclav Ovsik has some at
http://linux.i.cz/debian/pool/main/p/pam/
You will probable need to rebuild these for etch.

> All I am trying to do is apply a new login to one of my users but it
> won't take.
> 
> I tried a reboot...
> 
> Did I break something or do I need to apply something?
> 
> This worked the other day without a problem (likely story but it did).

I have no idea why this was - it shouldn't.

Best wishes,

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
