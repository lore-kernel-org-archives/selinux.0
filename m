Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FIW8Wt027582
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:32:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FIW00p009982
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:32:00 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h9FIVxr7009979
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:31:59 GMT
Date: Wed, 15 Oct 2003 20:31:17 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Question about chsh/chfn/passwd patches
Message-ID: <20031015183117.GA5967@suse.de>
References: <20031015034406.GA1644@suse.de> <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 15, Stephen Smalley wrote:

> On Tue, 2003-10-14 at 23:44, Thorsten Kukuk wrote:
> > I have a question about the passwd/chfn/chsh patches.
> > 
> > passwd only calls checkAccess. chfn/chsh additional calls 
> > setupDefaultContext. 
> > 
> > I don't understand what the last function makes. For what is it good,
> > and why don't we need to call it from passwd?
> 
> IIRC, for the RH passwd program, this is handled by the libuser patch.
> The call is necessary to preserve the security attributes on /etc/passwd
> and /etc/shadow when they are rewritten for updates.

Ok, since I copy always all attributes if I modify /etc/passwd and
/etc/shadow (to make sure to preserve ACLs and security attributes),
I don't need it.

  Thanks,
    Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
