Subject: Re: Latest diffs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Mikel L. Matthews" <mikel@argus-systems.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158850172.11048.2.camel@twoface.columbia.tresys.com>
References: <45116881.3060406@redhat.com>
	 <1158846352.3920.33.camel@sgc.columbia.tresys.com>
	 <45129CD0.5040507@argus-systems.com>
	 <1158850172.11048.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 11:18:46 -0400
Message-Id: <1158851926.7748.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 10:49 -0400, Joshua Brindle wrote:
> On Thu, 2006-09-21 at 09:08 -0500, Mikel L. Matthews wrote:
> > 
> > Christopher J. PeBenito wrote:
> > > On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
> > > 
> > > I haven't looked at the patch but I have some initial reactions from
> > > your description:
> > > 
> > >> http://people.redhat.com/dwalsh/SELinux/policy.diff
> > >>
> > >> Changed to allow 1024 categories.
> > > 
> > > Why do we need this many?  This isn't even an incremental change up to
> > > something like 384 or 512.
> > 
> > We have customers that use all of our 1024 categories and want more. 
> > They have requested 10,000 categories.
> > 
> 
> That is because they are probably using categories as an integrity
> mechanism which is entirely inappropriate for SELinux since TE should be
> used for integrity and mls should only be used for confidentiality. I
> seriously doubt that a reasonable system could have 10000 useful
> categories.

More like "one category assigned per project, never to be re-used".  For
confidentiality, not integrity.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
