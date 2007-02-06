From: V13 <v13@priest.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] libsepol:  check for unmet requires on sensitivities and categories (Was:  Re: core dump)
Date: Tue, 6 Feb 2007 15:24:29 +0200
Cc: selinux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <200702060412.33276.v13@priest.com> <1170765638.12293.362.camel@moss-spartans.epoch.ncsc.mil> <1170767196.12293.375.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170767196.12293.375.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200702061524.29509.v13@priest.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 06 February 2007 15:06, Stephen Smalley wrote:
> Patch below for the stable branch.
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
> Index: libsepol/src/link.c
> ===================================================================
> --- libsepol/src/link.c	(revision 2221)
> +++ libsepol/src/link.c	(working copy)
> @@ -597,6 +597,13 @@
>  			    state->cur_mod_name);
>  			return -SEPOL_LINK_NOTSUP;
>  		}
> +		if (scope->scope == SCOPE_REQ) {
> +			/* unmet requirement */
> +			ERR(state->handle,
> +			    "%s:  Sensitivity %s not declared by base.\n",
> +			    state->cur_mod_name, id);
> +			return -SEPOL_LINK_NOTSUP;
> +		}
>  	}

May I recomend that an:

assert(0);

been added at the end of the outter if statement or there is no way that 
another SCOPE_ value will be added in the future. In the latter case, perhaps 
an enum (for the SCOPE_* values) and a switch() (instead of the ifs) would be 
better. gcc warns on switch() statements that don't handle all values of an 
enum.

<<V13>>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
