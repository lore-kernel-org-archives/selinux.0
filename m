Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1147890495.22880.172.camel@jackjack.columbia.tresys.com>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147890417.30789.384.camel@moss-spartans.epoch.ncsc.mil>
	 <1147890495.22880.172.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:43:08 -0400
Message-Id: <1147891388.30789.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 14:28 -0400, Karl MacMillan wrote:
> On Wed, 2006-05-17 at 14:26 -0400, Stephen Smalley wrote:
> > close the loop between the undefined file labels and the policy module
> > that was checked, it is important that rpm verify that all of the file
> > labels set down by rpm became valid upon the policy load, and either
> > warn the admin or take some corrective action (whether that means
> > relabeling those files to truly be unlabeled_t, removing those files, or
> > reverting the package install altogether) if they are not.  I suppose
> > calling security_check_context() on each context from the header would
> > suffice, followed by either a warning or corrective action if it fails
> > on any of them.
> > 
> 
> Only checking the contexts in the header would protect against malicious
> packages but not a subverted rpm, right?

Yes, unless rpm itself is decomposed, with one rpm process in one domain
performing the checking and one rpm process in another domain performing
the install and module insertion (which you need anyway if you want to
mediate policy module insertions based on package trustworthiness).  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
