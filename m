Subject: Re: Added is_context_configurable function
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 17:10:40 -0500
Message-Id: <1105481440.24748.22.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 15:00 -0500, Stephen Smalley wrote:
> On Tue, 2005-01-11 at 11:12, Daniel J Walsh wrote:
> > I think this is more flexible, in that it allows users to specify the 
> > location of these files versus policy.
> > IE I create a new top level directory /rsync which I want to label 
> > ftp_anon_t, I don't want to have to specify
> > ftp_anon_t is an alternative to default_t.
> 
> You could certainly specify a /rsync/(/.*)? entry in file_contexts that
> had both contexts listed.  Ordinary user shouldn't be able to
> create/populate /rsync anyway without administrative setup.

I've said this before, but I don't like the idea of having to edit
file_contexts whenever I want to change the labels.  I feel that the 
on-disk version should be canonical, and the file_contexts only used for
system initialization.  One major reason for this is that right now,
practically speaking, it's difficult to maintain a local system policy
delta, *particularly* with files/file_contexts.  file_contexts is a
machine-generated file; in Fedora it's included in the 
selinux-policy-targeted package.  If you change it you get .rpmnew files
which you have to manually merge on every package update.  This could be
solved to some extent if we also had matchpathcon read from
file_contexts.local or something.  Even if we implemented that though,
it is still painful for administrators to e.g. use a non-default Apache
DocumentRoot; they will have to remember to create an entry in their
file_contexts.local file with a regexp matching the path and all of the
possible alternate types, which is pretty unintuitive.  Although the
obvious merge conflict is gone, you still have to manually keep this
line in sync with any Apache policy updates.

> Failing to associate the context with a location in any manner means
> that setfiles/restorecon will fail to fix the label on e.g. /etc/shadow
> if it happens to get one of these configurable types at some point. 
> Admittedly, getting to that point requires some kind of serious error in
> the first place,

To say the least.

>  but running fixfiles relabel will no longer correct
> such errors for you.

If your /etc/shadow is somehow mislabeled, I would think that you likely
have larger problems than a fixfiles relabel could solve; e.g. you
accidentally untarred an old system snapshot onto /.

> BTW, customizable or alternatives seems better than configurable.

Yeah, I like customizable, but it's not a strong preference.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
