Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBTIhtQf013105
 for <selinux@tycho.nsa.gov>; Thu, 29 Dec 2016 13:43:55 -0500
Message-ID: <1483037027.25804.3.camel@trentalancia.net>
Subject: Re: libsemanage: special handling of the identity reserved to
 system objects
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Thu, 29 Dec 2016 19:43:47 +0100
In-Reply-To: <dba3b2de-d089-8719-9f0c-f8da0ff9b7e9@gmail.com>
References: <1482966318.30976.5.camel@trentalancia.net>
 <dba3b2de-d089-8719-9f0c-f8da0ff9b7e9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 29/12/2016 at 10.30 +0100, Dominick Grift wrote:
> On 12/29/2016 12:05 AM, Guido Trentalancia wrote:
> > 
> > The following patch makes sure that the SELinux identity
> > reserved for system processes and objects is skipped
> > when adding users and that no prefix is associated to it.
> > 
> > A warning is produced when a Unix identity is found to be
> > equal to the SELinux user identity for system processes
> > and objects.
> > 
> > Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> > ---
> >  include/semanage/user_record.h |    2 ++
> >  src/genhomedircon.c            |   20 ++++++++++++++++----
> >  src/user_record.c              |   15 ++++++++++++---
> >  3 files changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff -pru libsemanage-2.6-orig/include/semanage/user_record.h
> > libsemanage-2.6/include/semanage/user_record.h
> > --- libsemanage-2.6-orig/include/semanage/user_record.h	2016
> > -10-14 17:31:26.000000000 +0200
> > +++ libsemanage-2.6/include/semanage/user_record.h	2016-12-
> > 28 23:22:50.848589870 +0100
> > @@ -6,6 +6,8 @@
> >  #include <stddef.h>
> >  #include <semanage/handle.h>
> >  
> > +#define SYS_OBJECTS_USERID	"system_u"
> 
> SELinux is supposed to be a flexible and customizable framework that
> allow for fine-grained mandatory access control.
> 
> hard-coding customizable identifiers is frowned upon by some of us

No one likes hard-coding identifiers but, at the moment, I can't easily
think of a better alternative.

I have created an improved version of this patch that I am going to
post.

If you have a better idea on how to determine the identity reserved for
system objects in libsemanage without hard-coding the identifier,
please let me know and I will eventually improve this patch...

> > +
> >  struct semanage_user;
> >  typedef struct semanage_user semanage_user_t;
> >  
> > diff -pru libsemanage-2.6-orig/src/genhomedircon.c libsemanage-
> > 2.6/src/genhomedircon.c
> > --- libsemanage-2.6-orig/src/genhomedircon.c	2016-10-14
> > 17:31:26.000000000 +0200
> > +++ libsemanage-2.6/src/genhomedircon.c	2016-12-28
> > 23:34:38.510319855 +0100
> > @@ -998,14 +998,26 @@ static int add_user(genhomedircon_settin
> >  		homedir_role = prefix;
> >  	}
> >  
> > +	/* There should be no Unix identity corresponding
> > +	 * to SELinux user reserved for system processes
> > +	 * and objects */
> >  	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen,
> > &pwent);
> > -	if (retval != 0 || pwent == NULL) {
> > -		if (retval != 0 && retval != ENOENT) {
> > +	if (strcmp(name, SYS_OBJECTS_USERID)) {
> > +		if (retval != 0 || pwent == NULL) {
> > +			if (retval != 0 && retval != ENOENT) {
> > +				goto cleanup;
> > +			}
> > +
> > +			WARN(s->h_semanage,
> > +			     "user %s not in password file",
> > name);
> > +			retval = STATUS_SUCCESS;
> >  			goto cleanup;
> >  		}
> > +	} else {
> > +		if (retval)
> > +			WARN(s->h_semanage,
> > +			     "There should be no Unix identity
> > \"%s\" !", SYS_OBJECTS_USERID);
> >  
> > -		WARN(s->h_semanage,
> > -		     "user %s not in password file", name);
> >  		retval = STATUS_SUCCESS;
> >  		goto cleanup;
> >  	}
> > diff -pru libsemanage-2.6-orig/src/user_record.c libsemanage-
> > 2.6/src/user_record.c
> > --- libsemanage-2.6-orig/src/user_record.c	2016-10-14
> > 17:31:26.000000000 +0200
> > +++ libsemanage-2.6/src/user_record.c	2016-12-28
> > 23:30:51.544449423 +0100
> > @@ -348,9 +348,18 @@ hidden int semanage_user_join(semanage_h
> >  		if (semanage_user_extra_set_name(handle, tmp_user-
> > >extra, name)
> >  		    < 0)
> >  			goto err;
> > -		if (semanage_user_extra_set_prefix
> > -		    (handle, tmp_user->extra, "user") < 0)
> > -			goto err;
> > +
> > +		/* The user identity reserved for system processes
> > +		 * and objects shall have no prefix */
> > +		if (strcmp(name, SYS_OBJECTS_USERID)) {
> > +			if (semanage_user_extra_set_prefix
> > +			    (handle, tmp_user->extra, "user") < 0)
> > +				goto err;
> > +		} else {
> > +			if (semanage_user_extra_set_prefix
> > +			    (handle, tmp_user->extra, "") < 0)
> > +				goto err;
> > +		}
> >  	}
> >  
> >  	if (semanage_user_set_name(handle, tmp_user, name) < 0)
> > _______________________________________________

Regards,

Guido
