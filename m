Subject: Re: [PATCH] SELinux: create new open permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>,
        jmorris@namei.org
In-Reply-To: <200802281215.45063.paul.moore@hp.com>
References: <1204211391.3206.66.camel@localhost.localdomain>
	 <200802281215.45063.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 13:46:31 -0500
Message-Id: <1204224391.31790.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 12:15 -0500, Paul Moore wrote:
> On Thursday 28 February 2008 10:09:51 am Eric Paris wrote:
> > diff --git a/security/selinux/selinuxfs.c
> > b/security/selinux/selinuxfs.c index 0341567..6e31ce6 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -43,6 +43,7 @@
> >  /* Policy capability filenames */
> >  static char *policycap_names[] = {
> >  	"network_peer_controls"
> > +	"open_perms"
> >  };
> 
> I think you're missing a comma here :)

Ah, good catch - I missed that omission.  Thanks.
> 
> This is easy to test by simply checking the /selinux/policy_capabilities 
> directory.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
