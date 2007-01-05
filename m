Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing
	PTYs,	sshd,	and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Antill <jantill@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, Klaus Weidner <klaus@atsec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <459E7BA2.1050109@redhat.com>
References: <20070105033311.GA24315@w-m-p.com>
	 <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
	 <20070105040119.GB24315@w-m-p.com>
	 <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
	 <459E7BA2.1050109@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 13:43:06 -0500
Message-Id: <1168022586.18961.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-05 at 11:24 -0500, Daniel J Walsh wrote:
> newrole patch. for checking securetty.
> 
> 
> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
> --exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c 
> policycoreutils-1.33.8/newrole/newrole.c
> --- nsapolicycoreutils/newrole/newrole.c        2007-01-04 
> 17:01:41.000000000 -0500
> +++ policycoreutils-1.33.8/newrole/newrole.c    2007-01-05 
> 11:17:36.000000000 -0500
> @@ -793,6 +797,18 @@
>                                         "specified\n"));
>                                 return -1;
>                         }
> +                       for (i=0; i < 3; i++) {
> +                               securetty=0;
> +                               if (fgetfilecon(i,&tty_con) >= 0) {
> +                                       securetty = 
> (selinux_check_securetty_context(tty_con) == 1);
> +                                       freecon(tty_con);
> +                               }
> +                               if (!securetty) {
> +                                       fprintf(stderr, "Error: you are 
> not allowed to change levels on a non secure terminal\n");
> +                                       return -1;
> +                               }
> +                       }
> +
>                         level_s = optarg;
>                         break;
>                 default:
> 

Aside from whitespace damage, do we need to check all three descriptors?
newrole only calls ttyname(0) and then re-opens that on all three
descriptors, so even if 1 and 2 point to something else, they would be
ignored (never relabeled, just closed).  So I would think you would only
need to check descriptor 0.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
