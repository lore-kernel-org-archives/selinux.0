Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFENgIi023096
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:23:42 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFEMFvq020545
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 14:22:16 GMT
Date: Mon, 15 Nov 2004 14:34:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041115143420.GB5492@lkcl.net>
References: <20041114202332.GO5031@lkcl.net> <1100525144.31773.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100525144.31773.30.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 15, 2004 at 08:25:45AM -0500, Stephen Smalley wrote:

> As proposed, there are two permission checks applied upon a dynamic
> domain transition operation from A to B:
> 1) In order to write to /proc/pid/attr/current at all, A must have
> setcurrent permission to itself, i.e. allow A self:process setcurrent;
> This parallels the setexec and setfscreate checks performed for setting
> other attributes under /proc/pid/attr.
> 2) In order to dynamically transition from A to B, A must have
> dyntransition permission to B, i.e. allow A B:process dyntransition;
> This parallels the transition permission check applied upon exec-based
> transitions, but is distinct so that we can control them separately.
 
 okay - different language / words that i didn't quite understand at the
 time.

 thanks for clarifying.

 it was that allow A B:process dyntransition bit that i wasn't
 understanding.

 just to make absolutely sure: my fears about A being able to
 transition to anydomainatall would be true if someone [explicitly]
 did this:

	allow A domain:process dyntransition;

 is that correct?



 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
