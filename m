Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i25HJ7Rb025378
	for <selinux@tycho.nsa.gov>; Fri, 5 Mar 2004 12:19:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i25HHB6Q019939
	for <selinux@tycho.nsa.gov>; Fri, 5 Mar 2004 17:17:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i25HHB5t019936
	for <selinux@tycho.nsa.gov>; Fri, 5 Mar 2004 17:17:11 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1078349802.9541.47.camel@colossus.columbia.tresys.com>
References: <403E52AD.5090103@redhat.com>
	 <1077916703.11720.274.camel@colossus.columbia.tresys.com>
	 <4044B7F5.1010302@redhat.com>
	 <1078323734.9541.28.camel@colossus.columbia.tresys.com>
	 <1078348887.13948.191.camel@moss-spartans.epoch.ncsc.mil>
	 <1078349802.9541.47.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1078507105.16195.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Mar 2004 12:18:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-03 at 16:36, Karl MacMillan wrote:
> Here is an updated version that writes all of the error messages to
> stderr. There are 2 patches - the first is against the patch I sent
> before and the other is the full version.

The resulting file_contexts file maps /root entries to staff*_home_t
rather than sysadm*_home_t.  This is a general limitation of
genhomedircon (not knowing which role to select when multiple ones are
authorized), but the old one avoided the problem by skipping root and
leaving the /root entries in the .fc files.  Now, we could alter the
ordering of roles for root in policy/users as a workaround; that
shouldn't affect the default context as that is governed by
/etc/security/default_contexts. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
