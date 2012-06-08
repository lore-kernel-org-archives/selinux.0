From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] Add SELinux policy capability for always checking packet class.
Date: Fri, 08 Jun 2012 14:55:56 -0400
Message-ID: <20928751.8CTdyDzEWU@sifl>
In-Reply-To: <4FD2445C.3070704@tresys.com>
References: <1339093682-5113-1-git-send-email-cpebenito@tresys.com> <2776660.gCfiz8ed08@sifl> <4FD2445C.3070704@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, June 08, 2012 02:28:44 PM Christopher J. PeBenito wrote:
> On 06/08/12 13:36, Paul Moore wrote:
> > On Thursday, June 07, 2012 02:28:01 PM Chris PeBenito wrote:
> >>  static int selinux_secmark_enabled(void)
> >>  {
> >> 
> >> -	return (atomic_read(&selinux_secmark_refcount) > 0);
> >> +	if (selinux_policycap_alwaysnetwork)
> >> +		return 1;
> >> +	else
> >> +		return (atomic_read(&selinux_secmark_refcount) > 0);
> >> 
> >>  }
> > 
> > Nit picky, but why not simply:
> >   return (selinux_policycap_alwaysnetwork || atomic_read( ...
> 
> Sure it can be done that way, but I'd argue that the intent is clearer the
> way its implemented in the patch.

It looks very hacky and inconsistent to me.

Oh well, you can sort it out with Eric.

> >> diff --git a/security/selinux/include/security.h
> >> b/security/selinux/include/security.h index dde2005..981c4ac 100644
> >> --- a/security/selinux/include/security.h
> >> +++ b/security/selinux/include/security.h
> >> @@ -68,12 +68,14 @@ extern int selinux_enabled;
> >> 
> >>  enum {
> >>  
> >>  	POLICYDB_CAPABILITY_NETPEER,
> >>  	POLICYDB_CAPABILITY_OPENPERM,
> >> 
> >> +	POLICYDB_CAPABILITY_ALWAYSNETWORK,
> >> 
> >>  	__POLICYDB_CAPABILITY_MAX
> >>  
> >>  };
> >>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> >>  
> >>  extern int selinux_policycap_netpeer;
> >>  extern int selinux_policycap_openperm;
> >> 
> >> +extern int selinux_policycap_alwaysnetwork;
> > 
> > Also nit picky, but it would seem like "selinux_policycap_netalways" is a
> > bit more consistent with the other variables.
> 
> This response stems on what you wrote on a later cunch about the capability
> name, so you should probably read below first.

What?

I don't believe I ever commented on the capability names until now, please 
correct me with a link to the archives if I'm mistaken.

> I don't agree.  If you go by current capabilities names/variables, based on
> the ordering of the words in the capability name, the words in the variable
> are in the same order. e.g.
> 
> NETwork_PEER_controls -> selinux_policycap_netpeer
> OPEN_PERMs -> selinux_policycap_openperm
> 
> hence
> 
> ALWAYS_check_NETWORK -> selinux_policycap_alwaysnetwork

I look at it as a bit of "namespacing" ... "netpeer" enables the network peer 
controls, "openperm" affects the open permission.  Since this capability 
affects the network controls I believe "netalways" makes more sense.

> >> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> >> index 3ad2902..cb893f9 100644
> >> --- a/security/selinux/selinuxfs.c
> >> +++ b/security/selinux/selinuxfs.c
> >> @@ -44,7 +44,8 @@
> >> 
> >>  /* Policy capability filenames */
> >>  static char *policycap_names[] = {
> >>  
> >>  	"network_peer_controls",
> >> 
> >> -	"open_perms"
> >> +	"open_perms",
> >> +	"always_check_network"
> >> 
> >>  };
> > 
> > Similarly, I think "network_always" is more consistent.
> 
> Earlier discussions concluded with this capability name.  (to be specific
> the discussion resolved with always_check_packets, but that was before the
> peer class was included)

Once again, I don't believe I ever commented on the name of the capability, 
but I am now.  Disregard my comments or incorporate them, that is up to you, 
and ultimately Eric, to decide.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
