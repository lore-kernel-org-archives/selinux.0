Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83CsVLa025127
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 08:54:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h83CqwpQ017766
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:52:58 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id h83CqwQX017757
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:52:58 GMT
Date: Wed, 3 Sep 2003 14:54:24 +0200
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Enable SELinux via boot parameter
Message-ID: <20030903145423.D3990@lemuria.org>
References: <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com> <1062558452.1838.52.camel@chris.pebenito.net> <20030903091258.L30963@lemuria.org> <1062592181.18568.321.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1062592181.18568.321.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Sep 03, 2003 at 08:29:41AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 03, 2003 at 08:29:41AM -0400, Stephen Smalley wrote:
> It is already the case that you need to specify 'enforcing=1' to boot an
> enforcing kernel if you enabled development support.  How many people
> disable development support?  

More once SE gets more stable and production systems get deployed.


> And if you do disable development support,
> do you also keep around a second kernel that you can boot for emergency
> recovery?  

Not on a production machine. I'd insist on a from-CD boot there for
recovery.


I'd love to have a way to ensure that if _this_ kernel was booted, it
_does_ use SE.

-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
