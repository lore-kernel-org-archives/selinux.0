Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJV2XZ011016
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:31:02 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJThMb022193
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:29:43 GMT
Subject: Re: policy for timidity
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040930130555.GC2773@cip.ifi.lmu.de>
References: <20040926202033.GB2529@jmh.mhn.de>
	 <200409292144.47950.russell@coker.com.au>
	 <20040930130555.GC2773@cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1099078190.12321.92.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:29:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Both te and fc files merged.

On Thu, 2004-09-30 at 09:05, Thomas Bleher wrote:
> * Russell Coker <russell@coker.com.au> [2004-09-29 14:52]:
> > On Mon, 27 Sep 2004 06:20, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> > wrote:
> > > Timidity can be used as alsa sequencer client and run as a daemon (when
> > > started as timidity -iA). Attached policy allows this to work on a
> > > SELinux system.
> > 
> > allow timidity_t tmpfs_t:file { read write };
> > 
> > That is wrong.  Should be tmpfs_domain(timidity).
> > 
> > Also for the unix_stream_socket access I think that there's no reason not to 
> > use create_stream_socket_perms access.
> 
> Thanks for your comments!
> A new version of timidity.te is attached.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
