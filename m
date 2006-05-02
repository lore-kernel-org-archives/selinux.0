MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: We are attempting once again to split policy outintoindividual RPMS.
Date: Tue, 2 May 2006 15:03:23 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158816FEDB@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Jeremy Katz" <katzj@redhat.com>, "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, "James Morris" <jmorris@redhat.com>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>, "Paul Nasrat" <pnasrat@redhat.com>,
        "James Antill" <jantill@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Jeremy Katz [mailto:katzj@redhat.com] 
> 
<snip>
> 
> I don't take the former being controllable as a given, 
> though.  And if it _is_ controllable, I think similar sorts 
> of things could apply with just the files (eg, if we end up 
> adding stuff so that "untrusted"
> packages can't create policy, then similarly, "untrusted" 
> packages can't use undefined labels; this seems relatively 
> straight-forward)

I don't think this works. If "official" rpm's use this behavior for
labeling files I seriously doubt there will be significant restrictions
on third party rpm's not to do so. 

Further, Steves solution for checking files afterward doesn't work I
don't think. RPM scriptlets can write files that aren't in the package
(eg., echo "echo jbrindle:x:0::: >> /etc/passwd" >
/usr/bin/my-rogue-binary.sh) and therefore aren't verifiable by the rpm
process.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
