Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0GGoBRb010403
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 11:50:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0GGoAiV016171
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 16:50:10 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i0GGo906016168 for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 16:50:10 GMT
Subject: Re: specifying groups of types
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dave Caplan <dac@tresys.com>, Chris PeBenito <pebenito@gentoo.org>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
	 <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1074271807.23661.119.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 11:50:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-15 at 09:31, Stephen Smalley wrote:
> > allow { auth -crond_t } file_type:...
> > 
> > Types/attributes are processed in order, and subsequent allow rules can 
> > also override the subtraction.
> > 
> > I'd recommend trying this out and if you find it useful change the parse 
> > rules.  I tested it on some real basic policy, so it may cause other 
> > unintended problems.  I'm throwing it out more as a starting point 
> > rather than something intended to be integrated into checkpolicy.
> 
> The attached patch for checkpolicy-1.4 provides the same feature (and
> syntax), but is implemented as a modification to the policy grammar
> rather than a change to the identifier token definition.  It doesn't
> address the use of types in constraint expressions, but should work for
> the TE rules, including assertions.

I'm not certain that we want these to be order dependent. I can imagine
a policy writer doing

allow { attr_a -sysadm_t attr_b} . . . 

and being surprised that sysadm_t was allowed because it was in attr_b.

Karl
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
