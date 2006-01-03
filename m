Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03JwKXf023845
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 14:58:20 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03JvEqa003852
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 19:57:15 GMT
Message-ID: <43BAD760.3060802@redhat.com>
Date: Tue, 03 Jan 2006 14:58:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: libsetrans performance patch
References: <200601040555.08511.russell@coker.com.au>
In-Reply-To: <200601040555.08511.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> I have optimised the libsetrans library a bit.  Changed locking of a FILE *, 
> removed some needless strdup/strlen operations, and fixed a bug whereby 
> strtrim could potentially copy random data from the heap (ended up removing 
> strtrim).
>   

I have added most of your previous patch to libsetrans-0.1.14-1  Please 
check to make sure I got everything.  There was one problem in your 
patch that caused untranslate to fail  a:b:c->a:b:c:s0

>   
> ------------------------------------------------------------------------
>
> diff -rup libsetrans-0.1.11.orig/src/setrans.c libsetrans-0.1.11/src/setrans.c
> --- libsetrans-0.1.11.orig/src/setrans.c	2005-12-08 00:50:31.000000000 +1100
> +++ libsetrans-0.1.11/src/setrans.c	2006-01-02 20:28:36.000000000 +1100
> @@ -3,7 +3,9 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdio.h>
> +#include <stdio_ext.h>
>  #include <ctype.h>
> +#include <alloca.h>
>  #include <selinux/selinux.h>
>  #include <selinux/context.h>
>  #include "dso.h"
> @@ -22,23 +24,6 @@ typedef struct labels {
>  
>  static labels_t *labellist=NULL;
>  
> -/* Remove excess white space */
> -static char * strtrim(char *dest, char *source, int size) {
> -	int i=0;
> -	char *ptr=source;
> -	i=0;
> -	while(isspace(*ptr) && i < size) {
> -		ptr++;
> -		i++;
> -	}
> -	strncpy(dest,ptr,size);
> -	for(i=strlen(dest)-1; i> 0; i--) {
> -		if (!isspace(dest[i])) break;
> -	}
> -	dest[i+1]='\0';
> -	return dest;
> -}
> -
>  void finish_context_translations(void) {
>  	labels_t *ptr=NULL;
>  	labels_t *current=NULL;
> @@ -56,54 +41,54 @@ void finish_context_translations(void) {
>  
>  /* Process line from translation file. 
>     Remove white space and set name do data before the "=" and sename to data
> -   after it */
> -static int process_label(const char *buffer, labels_t **labels) {
> -	char name[BUFSIZ];
> -	char name1[BUFSIZ];
> -	char *newbuf=strdup(buffer);
> -	int namesize=sizeof(name);
> +   after it
> +   May modify the data pointed to by the buffer paremeter */
> +static int process_label(char *buffer, labels_t **labels) {
> +	char *name, *name_end;
>  	labels_t *next=NULL;
> -	char *ptr;
> -	int rc=0;
> +	char *ptr, *tok;
>  	
> -	if (!newbuf) return -1;
> -
> -	char *tok=strtok_r(newbuf,"=",&ptr);
> -	if (!tok) goto err;
> -	strncpy(name1,tok, BUFSIZ-1);
> -	strtrim(name,name1,namesize-1);
> -	if ( name[0]=='#' ) goto err;
> -	tok=strtok_r(NULL,"\0",&ptr);
> -	if (!tok) goto err;
> +	while(isspace(*buffer))
> +		buffer++;
> +	if(buffer[0] == '#') return 0;
> +	name = strtok_r(buffer, "=", &ptr);
> +	if (!name || !*name) return 0;
> +	tok = strtok_r(NULL, "\0", &ptr);
> +	if (!tok) return 0;
> +	name_end = tok - 2;
> +	while(isspace(*name_end))
> +	{
> +		name_end = '\0';
> +		name_end--;
> +	}
>  	while (isspace(*tok)) tok++;
>   
THIS LINE SHOULD BE REMOVED so "" will translate to s0.
> +	if(!*tok) return 0;
>   

>  
>  	next=(labels_t *) calloc(1, sizeof(labels_t));
>  	if (!next) { 
> -		rc=-1; 
> -		goto err;
> +		return -1;
>  	}
>  
>  	next->label.name=strdup(name);
>  	if (!next->label.name) {
>  		free(next);
> -		rc=-1; 
> -		goto err;
> +		return -1;
>  	}
>  
> -	strncpy(name1,tok, BUFSIZ-1);
> -	strtrim(name,name1,namesize-1);
> -	next->label.sename=strdup(name);
> +	name_end = tok + strlen(tok) - 1;
> +	while(isspace(*name_end))
> +	{
> +		*name_end = '\0';
> +		name_end--;
> +	}
> +	next->label.sename=strdup(tok);
>  	if (!next->label.sename) {
>  		free(next->label.name);
>  		free(next);
> -		rc=-1; 
> -		goto err;
> +		return -1;
>  	}
>  	*labels=next;
> -	rc=1;
> -err:		
> -	free(newbuf);
> -	return rc;
> +	return 1;
>  }
>  
>  /* Look for selabel via internal name */
> @@ -121,21 +106,15 @@ static const char *translate_internal(co
>  }
>  static char *translate_categories(const char *sensitivity, const char *cat) {
>  	char *label=NULL;
> -	char *inbuf=NULL;
> -	int slen=strlen(sensitivity);
> +	char *inbuf = alloca(strlen(sensitivity) + strlen(cat) + 2);
>  	char *ptr;
>  	int error=0;
> -	char *categories=strdup(cat);
> -	if (!categories) return NULL;
> +	char *categories=strdupa(cat);
> +	if (!categories || !inbuf) return NULL;
>  	char *tok=strtok_r(categories,",",&ptr);
>  
>  	while (tok) {
>  		const char *trans;
> -		inbuf=malloc(slen+strlen(tok)+2);
> -		if (!inbuf) {
> -			error=1;
> -			break;
> -		}
>  		sprintf(inbuf, "%s:%s", sensitivity, tok);
>  		trans=translate_internal(inbuf);
>  		if (strcmp(trans, inbuf)==0) {
> @@ -156,13 +135,10 @@ static char *translate_categories(const 
>  			}
>  			free(tmp);
>  		}
> -		free(inbuf); inbuf=NULL;
>  		tok=strtok_r(NULL,",",&ptr);
>  	}
> -	free(categories);
>  	if (error) {
>  		if (label) free(label);
> -		if (inbuf) free(inbuf);
>  		return NULL;
>  	}
>  	return label;
> @@ -175,7 +151,7 @@ static const char *translate(const char 
>  	if (orig) {
>  		if (strcmp(orig,labels)==0) {
>  			char *translated=NULL;
> -			char *tmpbuf=strdup(orig);
> +			char *tmpbuf=strdupa(orig);
>  			char *ptr=NULL;
>  			char *tok=NULL;
>  			char *sensitivity=NULL;
> @@ -196,8 +172,6 @@ static const char *translate(const char 
>  				
>  			}
>  		done:
> -			if (tmpbuf)
> -				free(tmpbuf);
>  			if (categories) {
>  				free(categories);
>  				return translated;
> @@ -209,7 +183,7 @@ static const char *translate(const char 
>  }
>  
>  /* Look for selabel via external name */
> -static char *untranslate_internal(const char *sename) {
> +static const char *untranslate_internal(const char *sename) {
>  	labels_t *ptr=NULL;
>  	if (labellist) 
>  		for(ptr=labellist->next;ptr; ptr=ptr->next) 
> @@ -223,7 +197,7 @@ static char *untranslate(const char *sen
>  	if (orig) {
>  		if (strcmp(orig,sename)==0) {
>  			char *untranslated=NULL;
> -			char *tmpbuf=strdup(orig);
> +			char *tmpbuf=strdupa(orig);
>  			char *ptr=NULL;
>  			char *tok=NULL;
>  			char *sensitivity=NULL;
> @@ -245,7 +219,8 @@ static char *untranslate(const char *sen
>  						break;
>  					}
>  				} else {
> -					sensitivity=calloc(1,idx+1);
> +					sensitivity = alloca(idx + 1);
> +					sensitivity[idx] = '\0';
>  					strncpy(sensitivity, utrans, idx);
>  				}
>  				category=&utrans[idx+1];
> @@ -266,10 +241,6 @@ static char *untranslate(const char *sen
>  				tok=strtok_r(NULL,",",&ptr);
>  			}
>  		done:
> -			if (tmpbuf)
> -				free(tmpbuf);
> -			if (sensitivity) 
> -				free(sensitivity);
>  			if (error) {
>  				if (untranslated) 
>  					free(untranslated);
> @@ -302,6 +273,7 @@ int init_context_translations(void) {
>  	cfg = fopen(selinux_translations_path(),"r");
>  	if (!cfg) return 1;
>  
> +	__fsetlocking(cfg, FSETLOCKING_BYCALLER);
>  	ptr=labellist=calloc(1,sizeof(labels_t));
>  	if (!ptr) {
>  		fclose(cfg);
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
