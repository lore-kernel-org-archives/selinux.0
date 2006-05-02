MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: We are attempting once again to split policy outintoindividualRPMS.
Date: Tue, 2 May 2006 15:48:30 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158816FEE9@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Jeremy Katz" <katzj@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "James Morris" <jmorris@redhat.com>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>, "Paul Nasrat" <pnasrat@redhat.com>,
        "James Antill" <jantill@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Jeremy Katz [mailto:katzj@redhat.com] 
> 
> On Tue, 2006-05-02 at 15:03 -0400, Joshua Brindle wrote:
> > > From: Jeremy Katz [mailto:katzj@redhat.com]
> > <snip>
<snip>

> > I don't think this works. If "official" rpm's use this behavior for 
> > labeling files I seriously doubt there will be significant 
> > restrictions on third party rpm's not to do so.
> 
> Similarly, if official RPMs use the behavior of bundling 
> policy that allows them to label files, I seriously doubt 
> there will be significant restrictions on third party rpm's 
> not to do so.
> 

Oh, I see what you are advocating now. There are some pretty good
reasons not to package policies directly with the applications. The main
one IMO is that any given policy may work with one or more base
policies. In Red Hat land this could mean that a policy has a
targeted-mls, targeted-mcs, strict-mls, strict-mcs version. I haven't
heard any schemes that help this problem...

OTOH all those rpm's can be built from the same refpolicy rpm and the
system configuration can specify the correct package to install. 

> But somehow, I think we're talking past each other here and 
> not understanding what the other is trying to get at.
> 
> > Further, Steves solution for checking files afterward 
> doesn't work I 
> > don't think. RPM scriptlets can write files that aren't in 
> the package 
> > (eg., echo "echo jbrindle:x:0::: >> /etc/passwd" >
> > /usr/bin/my-rogue-binary.sh) and therefore aren't verifiable by the 
> > rpm process.
> 
> But how does my-rogue-binary.sh end up something that it shouldn't be?
>

It could use setfscreateon(3) but as Steve pointed out scriptlets could
be prevented from doing this. 

The one thing I'd like to point out here is that in SELinux-land we have
'trusted' applications but we only trust them to some extent. Example,
in standard linux ping is trusted to do anything, in SELinux its trusted
to setuid and use raw network connections. The behavior we are talking
about here greatly increases the trust necessary with the applications
that have the ability to label files with invalid labels.

Further, I don't agree with your assertion that policy maintenance
should be pushed off to application package maintainers. Application
maintainers, more than anything, are concerned with their application
running. If that means merely using audit2allow in a 'status quo
encapsulation' policy writing style then the policy quality degrades. 

Having people interested in security reviewing changes to application
policy is a necessary check/balance IMO.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
