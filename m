Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l34HG3kT019370
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 13:16:03 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l34HG060007750
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 17:16:01 GMT
Date: Wed, 4 Apr 2007 13:15:55 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Eric Paris <eparis@parisplace.org>, jwcart2@tycho.nsa.gov,
        SELinux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: [patch] selinux:  export initial SID contexts via selinuxfs (v2)
In-Reply-To: <1175706011.30692.104.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0704041314050.25040@d.namei>
References: <1175695889.14463.13.camel@moss-lions.epoch.ncsc.mil>
 <1175703431.20396.131.camel@localhost.localdomain>
 <1175706011.30692.104.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Apr 2007, Stephen Smalley wrote:

> patch-tester.pl also complains about a couple places where trailing
> whitespace is added; another trivial cleanup.

FYI, "git-am --dotest=.dotest -i -s -u --whitespace=strip /path/to/mbox"

fixes that up automatically.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
