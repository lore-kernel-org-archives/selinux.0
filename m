Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
   SELinux-dev@tresys.com, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200511101022.12631.csellers@tresys.com>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
	 <200511091630.53757.csellers@tresys.com>
	 <1131635584.19626.43.camel@moss-spartans.epoch.ncsc.mil>
	 <200511101022.12631.csellers@tresys.com>
Content-Type: multipart/mixed; boundary="=-nVO4BFq4s9J61aEaBvby"
Date: Thu, 10 Nov 2005 10:33:04 -0500
Message-Id: <1131636784.19626.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-nVO4BFq4s9J61aEaBvby
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-10 at 10:22 -0500, Chad Sellers wrote:
> On Thursday 10 November 2005 10:13, Stephen Smalley wrote:
> > On Wed, 2005-11-09 at 16:30 -0500, Chad Sellers wrote:
> > > Did this ever get resolved?  I see that this patch has made it into the
> > > rawhide kernel.  This means that when installing a new policy rpm, my
> > > screen is flooded with fixfiles relabeling lib_t to shlib_t, due to
> > > shlib_t being a typealias of lib_t in targeted.  Are we worried about
> > > this right now, or are these messages ok?
> >
> > So the short answer is to not worry about these messages, as they do not
> > reflect actual changes in labels (and are an issue already with existing
> > targeted policy updates, not just refpolicy), and they will cease when
> > the rawhide kernel picks up the latest -git snapshot.
> 
> OK.  Anyone have an idea when this will hit rawhide?  Before test1?

I don't know; the kernel patch just showed up in -git13, so it should be
included in the next rawhide kernel update, but I don't know when that
will happen.

In any event, you should able to redirect output from the rpm update to
a log file and just filter out lib_t/shlib_t noise to see any other
changes of interest.

I'm doing the following:
- updating to the latest rawhide targeted policy first (or rolling back
to it from prior attempted install of the refpolicy),
- running fixfiles restorecon to ensure that files are labeled
consistently with that policy (should already be handled upon the
update, but just wanted to be sure),
- running rpm -Uvh on the new policy rpm, redirecting stdout and stderr
to a log file.

The restorecon is still running, but so far I have the following output
excluding the lib_t->shlib_t noise:
$ grep -v 'lib_t.*shlib_t' log


-- 
Stephen Smalley
National Security Agency

--=-nVO4BFq4s9J61aEaBvby
Content-Disposition: attachment; filename=log2.bz2
Content-Type: application/x-bzip; name=log2.bz2
Content-Transfer-Encoding: base64

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


--=-nVO4BFq4s9J61aEaBvby--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
