Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 19 May 2006 09:18:45 -0400
Message-Id: <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 08:59 -0400, Stephen Smalley wrote:
> On Thu, 2006-05-18 at 20:14 +0200, Thomas Bleher wrote:
> > Thank you for your explanation.
> > I see that these are very difficult issues, but I must admit that I
> > still feel very uneasy about the proposed changes.
> > 
> > So let me suggest one more possibility:
> > rpm installs the package, puts the labels on disk and afterwards
> > installs the policy (like Dan proposed originally). 
> > EXCEPT: Whenever rpm finds that the label it wants to put on disk is not
> > valid in the current policy, it labels the file as unlabeled_t (or some
> > other special label). After rpm has installed the policy, it relabels
> > the guilty files. This adds no overhead - rpm already knows the paths and
> > the labels, and it would have had to visit the files anyway to verify
> > their labels -, looks exactly the same from the outside, doesn't require
> > kernel changes and makes it possible to later restrict rpm.
> > 
> > Now, you can't decline such an offer, can you? ;-)
> > 
> > Or am I missing something fundamental here?
> 
> In the labelpriv model, rpm doesn't have to visit the individual files
> afterward in the common case; it just calls security_check_context(3) on
> each distinct context stored in the rpm header (once per context, not
> per file) after the module insertion phase, and if any of them are still
> invalid (the uncommon case), rpm then takes corrective action (whether
> that means relabeling files that had those invalid labels to truly be
> unlabeled_t, removing those files, or reverting the install altogether -
> the latter seems cleanest to me).  If we can't get a guarantee that rpm
> will perform such checking and take corrective action, then I'd agree
> that the kernel change is a no-go.
> 

The question is when the labels will become valid.

Thinking through this more I realized that if we cannot guarantee
ordering within a transaction we cannot commit any policy modules until
the end of the transaction. Otherwise it will not be possible to have
_any_ dependencies between policy modules, which doesn't seem likely
based on my recent investigations into refpolicy dependencies.

If policy modules are only committed at the end of the transaction,
verification of the rpms will require going back through the headers of
every rpm in the transaction.

Dan, Jeremy, Paul, any thoughts about when the policy modules will be
committed?

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> With regard to restricting rpm, under both models, rpm is being allowed
> to set down unlabeled_t files and to insert policy modules.  Restricting
> rpm meaningfully under either model requires fine-grained mediation of
> what those policy modules may contain, which requires the use of the
> policy management server as the libsemanage back end to enforce such
> mediation.  Restricting rpm meaningfully under either model also
> requires decomposition of rpm, so that not all of rpm has to run with
> the same rights and the core rpm processing can run with different
> rights depending on the package characteristics.  Given such mediation
> and decomposition, having a small rpm helper in its own domain that
> verifies that the header contexts are valid after module insertion,
> taking corrective action if necessary, would address the linkage between
> the header contexts and the module contents.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
