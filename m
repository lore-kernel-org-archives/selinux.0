Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28G77Rb006569
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 11:07:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i28G760F027723
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 16:07:06 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i28G74gZ027604 for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 16:07:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Proposed patch to policy file_contexts
Date: Tue, 9 Mar 2004 03:05:40 +1100
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>
References: <403E52AD.5090103@redhat.com> <1078507105.16195.78.camel@moss-spartans.epoch.ncsc.mil> <1078761584.30476.67.camel@colossus.columbia.tresys.com>
In-Reply-To: <1078761584.30476.67.camel@colossus.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403090305.40774.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Mar 2004 02:59, Karl MacMillan <kmacmillan@tresys.com> wrote:
> > The resulting file_contexts file maps /root entries to staff*_home_t
> > rather than sysadm*_home_t.  This is a general limitation of
> > genhomedircon (not knowing which role to select when multiple ones are
> > authorized), but the old one avoided the problem by skipping root and
> > leaving the /root entries in the .fc files.  Now, we could alter the
> > ordering of roles for root in policy/users as a workaround; that
> > shouldn't affect the default context as that is governed by
> > /etc/security/default_contexts.
>
> Our thinking was that root shouldn't be a special case and the ordering
> of the roles could take care of everything. I'm not clear why root
> should be labeled with sysadm*_home_t, though. Why not treat root like
> all of the other admins? Wouldn't labeling root with sysadm*_home_t make
> logging in as staff_r for root problematic (for example, when ssh logins
> are allowed for root).

Why not allow staff_t to search sysadm_home_dir_t:dir and read 
sysadm_home_t:file?  Then you can login as root:staff_r and still get aliases 
etc setup, and then you can run "newrole -r sysadm_r".

I've got policy to do that in my tree already.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
