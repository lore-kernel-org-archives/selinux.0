Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l094kCMw020262
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 23:46:12 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l094l0Ml000032
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 04:47:00 GMT
Date: Mon, 8 Jan 2007 22:47:03 -0600
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
Message-ID: <20070109044703.GB24321@w-m-p.com>
References: <459BDFD4.7080903@redhat.com> <20070103214837.GB21450@w-m-p.com> <1168278516.12883.24.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168278516.12883.24.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 08, 2007 at 12:48:36PM -0500, Christopher J. PeBenito wrote:
> On Wed, 2007-01-03 at 15:48 -0600, Klaus Weidner wrote:
> > On Wed, Jan 03, 2007 at 11:54:44AM -0500, Daniel J Walsh wrote:
> > > sudo reads netlink_route_socket,  wants to look at the kernel key ring, 
> > > stores a token in the pam_pid directory, and needs to getattr on all 
> > > "user" executables.
> > > 
> > > Some changes to su in order to handle key rings,  Needs 
> > > mls_file_write_down.  Need to be able to su from different domains, and 
> > > pam_rootok causes some selinux_compute_access checks.
> > [...]
> > > sshd wants to look at kernel key ring
> > [...]
> > > fixes for authlogin handling of keyrings and mls, as well as pcscd
> > 
> > I'm confused about what kernel keyring features are currently available
> > in the current policy, and who gets to use them.
> 
> I haven't had a chance to look at the patch, but what is currently
> upstream does not allow users to do anything with keys.  Here's the
> current rules across the entire upstream repo (which includes modules
> not enabled in the lspp policy):

That sounds harmless for the purposes of the LSPP evaluation, thanks for
the clarification.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
