Subject: Re: [PATCH 04/13] libsemanage: split final files into
 /var/lib/selinux/tmp
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Caleb Case <ccase@tresys.com>, selinux@tycho.nsa.gov, csellers@tresys.com,
        kmacmillan@tresys.com, jbrindle@tresys.com
In-Reply-To: <1262961058.13162.4.camel@moss-pluto.epoch.ncsc.mil>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
	 <1261610760-4724-2-git-send-email-ccase@tresys.com>
	 <1261610760-4724-3-git-send-email-ccase@tresys.com>
	 <1261610760-4724-4-git-send-email-ccase@tresys.com>
	 <1261610760-4724-5-git-send-email-ccase@tresys.com>
	 <1262961058.13162.4.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 10:07:56 -0500
Message-ID: <1262963276.11210.33.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-08 at 09:30 -0500, Stephen Smalley wrote:
> On Wed, 2009-12-23 at 18:25 -0500, Caleb Case wrote:
> > This patch moves the final files from inside
> > /var/lib/selinux/<store>/[active|previous|tmp] to
> > /var/lib/selinux/tmp/<store>. The move is done to facilitate using
> > source control management on the /var/lib/selinux/<store> directory. If
> > these files remain in /var/lib/selinux/<store> they will pose a size
> > problem if an SCM like git is used as we'd be storing lots of binary
> > diffs. We are suggesting making this change now, rather than later when
> > source policy, SCM, and CIL[1] support are available, to ease the
> > migration burden.
> > 
> > These are the files that have been moved:
> > 
> > /var/lib/selinux/<store>/active/...	/var/lib/selinux/tmp/<store>/...
> > 
> > file_contexts				contexts/files/file_contexts
> > file_contexts.homedirs			contexts/files/file_contexts.homedirs
> > file_contexts.local			contexts/files/file_contexts.local
> > netfilter_contexts			contexts/netfilter_contexts
> > policy.kern				policy/policy.<policyversion>
> > seusers.final				seusers
> > 
> > The layout of these files in /var/lib/selinux/tmp/<store> is designed to
> > mirror their locations in /etc/selinux/<store>. This should help clarify
> > the relationship between these final files and the files installed in
> > etc.
> > 
> > One consequence of this move is that reverting to the previous policy
> > version requires a policy rebuild. Currently you can revert without
> > rebuilding.
> 
> That seems a little worrisome to me, as a rebuild might fail, e.g. what
> happens if we abort a transaction due to a lack of disk space and then
> try to revert, requiring a rebuild, only to run out of space during the
> rebuild?
> 
If the transaction is aborted then the policy hasn't actually been
changed, so I don't think that this example would be a problem.  It is
only after the transaction is complete that everything is written to the
final location.  Or am I missing something?

It would be a problem only if changes were made to the policy, that
policy loaded, there were problems, and then the rebuild of the previous
policy fails.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
