Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3HgJXZ016587
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 12:42:19 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3Hev4w026335
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 17:40:57 GMT
Date: Wed, 3 Nov 2004 17:53:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   "'Chad Hanson'" <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
Message-ID: <20041103175306.GF5061@lkcl.net>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com> <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil> <4186DCE7.9030401@tresys.com> <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 02, 2004 at 10:33:17AM -0500, Stephen Smalley wrote:

> Yet even the exec-based transitions are strongly influenced by
> application compatibility concerns; otherwise, we would be purging the
> entire environment, resetting the namespace, etc.  Some would argue that
> exec-based transitions are fundamentally flawed in any case where the
> new domain is more privileged than the calling domain due to the ability
> of the caller to influence the new domain via the implicitly inherited
> state, and an IPC-based model would be preferable so that all
> untrustworthy input is explicitly passed and can be vetted rather than
> implicitly conveyed and so that the initial state of the more trusted
> domain is always setup by a trustworthy process.  


 well... that applies in the instance where selinux isn't involved
 _anyway_ - take any setuid root program as a classic example.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
