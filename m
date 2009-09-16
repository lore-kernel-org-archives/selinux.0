Subject: Re: [PATCH] setfiles fails to relabel if selinux not enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeff Johnson <n3npq@mac.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <8695AD02-EDBD-488D-95A1-56EE97D01BDF@mac.com>
References: <1253042418-28141-1-git-send-email-ccase@tresys.com>
	 <1253043181.18198.62.camel@moss-pluto.epoch.ncsc.mil>
	 <06A6610D4F464D4EBEAFBF2C5F86911E014CEA9F@exchange2.columbia.tresys.com>
	 <1253109741.18198.93.camel@moss-pluto.epoch.ncsc.mil>
	 <D095955D-66A2-4A9E-854A-5A5AF0C92EF3@mac.com>
	 <1253111809.18198.104.camel@moss-pluto.epoch.ncsc.mil>
	 <8695AD02-EDBD-488D-95A1-56EE97D01BDF@mac.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 15:26:29 -0400
Message-Id: <1253129189.18198.145.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-16 at 13:21 -0400, Jeff Johnson wrote:
> I'd suggest changing cp(1) to always copy security.* xattr's if found,
> overriding from CLI options when present.
> 
> But choosing a default behavior that is acceptable to everyone is a  
> difficult
> problem. There's no right or wrong if cp(1) copies security.* xattr's  
> (or not),
> only defacto expectations.

No, it would actually be wrong in the common case.  It isn't so
different from the situation wrt uids - cp(1) does not preserve the uid
of the original file by default but rather lets the file gets created in
accordance with the creating process' attributes, and often the caller
does not have the necessary permissions to force preservation even if it
wanted to do so (even more so with the SELinux attributes).

> But please s/cp(1)/rpm(8)/ and consider what RPM should do if/when  
> installing
> modular policy in a chroot with /proc/selinux unmounted. I nearly  
> implemented
> 	Always install security.* xattr's.
> way back when, and (now that modular policy is headed into *.rpm  
> packages somehow)

If you can instead just arrange for proc to always be mounted, then we
can in fact probe for selinux enabled/disabled.  We don't need selinuxfs
to be mounted for that.

> I am again considering what "default" behavior in RPM will lead to the  
> fewest
> RPM bug reports. I'm very likely to add a configurable policy install  
> mode that achieves
> 	Always copy security.* xattr's when replacing a file.
> with an appropriately automated conflict resolution when matchpathcon()
> and *.pp (either from *.rpm packages or not) and what is currently  
> present on
> the file system all have differnt and incompatible security.* xattr's  
> attached
> to the path.
> 
> A "best effort" deterministic automation leads to fewer bug reports  
> imho, ymmv.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
