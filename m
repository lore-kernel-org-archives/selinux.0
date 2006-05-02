Subject: RE: We are attempting once again to split policy outintoindividual
	RPMS.
From: Jeremy Katz <katzj@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@redhat.com>,
        selinux-dev <selinux-dev@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158816FEDB@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158816FEDB@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 15:15:15 -0400
Message-Id: <1146597316.32102.125.camel@orodruin.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 15:03 -0400, Joshua Brindle wrote:
> > From: Jeremy Katz [mailto:katzj@redhat.com] 
> <snip>
> > 
> > I don't take the former being controllable as a given, 
> > though.  And if it _is_ controllable, I think similar sorts 
> > of things could apply with just the files (eg, if we end up 
> > adding stuff so that "untrusted"
> > packages can't create policy, then similarly, "untrusted" 
> > packages can't use undefined labels; this seems relatively 
> > straight-forward)
> 
> I don't think this works. If "official" rpm's use this behavior for
> labeling files I seriously doubt there will be significant restrictions
> on third party rpm's not to do so. 

Similarly, if official RPMs use the behavior of bundling policy that
allows them to label files, I seriously doubt there will be significant
restrictions on third party rpm's not to do so.

But somehow, I think we're talking past each other here and not
understanding what the other is trying to get at.

> Further, Steves solution for checking files afterward doesn't work I
> don't think. RPM scriptlets can write files that aren't in the package
> (eg., echo "echo jbrindle:x:0::: >> /etc/passwd" >
> /usr/bin/my-rogue-binary.sh) and therefore aren't verifiable by the rpm
> process.

But how does my-rogue-binary.sh end up something that it shouldn't be?

Jeremy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
