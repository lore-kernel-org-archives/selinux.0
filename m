Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h36D2WI4012503
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 09:02:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h36CwqOv021814
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 12:58:52 GMT
Received: from eos.telenet-ops.be (eos.telenet-ops.be [195.130.132.40])
	by jazzswing.ncsc.mil  with ESMTP id h36CwpY1021811
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 12:58:51 GMT
Date: Sun, 6 Apr 2003 15:02:19 +0200
From: Kurt Roeckx <Q@ping.be>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: screen problem.
Message-ID: <20030406130219.GA16130@ping.be>
References: <20030405234354.GA14856@ping.be> <200304061750.33400.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200304061750.33400.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Apr 06, 2003 at 05:50:33PM +1000, Russell Coker wrote:
> On Sun, 6 Apr 2003 09:43, Kurt Roeckx wrote:
> > screen doesn't seem to work for me.
> 
> I wrote the policy for it quite a while ago and haven't used it since.  It's a 
> little bit out of date, I'll fix it now.
[...]
> I have attached modified versions of screen_macros.te and global_macros.te to 
> address these issues.  They make screen work for a quick test for me.

Everything seems to work expect reading the ~/.screenrc


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
