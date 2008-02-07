Subject: Re: [patch] refpolicy: add capability2 class
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1202401746.27371.265.camel@moss-spartans.epoch.ncsc.mil>
References: <1202401746.27371.265.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 12:42:54 -0500
Message-Id: <1202406174.7533.114.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-02-07 at 11:29 -0500, Stephen Smalley wrote:
> Add the capability2 class to policy for capabilities 32-63.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merged.

> ---
> 
>  refpolicy/policy/flask/access_vectors   |    6 ++++++
>  refpolicy/policy/flask/security_classes |    3 +++
>  2 files changed, 9 insertions(+)
> 
> 
> Index: refpolicy/policy/flask/security_classes
> ===================================================================
> --- refpolicy/policy/flask/security_classes	(revision 2594)
> +++ refpolicy/policy/flask/security_classes	(working copy)
> @@ -109,4 +109,7 @@
>  # network peer labels
>  class peer
>  
> +# Capabilities >= 32
> +class capability2
> +
>  # FLASK
> Index: refpolicy/policy/flask/access_vectors
> ===================================================================
> --- refpolicy/policy/flask/access_vectors	(revision 2594)
> +++ refpolicy/policy/flask/access_vectors	(working copy)
> @@ -347,6 +347,7 @@
>  class capability
>  {
>  	# The capabilities are defined in include/linux/capability.h
> +	# Capabilities >= 32 are defined in the capability2 class.
>  	# Care should be taken to ensure that these are consistent with
>  	# those definitions. (Order matters)
>  
> @@ -384,6 +385,11 @@
>  	setfcap
>  }
>  
> +class capability2 
> +{
> +	mac_override	# unused by SELinux
> +	mac_admin	# unused by SELinux
> +}
>  
>  #
>  # Define the access vector interpretation for controlling
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
