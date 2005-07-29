Subject: Re: file context ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1122641058.6573.86.camel@moss-spartans.epoch.ncsc.mil>
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
	 <1122641058.6573.86.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 16:09:07 -0400
Message-Id: <1122667747.20983.78.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 08:44 -0400, Stephen Smalley wrote:
> > There is a little sorting in matchpathcon, to push the specs with
> > regular expressions to the top and explicit matches (those without
> > regular expressions) to the bottom.  This has worked for the current
> > policy since the specs in file_contexts/program/*.fc are generally
> > specific matches and types.fc has always been at the top.  Types.fc has
> > most of the very unspecific regular expressions, and is hand ordered.
> > With reference policy, all of these specs are split up into their
> > respective modules, so there is no ordering of file contexts, except
> > within a module.
[cut]
> > To try to fix this we looked for regular expression sorting algorithms,
> > but pretty much came up empty.
[cut]
> Back when NAI looked into modifying setfiles originally to sort the .fc
> entries, I had looked briefly into techniques for computing the
> generality of a given pathname regex as a way of ordering them, but they
> didn't want to pursue that approach due to time limitations and concerns
> about complexity and ambiguity.  I have that email somewhere if you want
> me to dig it out.

Yes, if you would.  Thanks.

> > This still does not end up being perfect, since we have specs that are
> > of about the same specificity, and end up being in a different order
> > then the current fc.  For example, these two specs end up being in the
> > opposite order that they are in the NSA example policy:
> > 
> > /usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
> > /usr(/.*)?/lib(64)?(/.*)?   system_u:object_r:lib_t
> > 
> > So this results in a handful of mislabeled files
> > (think /usr/lib/foo/bin/*).
> > 
> > What are your thoughts on how to fix this?
> 
> The simplest approach would seem to just be:
> - introduce an optional ordering value field so that the policy writer
> can explicitly order entries relative to each other even when they are
> in separate modules (but this naturally has issues when different people
> are writing different modules without knowing exactly what is in the
> other modules),

The issues you're talking about could be more problematic in the future.
Especially since, with both loadable policy modules and reference
policy, one of the things we're trying to facilitate is handling of 3rd
party policy modules.  Not that I'm saying that this is a bad solution.
It just seems like it might be more painful untangling a labeling
problems this way, since weights are arbitrary, than adding more
specific expressions on a case by case basis, as Dan suggested.  You
also end up at the same problem if the weights are the same.

> - have matchpathcon check for multiple matching specifications with the
> same ordering value (whether explicitly specified or implicitly
> determined using your algorithm) and issue warnings in those cases so
> that we get warnings on such ambiguity, just as it presently warns about
> multiple hard links that match conflicting specifications.

This is probably a good thing to have, regardless.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
