Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72D7grT011834
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 09:07:42 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72D79XV017447
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 13:07:09 GMT
Subject: Re: lkm rootkitted, or issue with selinux 2.6.7 kernel?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801124138.GA15205@lkcl.net>
References: <20040801124138.GA15205@lkcl.net>
Content-Type: text/plain
Message-Id: <1091452021.23449.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 09:07:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-08-01 at 08:41, Luke Kenneth Casson Leighton wrote:
> hello, hello,
> 
> i have a slight situation with the fireflier and mysql packages:
> their use results in chkrootkit's lkm (linux kernel module) test
> showing a warning.
> 
> what i wondered was has anyone _else_ seen this issue, on debian/unstable,
> with a 2.6.7 kernel.

I have no direct knowledge here, but I have seen discussions on various
lists indicating that chkrootkit is buggy/racy at least with respect to
Linux 2.6, yielding false positives.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
