From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] SELinux: create new open permission
Date: Thu, 28 Feb 2008 12:15:44 -0500
Cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org
References: <1204211391.3206.66.camel@localhost.localdomain>
In-Reply-To: <1204211391.3206.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802281215.45063.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 February 2008 10:09:51 am Eric Paris wrote:
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c index 0341567..6e31ce6 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -43,6 +43,7 @@
>  /* Policy capability filenames */
>  static char *policycap_names[] = {
>  	"network_peer_controls"
> +	"open_perms"
>  };

I think you're missing a comma here :)

This is easy to test by simply checking the /selinux/policy_capabilities 
directory.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
