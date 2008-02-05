Subject: RE: How to contribute: policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Scott Lowrey <slowrey@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8BC096A@HAVOC.tcs-sec.com>
References: <D709A20F2164C84E8B7014B0301F5EF8BC096A@HAVOC.tcs-sec.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 12:58:38 -0500
Message-Id: <1202234318.27371.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-05 at 12:41 -0500, Scott Lowrey wrote:
> > Behalf Of Christopher J. PeBenito
> > Sent: Tuesday, February 05, 2008 8:10 AM
> > 
> > On Mon, 2008-02-04 at 20:08 +0000, Eoin Ryan wrote:
> > > I'm on a mission to run a personal server using the strict policy,
> > > mainly as a learning exercise.  I've just come across what seems to
> be
> > > an error in the policy, so I thought a good way to contribute might
> be
> > > to submit bug reports as I work to configure the system for
> > > mail/web/etc.  Is this the correct place/way to submit such
> problems?
> > 
> > You can post it here, but since its RHEL you probably should post it
> to
> > Red Hat bugzilla so it can go through the right processes to be
> included
> > in the next RHEL update.
> > 
> 
> Hello.  I have a similar question, then.  I resolved a small policy
> problem related to the IPsec 'setkey' command on the RHEL5 LSPP
> platform.  The ipsec setkey command was not allowed to write to stdout.
> This problem occurs when newrole is used to get sysadm_r before running
> setkey.  
> 
> Not sure if it's worth posting but it should be included in downstream
> releases.  Should I post a bug at Red Hat along with the fix?  Is there
> any need to post the patch here?

I'd tend to encourage people to both post it here so it can get
upstreamed for future upstream releases and bugzilla it so that it can
potentially be included in future updates to existing distributions.
You can't really assume that submitting it to RH will ever get it to the
upstream refpolicy nor that getting it into the upstream refpolicy will
ever get it into an existing distribution release like RHEL 5.  It has
to be submitted separately.  And ideally you could check first to see if
it is already in the refpolicy trunk, as naturally RHEL5 won't include
many fixes that have already been upstreamed there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
