Date: Mon, 1 Apr 2002 08:36:48 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: "Walker, Jason" <Jason.Walker@csoconline.com>,
        "'SeLinux@tycho.nsa.gov'" <SeLinux@tycho.nsa.gov>
Subject: Re: Troubles with 2.4.18 kernel
In-Reply-To: <20020328222355.29056421B8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204010808560.20742-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 28 Mar 2002, Russell Coker wrote:

> http://lsm.immunix.org/
>
> Immunix has had SE Linux included in their patches for several versions now
> and they have lots of old versions on their site.
>
> I usually take my patches from Immunix instead of the NSA site.  When a new
> kernel comes out Immunix has a patch long before the NSA.

The LSM site does have older LSM kernel patches, but these patches do not
always coincide with any particular NSA SELinux release.  New development
on the SELinux kernel, including enhancements to the SELinux kernel module
and (less frequently) new LSM hooks to support additional security
functionality in the SELinux kernel module, may appear first on the NSA
site and only subsequently be pushed to the LSM BitKeeper trees
(subsequently showing up in later LSM snapshot patches).  Additionally,
the non-kernel components of SELinux are not available from the LSM site.
Hence, I wouldn't recommend using the LSM site to obtain a particular
release of SELinux.  The sourceforge selinux project site's CVS tree is
preferable for this purpose, although it only goes back to the 2001121010
release based on kernel 2.4.16.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
