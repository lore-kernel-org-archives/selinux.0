Subject: Re: [RFC 1/3] hook callbacks
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Josh Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <1154433106.23513.8.camel@twoface.columbia.tresys.com>
References: <1154433106.23513.8.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:49:42 -0400
Message-Id: <1155160182.942.109.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 07:51 -0400, Josh Brindle wrote:

<snip>

> +
> +typedef struct sepol_security_internal sepol_security_internal_t;
> +
> +typedef struct sepol_security_ops {
> +	int (*symbol_add) (int sym_type, char *type);
> +	int (*symbol_remove) (int sym_type, char *type);
> +
> +	/* type hooks */
> +	int (*type_add_attrib) (char *attrib, char *type);
> +

It seems more natural for this to be the reverse (attrib_add_type)
though I understand that it doesn't really matter.

> +	/* role hooks */
> +	int (*role_allow_add) (char *role, char *new_role);
> +	int (*role_trans_add) (char *role, char *type, char *new_role);
> +	int (*role_add_type) (char *role, char *type);
> +
> +	/* user hooks */
> +	int (*user_add_role) (char *user, char *role);
> +
> +	int (*avrule_add) (int type, char *src, char *tgt, char *class, char **perms, int num_perms);
> +

Type rules aren't handled at all? Neverallow (to prevent those DOS
attacks on policy add).

For the syntactic checking that I am suggesting you will need to add
checks for the use of each symbol in each rule variant.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
