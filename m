Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2ULoWDo019359
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:50:32 -0500 (EST)
Received: from mail.lemuria.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2ULnJo4004854
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 21:49:19 GMT
Date: Wed, 30 Mar 2005 23:50:11 +0200
From: Tom <tom@lemuria.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050330235010.B622@lemuria.org>
References: <20050330155207.58846.qmail@web31601.mail.mud.yahoo.com> <1112199204.8592.13.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112199204.8592.13.camel@cobra.ivg2.net>; from ivg2@cornell.edu on Wed, Mar 30, 2005 at 11:13:24AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 30, 2005 at 11:13:24AM -0500, Ivan Gyurdiev wrote:
> ... or am I missing something fundamental here? 

Yes.

_my_ directory structure will certainly look differently. Jack has yet
another one, Joe a third and Mary a fourth.


People who use Linux for their desktop usually enjoy one thing: That
they can sort things according to _their_ needs, not according to
whatever some "expert" in Redmond has prescribed.


Define the roles, but don't define the directories. If I want my
downloads in ~/Downloads/ and not in ~/content/downloads/ there is no
reason not to allow me that.


Plus, I still don't dig your "content" idea. First, it's a marketing
buzzword abstraction with zero meaning for regular folks. Two, are you
kidding me? How much "non-content" do you think I store in my $HOME to
give "content" it's own subdirectory?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
