Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9U09eWt010338
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 19:09:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9U098XK004127
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 00:09:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9U091j4004118 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 00:09:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>,
   Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Subject: Re: question about pam_selinux multiple option
Date: Tue, 28 Oct 2003 09:38:18 +1100
Cc: selinux@tycho.nsa.gov
References: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp> <3F9D33EC.8060705@redhat.com>
In-Reply-To: <3F9D33EC.8060705@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310280938.18975.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Oct 2003 02:04, Daniel J Walsh wrote:
> The multiple option was added to allow the user to select the security
> context they would be allowed to login in as.  We have decided to pull
> this functionality from login programs and only allow the user to login
> with the default context.  Afterwards they can change their context
> using newrole.  I will fix the man page.

Dan, I agree that the multiple option is not something we want globally 
enabled, and it may not be desirable to have it enabled in a default 
configuration.  But I think that we should still have the feature available 
in a default build of the module so that anyone who desires it and is using a 
login program that will support it can do so.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
