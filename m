Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28HXuRb007245
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 12:33:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i28HWF6Q003608
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:32:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i28HWF5t003605
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:32:15 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1078761584.30476.67.camel@colossus.columbia.tresys.com>
References: <403E52AD.5090103@redhat.com>
	 <1077916703.11720.274.camel@colossus.columbia.tresys.com>
	 <4044B7F5.1010302@redhat.com>
	 <1078323734.9541.28.camel@colossus.columbia.tresys.com>
	 <1078348887.13948.191.camel@moss-spartans.epoch.ncsc.mil>
	 <1078349802.9541.47.camel@colossus.columbia.tresys.com>
	 <1078507105.16195.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1078761584.30476.67.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1078767204.30181.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 08 Mar 2004 12:33:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-03-08 at 10:59, Karl MacMillan wrote:
> Our thinking was that root shouldn't be a special case and the ordering
> of the roles could take care of everything. I'm not clear why root
> should be labeled with sysadm*_home_t, though. Why not treat root like
> all of the other admins? Wouldn't labeling root with sysadm*_home_t make
> logging in as staff_r for root problematic (for example, when ssh logins
> are allowed for root).

Yes, it makes life a little harder for direct remote root logins (but
doesn't prevent them from occurring; you just have to do a subsequent
newrole to get to a full normal operating state).  But it also protects
the integrity of /root's dotfiles more strongly, which can be helpful.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
