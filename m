Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DIL6Rb029389
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 13:21:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1DIJbQm024149
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 18:19:38 GMT
Date: Fri, 13 Feb 2004 13:21:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: MLS Kconfig Patch
In-Reply-To: <1076684958.10189.66.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0402131320410.3420-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Feb 2004, Stephen Smalley wrote:

> On Fri, 2004-02-13 at 09:01, Russell Coker wrote:
> > As the policy does not properly support MLS and every distribution is 
> > compiling the user-space code without MLS support it seems that this patch is 
> > a good idea.
> 
> Isn't the EXPERIMENTAL sufficient?
> 

It should be, the code is experimental, rather than broken.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
