Subject: Re: How should I run genfscon in my module?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmill@redhat.com>
Cc: Dawid Gajownik <gajownik@gmail.com>, Joshua Brindle <jbrindle@tresys.com>,
        fedora-selinux-list@redhat.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1162331334.4147.6.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885146CC@exchange.columbia.tresys.com>
	 <454509C2.7080008@gmail.com>
	 <1162316975.32614.146.camel@moss-spartans.epoch.ncsc.mil>
	 <1162331334.4147.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 01 Nov 2006 08:32:13 -0500
Message-Id: <1162387933.32614.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 16:48 -0500, Karl MacMillan wrote:
> On Tue, 2006-10-31 at 12:49 -0500, Stephen Smalley wrote:
> > On Sun, 2006-10-29 at 21:06 +0100, Dawid Gajownik wrote:
> > > Dnia 10/29/2006 06:33 PM, Użytkownik Joshua Brindle napisał:
> > > > Right, that's a hard fix I think, dashes aren't allowed in
> > > > identifiers and they are treated specially for use in MLS ranges..
> > > 
> > > Oh, that's really bad :( Without that line files on ntfs-3g filesystem 
> > > have unlabeled_t type and I would need to give to many privileges to 
> > > mount_t domain.
> > > 
> > > So there is no hope to fix it in the clean way?
> > 
> > File it as a bug against checkpolicy.  
> 
> I looked at fixing this by changing genfscon to use user_identifier
> instead of identifier (they are the same except user_identifier includes
> "-"). This made checkpolicy generate a syntax error for all genfscon
> statements - haven't tracked down what the problem is. The grammer still
> seems to be unambiguous.

Use "user_id" instead.  Otherwise, you'll get a syntax error when the
token is classified as an IDENTIFIER (first match) and the grammar says
that it must be a USER_IDENTIFIER.  
> 
> I'll try to get back to it soon, but thought I would post this in case
> someone knows what the issue is off the top of their head.
> 
> Karl
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
