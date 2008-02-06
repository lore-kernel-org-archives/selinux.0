Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Xavier Toth <txtoth@gmail.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.64.0802060934570.10987@us.intercode.com.au>
References: <4798F57C.8090300@tycho.nsa.gov>
	 <cadfc0e40802050952p519dae9co7ecec84bb67231dd@mail.gmail.com>
	 <1202244504.27371.105.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0802060934570.10987@us.intercode.com.au>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 09:49:49 -0500
Message-Id: <1202309389.27371.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-06 at 09:35 +1100, James Morris wrote:
> On Tue, 5 Feb 2008, Stephen Smalley wrote:
> 
> > 
> > On Tue, 2008-02-05 at 11:52 -0600, Xavier Toth wrote:
> > > Is this in rawhide, if not when will it be?
> > 
> > Not up to us, obviously.  The patch is in Linus' git tree, but looks
> > like latest fedora devel kernel is frozen on 2.6.24 + specific
> > individual patches, not feeding from Linus' git presently.  James could
> > possibly ask the Fedora kernel maintainer about adding it - it is small,
> > self-contained, and has no side effects on existing code (nothing prior
> > to XSELinux uses the compute member support; pam_namespace usage was
> > disabled since it didn't work right for multi-level dirs).
> 
> The rawhide kernel usually tracks Linus pretty closely -- perhaps wait a 
> couple of days until people recover from LCA.

Looks like they froze it on 2.6.24 (kernel.spec has released_kernel 1,
gitrev 0 in Fedora devel CVS), and are only cherry picking individual
patches, like the /proc/net fix for SELinux.  Unless that was only for
the Fedora 9 Alpha release and they'll re-open the flood gates soon?

If they don't start pulling from git again soon, we should likely take
the specific patch to fedora kernel list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
