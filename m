Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28G02Rb006481
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 11:00:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i28G010F027066
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 16:00:01 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i28G00gZ027050 for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 16:00:00 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1078507105.16195.78.camel@moss-spartans.epoch.ncsc.mil>
References: <403E52AD.5090103@redhat.com>
	 <1077916703.11720.274.camel@colossus.columbia.tresys.com>
	 <4044B7F5.1010302@redhat.com>
	 <1078323734.9541.28.camel@colossus.columbia.tresys.com>
	 <1078348887.13948.191.camel@moss-spartans.epoch.ncsc.mil>
	 <1078349802.9541.47.camel@colossus.columbia.tresys.com>
	 <1078507105.16195.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1078761584.30476.67.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 08 Mar 2004 10:59:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-03-05 at 12:18, Stephen Smalley wrote:
> On Wed, 2004-03-03 at 16:36, Karl MacMillan wrote:
> > Here is an updated version that writes all of the error messages to
> > stderr. There are 2 patches - the first is against the patch I sent
> > before and the other is the full version.
> 
> The resulting file_contexts file maps /root entries to staff*_home_t
> rather than sysadm*_home_t.  This is a general limitation of
> genhomedircon (not knowing which role to select when multiple ones are
> authorized), but the old one avoided the problem by skipping root and
> leaving the /root entries in the .fc files.  Now, we could alter the
> ordering of roles for root in policy/users as a workaround; that
> shouldn't affect the default context as that is governed by
> /etc/security/default_contexts. 

Our thinking was that root shouldn't be a special case and the ordering
of the roles could take care of everything. I'm not clear why root
should be labeled with sysadm*_home_t, though. Why not treat root like
all of the other admins? Wouldn't labeling root with sysadm*_home_t make
logging in as staff_r for root problematic (for example, when ssh logins
are allowed for root).

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
