Subject: Re: [PATCH 1/3] SELinux: Cleanup the secid/secctx conversion
	functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <200804081713.08660.paul.moore@hp.com>
References: <20080407230647.8052.79603.stgit@flek.lan>
	 <20080407231101.8052.68591.stgit@flek.lan>
	 <1207665824.21223.311.camel@moss-spartans.epoch.ncsc.mil>
	 <200804081713.08660.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 13:27:58 -0400
Message-Id: <1207762078.21223.485.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-08 at 17:13 -0400, Paul Moore wrote:
> On Tuesday 08 April 2008 10:43:44 am Stephen Smalley wrote:
> > On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> > > @@ -709,73 +697,46 @@ static int security_context_to_sid_core(char
> > > *scontext, u32 scontext_len, u32 *s null suffix to the copy to
> > > avoid problems with the existing attr package, which doesn't view
> > > the null terminator as part of the attribute value. */
> > > -	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
> > > -	if (!scontext2) {
> > > -		rc = -ENOMEM;
> > > -		goto out;
> > > -	}
> > > -	memcpy(scontext2, scontext, scontext_len);
> > > -	scontext2[scontext_len] = 0;
> > > +	scontext_dup = kmemdup(scontext, scontext_len + 1, GFP_KERNEL);
> >
> > Also, in addition to the gfp_flags change, I'm not clear that the
> > above change is correct.  We are taking a byte array "scontext" of
> > length "scontext_len" and copying it into a buffer of length
> > "scontext_len+1" so that we can ensure that it is NUL terminated
> > prior to parsing.  Won't kmemdup with scontext_len+1 ultimately run
> > off the end of the original string?
> 
> Good point, I believe you're right.  I'll add this and the gfp stuff to 
> the list of needed changes.
> 
> I think I may also suggest shelving this patch for 2.6.26 as a little 
> birdie mentioned it would be a good idea to give this a through testing 
> on non-MLS/MCS systems which I haven't yet done and don't expect to be 
> able to do so before the merge window opens.

Just for future reference for others, since I didn't cc the list on that
reply:  When making a change that substantively affects the secid/secctx
conversion functions, it would be good idea (albeit painful) to test
each of the following cases:
1) kernel with MLS/MCS policy, filesystem without MLS/MCS labels (to
exercise the compatibility code to map to a default MLS/MCS label).
This is encountered e.g. when mounting a filesystem created on a
non-MCS/MLS distribution on a MCS/MLS distribution, as with an upgrade
from RHEL4 to RHEL5 or Fedora <= 4 to Fedora >= 5.
2) kernel without MLS/MCS policy, filesystem with MLS/MCS label (to
exercise the compatibility code to skip the MCS/MLS label).  This is
encountered in the reverse direction, particularly if sharing a
filesystem across multiple distributions on a multi-boot system.
3) kernel with MLS/MCS policy, filesystem with MLS/MCS labels.  This is
a clean install of RHEL5 or Fedora >= 5.
4) kernel without MLS/MCS policy, filesystem without MLS/MCS label.
This is a RHEL4 or Fedora <= 4 or Ubuntu Hardy Heron or Hardened Gentoo
install.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
