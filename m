Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA1GqKV4025469
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 11:52:20 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA1GpV0M016935
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 16:51:31 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kA1Gopm8029094
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 11:50:51 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kA1GopWM029093
	for selinux@tycho.nsa.gov; Wed, 1 Nov 2006 11:50:51 -0500
Subject: Re: How should I run genfscon in my module?
From: Karl MacMillan <kmacmill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dawid Gajownik <gajownik@gmail.com>, Joshua Brindle <jbrindle@tresys.com>,
        fedora-selinux-list@redhat.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1162316975.32614.146.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885146CC@exchange.columbia.tresys.com>
	 <454509C2.7080008@gmail.com>
	 <1162316975.32614.146.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Oct 2006 16:48:54 -0500
Message-Id: <1162331334.4147.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 12:49 -0500, Stephen Smalley wrote:
> On Sun, 2006-10-29 at 21:06 +0100, Dawid Gajownik wrote:
> > Dnia 10/29/2006 06:33 PM, Użytkownik Joshua Brindle napisał:
> > > Right, that's a hard fix I think, dashes aren't allowed in
> > > identifiers and they are treated specially for use in MLS ranges..
> > 
> > Oh, that's really bad :( Without that line files on ntfs-3g filesystem 
> > have unlabeled_t type and I would need to give to many privileges to 
> > mount_t domain.
> > 
> > So there is no hope to fix it in the clean way?
> 
> File it as a bug against checkpolicy.  

I looked at fixing this by changing genfscon to use user_identifier
instead of identifier (they are the same except user_identifier includes
"-"). This made checkpolicy generate a syntax error for all genfscon
statements - haven't tracked down what the problem is. The grammer still
seems to be unambiguous.

I'll try to get back to it soon, but thought I would post this in case
someone knows what the issue is off the top of their head.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
