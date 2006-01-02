Message-ID: <43B979B6.8090201@tresys.com>
Date: Mon, 02 Jan 2006 14:06:30 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Swig update: typemaps
References: <43AF074E.6040301@cornell.edu>
In-Reply-To: <43AF074E.6040301@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Merry Christmas everyone!
> 
> This patch updates the typemaps to add booleans, interfaces, context, 
> and char** (for context_to_string). I really don't know what I'm doing 
> here with those typemaps, so I would appreciate if someone (Joshua?) can 
> look over. I was just following the pattern, with minor changes, and it 
> seems to work for a port list function that I wrote for the semanage tool.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
> --- old/libsemanage/src/semanageswig.i	2005-12-25 15:50:26.000000000 -0500
> +++ new/libsemanage/src/semanageswig.i	2005-12-25 15:48:13.000000000 -0500
> @@ -51,7 +51,13 @@
>  	}	
>  	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n) {
>  		return list[n];
> -	}	
> +	}
> +	semanage_iface_t *semanage_iface_by_idx(semanage_iface_t **list, int n) {
> +		return list[n];
> +	}
> +	semanage_bool_t *semanage_bool_by_idx(semanage_bool_t **list, int n) {
> +		return list[n];
> +	}
>  	char *char_by_idx(char **list, int n) {
>  		return list[n];
>  	}
Man.. adding that first semanage_*_by_idx was just a quick hack to get 
something working, we should probably move those into the proper 
libsemanage API instead of just adding them to the wrapper (they are 
clearly useful)

> @@ -67,6 +73,14 @@
>  %apply int *OUTPUT { int * };
>  %apply int *OUTPUT { size_t * };
>  
> +%typemap(in, numinputs=0) char **(char *temp) {
> +	$1 = &temp;
> +}
> +
> +%typemap(argout) char** {
> +	$result = t_output_helper($result, SWIG_FromCharPtr(*$1));
> +}
> +

Have to be careful with this one, you don't want it messing with other 
char**. Did you run all the tests in pywrap-test after rebuilding this 
to make sure it didn't interrupt anything else?

The rest look fine.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
