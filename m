Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3SHs2dF016758
 for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2016 13:54:02 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so10035337pac.1
 for <selinux@tycho.nsa.gov>; Thu, 28 Apr 2016 10:53:41 -0700 (PDT)
Date: Fri, 29 Apr 2016 01:53:37 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 5/8] genhomedircon: Add uid and gid to struct user_entry
Message-ID: <20160428175337.GA26112@meriadoc>
References: <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-1-git-send-email-jason@perfinion.com>
 <1461391499-20593-6-git-send-email-jason@perfinion.com>
 <4a2931ae-680d-71f3-36d8-51077e93a761@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4a2931ae-680d-71f3-36d8-51077e93a761@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 27, 2016 at 01:04:25PM -0400, Stephen Smalley wrote:
> On 04/23/2016 02:04 AM, Jason Zaman wrote:
> > Signed-off-by: Jason Zaman <jason@perfinion.com>
> > ---
> >  libsemanage/src/genhomedircon.c | 34 ++++++++++++++++++++++++++++++----
> >  1 file changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> > index 1a7882c..56c58e0 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -82,10 +82,13 @@
> >  #define FALLBACK_PREFIX "user"
> >  #define FALLBACK_LEVEL "s0"
> >  #define FALLBACK_NAME ".*"
> > +#define FALLBACK_UIDGID "[0-9]+"
> >  #define DEFAULT_LOGIN "__default__"
> >  
> >  typedef struct user_entry {
> >  	char *name;
> > +	char *uid;
> > +	char *gid;
> >  	char *sename;
> >  	char *prefix;
> >  	char *home;
> > @@ -628,11 +631,13 @@ static int name_user_cmp(char *key, semanage_user_t ** val)
> >  }
> >  
> >  static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
> > -			   const char *sen, const char *pre, const char *h,
> > -			   const char *l)
> > +			   const char *u, const char *g, const char *sen,
> > +			   const char *pre, const char *h, const char *l)
> >  {
> >  	genhomedircon_user_entry_t *temp = NULL;
> >  	char *name = NULL;
> > +	char *uid = NULL;
> > +	char *gid = NULL;
> >  	char *sename = NULL;
> >  	char *prefix = NULL;
> >  	char *home = NULL;
> > @@ -644,6 +649,12 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
> >  	name = strdup(n);
> >  	if (!name)
> >  		goto cleanup;
> > +	uid = strdup(u);
> > +	if (!uid)
> > +		goto cleanup;
> > +	gid = strdup(g);
> > +	if (!gid)
> > +		goto cleanup;
> >  	sename = strdup(sen);
> >  	if (!sename)
> >  		goto cleanup;
> > @@ -658,6 +669,8 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
> >  		goto cleanup;
> >  
> >  	temp->name = name;
> > +	temp->uid = uid;
> > +	temp->gid = gid;
> >  	temp->sename = sename;
> >  	temp->prefix = prefix;
> >  	temp->home = home;
> > @@ -669,6 +682,8 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
> >  
> >        cleanup:
> >  	free(name);
> > +	free(uid);
> > +	free(gid);
> >  	free(sename);
> >  	free(prefix);
> >  	free(home);
> > @@ -687,6 +702,8 @@ static void pop_user_entry(genhomedircon_user_entry_t ** list)
> >  	temp = *list;
> >  	*list = temp->next;
> >  	free(temp->name);
> > +	free(temp->uid);
> > +	free(temp->gid);
> >  	free(temp->sename);
> >  	free(temp->prefix);
> >  	free(temp->home);
> > @@ -738,7 +755,8 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
> >  					level = FALLBACK_LEVEL;
> >  			}
> >  
> > -			if (push_user_entry(&(s->fallback), FALLBACK_NAME, 0, 0,
> > +			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
> > +					    FALLBACK_UIDGID, FALLBACK_UIDGID,
> >  					    seuname, prefix, "", level) != 0)
> >  				errors = STATUS_ERR;
> >  			semanage_user_key_free(key);
> > @@ -768,6 +786,8 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
> >  	const char *seuname = NULL;
> >  	const char *prefix = NULL;
> >  	const char *level = NULL;
> > +	char uid[10];
> > +	char gid[10];
> 
> You need to allow space for the NUL terminator.

2^32 = 4294967296 so 10 digits + null. i'll send an updated patch.
> 
> >  	struct passwd pwstorage, *pwent = NULL;
> >  	unsigned int i;
> >  	long rbuflen;
> > @@ -852,7 +872,13 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
> >  		}
> >  		if (ignore(pwent->pw_dir))
> >  			continue;
> > -		if (push_user_entry(&head, name, seuname,
> > +
> > +		if (snprintf(uid, sizeof(uid), "%d", pwent->pw_uid) < 0
> > +		 || snprintf(gid, sizeof(gid), "%d", pwent->pw_gid) < 0) {
> 
> Should you be using %u instead of %d?
yes, its unsigned, will fix.

> Also, snprintf returns >= size if the output was truncated, not < 0.

>From the man page:
RETURN VALUE
[...] Thus, a return value of size or more means that the output was truncated.
If an output error is encountered, a negative value is returned.

I definitely need to check <0. but do I *also* need to check >= size? I
dont think that can ever happen since 10chars+NULL fits fine.

-- Jason

> > +			*errors = STATUS_ERR;
> > +			goto cleanup;
> > +		}
> > +		if (push_user_entry(&head, name, uid, gid, seuname,
> >  				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
> >  			*errors = STATUS_ERR;
> >  			break;
