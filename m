Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
In-Reply-To: <1265038131.12435.139.camel@moss-pluto.epoch.ncsc.mil>
References: <201001312243.o0VMh9qn023003@vivaldi39.register.it>
	 <1265038131.12435.139.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 10:37:55 -0500
Message-Id: <1265038675.12435.163.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-01 at 10:28 -0500, Stephen Smalley wrote:
> On Sun, 2010-01-31 at 23:43 +0100, Guido Trentalancia wrote:
> > Dear Stephen,
> > 
> > I have created the patch for allowing runtime switch between different policy types, according to your advice and previous discussions on this mailing list. The patch obsoletes the small piece of documentation that I wrote a few days ago to help new users cope with the limitation.
> > 
> > I would be very grateful if you could review the patch so that, as soon as it is reviewed, it can be posted to the kernel mailing list. I have done some basic testing and it works on one of my systems, although sometimes I get the following side-effect:
> > 
> > /dev/pts/0 changed labels.
> > Unable to restore tty label...
> > 
> > which however doesn't affect the system. I am not sure where that comes from (perhaps bash)...
> 
> pam_selinux and openssh set the tty label on session open and restore it
> upon session close.  But if it changes in the interim, they won't
> restore it.  Switching MLS status will appear to change the tty label
> because of the addition or removal of the MLS suffix.  I guess we'll
> have to think about how/whether the userspace logic should change.
> 
> > Regards,
> > 
> > Guido Trentalancia
> > 
> > Author: Guido Trentalancia <guido@trentalancia.com>
> > Date:   Sun Jan 31 22:10:22 2010 +0100
> > 
> >     Allow runtime switching between different policy types (e.g. from a MLS/MCS
> >     policy to a non-MLS/non-MCS policy or viceversa).
> > 
> >     Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> > 
> > diff -pruN security-testing-2.6/security/selinux/Makefile security-testing-2.6-new/security/selinux/Makefile

Also:
- Missing diffstat -p1 output before the patch (see SubmittingPatches),
- Life will be easier for you if you just create the patches using git.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
