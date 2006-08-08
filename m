MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2 take 2] userland support for new range_transition statements
Date: Tue, 8 Aug 2006 18:25:32 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AE65@exchange.columbia.tresys.com>
In-Reply-To: <44D37F6D.70207@trustedcs.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Darrel Goeddel" <dgoeddel@TrustedCS.com>
Cc: "SELinux List" <SELinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
> 

Sorry it took so long to reply to this.

> 
>  for module policy versions up to 6, there are no 
> range_transitions  for base policy versions 6 and up, an 

This is only per the grammar right? You are writing range_trans_rule_t's
in every avrule block so version 6 does support them, just not the
grammar yet.


>  #if 0
> @@ -307,6 +326,32 @@
>  	}
>  }
>  
> +void range_trans_rule_init(range_trans_rule_t *x) {
> +	type_set_init(&x->stypes);
> +	type_set_init(&x->ttypes);
> +	ebitmap_init(&x->tclasses);
> +	mls_range_init(&x->trange);
> +}

x->next = NULL? 


That's all I have, looks good sans the semantic range representation. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
