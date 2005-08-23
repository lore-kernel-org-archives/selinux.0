Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NI3XOb000649
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 14:03:33 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NHrHcX022868
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 17:53:19 GMT
Message-ID: <430B62DF.4080602@redhat.com>
Date: Tue, 23 Aug 2005 13:54:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020302080409040709080906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020302080409040709080906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Updated setrans.c to handle s0 and multiple categories. 

-- 



--------------020302080409040709080906
Content-Type: text/x-csrc;
 name="setrans.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setrans.c"

#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <selinux/selinux.h>
#include <selinux/context.h>

#define CATEGORYFILE "/etc/secat.conf"

/* Define data structures */
typedef struct selevel {
	char* name;
	char* sename;
} selevel_t;

/* catlist is a simple linked list of selevels extracted from the CATEGORYFILE */
typedef struct cat {
	struct cat *next;
	selevel_t level;
} cat_t;

static cat_t *catlist=NULL;

/* Remove excess white space */
static char *strtrim(char *dest, char *source, int size) {
	int i=0;
	char *ptr=source;
	i=0;
	while(isspace(*ptr) && i < size) {
		ptr++;
		i++;
	}
	strncpy(dest,ptr,size);
	for(i=strlen(dest)-1; i> 0; i--) {
		if (!isspace(dest[i])) break;
	}
	dest[i+1]='\0';
	return dest;
}
/* Process line from CATEGORYFILE. 
   Remove white space and set name do data before the "=" and sename to data
   after it */
static int process_category(char *buffer, cat_t **cat) {
	char name[BUFSIZ];
	char name1[BUFSIZ];
	int namesize=sizeof(name);
	struct cat *next;
	char *ptr;
	char *tok=strtok_r(buffer,"=",&ptr);
	if (!tok) return 0;
	strncpy(name1,tok, BUFSIZ-1);
	strtrim(name,name1,namesize-1);
	if ( name[0]=='#' ) return 0;
	tok=strtok_r(NULL,"\0",&ptr);
	if (!tok) return 0;
	while (isspace(*tok)) tok++;
	next=(cat_t *) calloc(sizeof(cat_t), 1);
	if (!next) return 0;
	next->level.name=strdup(name);
	if (!next->level.name) {
		free(next);
		return 0;
	}
	strncpy(name1,tok, BUFSIZ-1);
	strtrim(name,name1,namesize-1);
	next->level.sename=strdup(name);
	if (!next->level.sename) {
		free(next->level.name);
		free(next);
		return 0;
	}
	*cat=next;
	return 1;
}

/* Read in CATEGORYFILE Only runs once per process.  
   Might want to change to some kind of reload eventually, for long running
   processes.
 */
int init_context_translations(void) {
	FILE *cfg;
	cat_t *ptr=NULL;
	cat_t *next=NULL;
	size_t size=0;
	char *buffer=NULL;
	int ctr=0;
	if (catlist) return 0;
	cfg = fopen(CATEGORYFILE,"r");
	if (cfg == NULL) 
		return 1;

	ptr=catlist=calloc(1,sizeof(cat_t));
	while (getline(&buffer, &size, cfg) > 0) {
		if (process_category(buffer, &next)) {
			ctr++;
			ptr->next=next;
			ptr=next;
		}
	}
	if (buffer)
		free(buffer);
	return 0;
}

/* Look for selevel via internal name */
static char *translate(const char *cat) {
	cat_t *ptr=NULL;
	if (catlist) 
		for (ptr=catlist->next;ptr; ptr=ptr->next) 
			if (strcmp(cat,ptr->level.name)==0) {
				if (strlen(ptr->level.sename)==0)
					return NULL;
				else
					return strdup(ptr->level.sename); 
			}
	return strdup(cat);
}

/* Look for selevel via external name */
static char *untranslate(const char *sename) {
	cat_t *ptr=NULL;
	if (catlist) 
		for(ptr=catlist->next;ptr; ptr=ptr->next)
			if (strcmp(sename,ptr->level.sename)==0) {
				char *buf=calloc(strlen(ptr->level.name+4),1);
				if (buf) 
					sprintf(buf, "s0:%s",ptr->level.name); 
				return buf; 
			}
	return strdup(sename);
}

/* Look for selevel via external name */
int translate_context( const security_context_t oldcon, security_context_t *rcon) {
	const char *range=NULL;
	const char *ptr=NULL;
	context_t con=context_new(oldcon);

	if (! con)
		return -1;

	range=context_range_get(con);
	if (range) {
		ptr=strrchr(range,':');
		if (ptr) 
			ptr++;
		else
			ptr=range;
		context_range_set(con,translate(ptr));
	}
	*rcon=strdup(context_str(con));
	context_free(con);
	return 0;
}

/* Look for selevel via external name */
int untranslate_context( const security_context_t oldcon, security_context_t *rcon) {
	const char *range=NULL;
	char *newrange=NULL;
	context_t con=context_new(oldcon);

	if (! con)
		return -1;

	range=context_range_get(con);
	if (range) {
		newrange=untranslate(range);
		if (newrange) {
			context_range_set(con,newrange);
		}
	}
	*rcon=strdup(context_str(con));
	context_free(con);
	return 0;
}



--------------020302080409040709080906
Content-Type: text/plain;
 name="secat.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="secat.conf"

#
# Multiple Category System translation table for SELinux
# 
# Sensitivities s0= should not be modified
# Objects can be categorized with 0-127 categories defined by the admin.
# Objects can be in more then one categories at a time.
# Categories are stored in the system as c0-c127.  Users can use this
# table to translate the categories into a more meaningfull output.
# Examples:
# c0=CompanyConfidential
# c1=PatientRecord
# c2=Unclassified
# c3=TopSecret
# c1,c3=CompanyConfidentialRedHat
s0=


--------------020302080409040709080906--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
