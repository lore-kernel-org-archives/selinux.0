Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6QGCarT025996
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 12:12:36 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6QGC77L022360
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 16:12:07 GMT
Subject: Re: [idea] multiple contexts.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040724231154.GE3437@lkcl.net>
References: <20040724231154.GE3437@lkcl.net>
Content-Type: text/plain
Message-Id: <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 26 Jul 2004 12:12:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-07-24 at 19:11, Luke Kenneth Casson Leighton wrote:
> i'd like to propose an extension to the SE/Linux system: it's quite
> straightforward and it could possibly be implemented in the macro
> system - maybe, maybe not.
> 
> the ultimate aim is to help simplify the production of policies.
> 
> the idea is simple: to be able to have more than one context, and
> to be able to make auditing decisions based on more than one context.

Not a good idea, and not necessary.  You can encode the entire call
chain in a single security context using the domain transitions, and can
then unwind as desired.  Fortunately, it sounds like the kdeinit problem
is easily solved anyway.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
