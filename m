Subject: Re: [PATCH] SELinux: create new open permission
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <200802281215.45063.paul.moore@hp.com>
References: <1204211391.3206.66.camel@localhost.localdomain>
	 <200802281215.45063.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 12:22:45 -0500
Message-Id: <1204219365.3206.76.camel@localhost.localdomain>
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
> 
> This is easy to test by simply checking the /selinux/policy_capabilities 
> directory.

You mean its not supposed to look like this?

[root@sun-x8420-01 policy_capabilities]# ls
network_peer_controlsopen_permissions_checking  unknown

fixed patch in 10 minutes.  it would be faster but this machine takes
forever to reboot.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
