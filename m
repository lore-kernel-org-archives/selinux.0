Message-ID: <44C8CCC7.7030703@mentalrootkit.com>
Date: Thu, 27 Jul 2006 10:25:11 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] clean up datum cast to uint32
References: <1153914526.19259.25.camel@twoface>
In-Reply-To: <1153914526.19259.25.camel@twoface>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> This patch adds a function to get the symbol value from any datum passed
> in given the symbol type (SYM_TYPE, SYM_ROLE, etc) and removes the
> places where a datum was cast to uint32_t* to get the value.
>
>   

I like cleaning this up as that cast was not great. My concern with this 
patch is that it forces information / functions about many types to be 
forced into a single place. An alternative is to define a struct that 
must be included first for all symtab datums, i.e.:

typedef struct symtab_datum {
    uint32_t val;
} symtab_datum_t

This would be included first in all datums for the symtabs:

typedef struct comman_datum {
    symtab_datum_t s;
    symtab_t permissions;
}

This would allow all of the datums to be cast to symtab_datum_t and 
avoid all of the stub functions for type safety (not to mention the 2 
function calls required to get the value). That would also allow moving 
some shared code for managing values into symtab.c/h.

I can work this patch up, I just wanted to get comments first because it 
will be a large (but easy) change because of adding references to 
datum->s.value instead of datum->value.

Thoughts?

Karl

> diff -pruN -x.svn trunk/checkpolicy/module_compiler.c branch/sym_val/checkpolicy/module_compiler.c
> --- trunk/checkpolicy/module_compiler.c	2006-06-29 14:54:15.000000000 -0400
> +++ branch/sym_val/checkpolicy/module_compiler.c	2006-07-26 07:38:04.000000000 -0400
> @@ -17,6 +17,7 @@
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/avrule_block.h>
>  #include <sepol/policydb/conditional.h>
> +#include <sepol/policydb/sym_val.h>
>  
>  #include "queue.h"
>  #include "module_compiler.h"
> @@ -129,6 +130,7 @@ int declare_symbol(uint32_t symbol_type,
>  {
>  	avrule_decl_t *decl = stack_top->decl;
>  	int retval;
> +	uint32_t val;
>  
>  	/* first check that symbols may be declared here */
>  	if (!is_declaration_allowed()) {
> @@ -137,15 +139,10 @@ int declare_symbol(uint32_t symbol_type,
>  	retval = symtab_insert(policydbp, symbol_type, key, datum,
>  			       SCOPE_DECL, decl->decl_id, dest_value);
>  	if (retval == 1) {
> -		/* because C has no polymorphism, make the
> -		 * [outrageous] assumption that the first field of all
> -		 * symbol table data is a uint32_t representing its
> -		 * value */
> -		uint32_t *v =
> -		    (uint32_t *) hashtab_search(policydbp->symtab[symbol_type].
> -						table, key);
> -		assert(v != NULL);
> -		*dest_value = *v;
> +		val = get_sym_val(hashtab_search(policydbp->symtab[symbol_type].
> +						table, key), symbol_type);
> +		assert(val != 0);
> +		*dest_value = val;
>  	} else if (retval == -2) {
>  		return -2;
>  	} else if (retval < 0) {
> @@ -486,6 +483,7 @@ int require_symbol(uint32_t symbol_type,
>  {
>  	avrule_decl_t *decl = stack_top->decl;
>  	int retval;
> +	uint32_t val;
>  
>  	/* first check that symbols may be required here */
>  	if (!is_require_allowed()) {
> @@ -494,15 +492,10 @@ int require_symbol(uint32_t symbol_type,
>  	retval = symtab_insert(policydbp, symbol_type, key, datum,
>  			       SCOPE_REQ, decl->decl_id, dest_value);
>  	if (retval == 1) {
> -		/* because C has no polymorphism, make the
> -		 * [outrageous] assumption that the first field of all
> -		 * symbol table data is a uint32_t representing its
> -		 * value */
> -		uint32_t *v =
> -		    (uint32_t *) hashtab_search(policydbp->symtab[symbol_type].
> -						table, key);
> -		assert(v != NULL);
> -		*dest_value = *v;
> +		val = get_sym_val(hashtab_search(policydbp->symtab[symbol_type].
> +						table, key), symbol_type);
> +		assert(val != 0);
> +		*dest_value = val;
>  	} else if (retval == -2) {
>  		/* ignore require statements if that symbol was
>  		 * previously declared and is in current scope */
> diff -pruN -x.svn trunk/libsepol/include/sepol/policydb/sym_val.h branch/sym_val/libsepol/include/sepol/policydb/sym_val.h
> --- trunk/libsepol/include/sepol/policydb/sym_val.h	1969-12-31 19:00:00.000000000 -0500
> +++ branch/sym_val/libsepol/include/sepol/policydb/sym_val.h	2006-07-26 07:39:05.000000000 -0400
> @@ -0,0 +1,25 @@
> +/* Authors: Joshua Brindle <jbrindle@tresys.com>  
> + *
> + * Copyright (C) 2006 Tresys Technology, LLC
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#ifndef __SEPOL_SYM_VAL_H__
> +#define __SEPOL_SYM_VAL_H__
> +
> +extern uint32_t get_sym_val(void *datum, int sym_type);
> +
> +#endif
> diff -pruN -x.svn trunk/libsepol/src/sym_val.c branch/sym_val/libsepol/src/sym_val.c
> --- trunk/libsepol/src/sym_val.c	1969-12-31 19:00:00.000000000 -0500
> +++ branch/sym_val/libsepol/src/sym_val.c	2006-07-26 07:36:59.000000000 -0400
> @@ -0,0 +1,76 @@
> +/* Authors: Joshua Brindle <jbrindle@tresys.com>
> + *
> + * Copyright (C) 2005 Tresys Technology, LLC
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <assert.h>
> +#include <sepol/policydb/policydb.h>
> +
> +static uint32_t common_datum_val(void *datum)
> +{
> +	return ((common_datum_t *)datum)->value;
> +}
> +
> +static uint32_t class_datum_val(void *datum)
> +{
> +	return ((class_datum_t *)datum)->value;
> +}
> +
> +static uint32_t role_datum_val(void *datum)
> +{
> +	return ((role_datum_t *)datum)->value;
> +}
> +
> +static uint32_t type_datum_val(void *datum)
> +{
> +	return ((type_datum_t *)datum)->value;
> +}
> +
> +static uint32_t user_datum_val(void *datum)
> +{
> +	return ((user_datum_t *)datum)->value;
> +}
> +
> +static uint32_t bool_datum_val(void *datum)
> +{
> +	return ((cond_bool_datum_t *)datum)->value;
> +}
> +
> +static uint32_t cat_datum_val(void *datum)
> +{
> +	return ((cat_datum_t *)datum)->value;
> +}
> +
> +static uint32_t (*datum_val_f[SYM_NUM]) (void *datum) =
> +{
> +	common_datum_val,
> +	class_datum_val,
> +	role_datum_val,
> +	type_datum_val,
> +	user_datum_val,
> +	bool_datum_val,
> +	NULL,
> +	cat_datum_val,
> +};
> +
> +uint32_t get_sym_val(void *datum, int sym_type)
> +{
> +	if (datum == NULL || datum_val_f[sym_type] == NULL)
> +		return 0;
> +
> +	return datum_val_f[sym_type](datum);
> +}
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
