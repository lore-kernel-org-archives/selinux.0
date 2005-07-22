Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFlCgA006660
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:47:12 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFfcKk009640
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:41:38 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E10804.5030401@tresys.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 11:39:57 -0400
Message-Id: <1122046798.25951.27.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> >That's why I'm asking for an intermediate representation. My particular
> >implementation of it may not be very good (suggestions welcome), 
> >but it's certainly better than what's out there - I don't think 
> >passing in policy-dependent integer id's, and exposing internal data
> >structures will make a successful api.
> >  
> >
> The module format is an intermediate representation.

No...an intermediate representation on the libsepol level,
as well as the libsemanage level. 

>  I don't think 
> anyone is suggesting we expose anything about the policy, the last few 
> days of discussion has been about abstracting this. With respect to the 
> proposed libsemanage API, please let us know what else you need, or 
> better yet add some structs and functions and send an rfc. 

Can you please rename the library, so I can send patches against it?
I tried to do this myself, but you didn't like my patch.

> /* Disconnect from the manager given by the handle.  If already
>  * disconnected then this function does nothing.  Return 0 if
>  * disconnected properly or already disconnected, negative value on
>  * error. */
> int semanage_disconnect(semanage_handle_t *);
> 
> /* Deallocate all space associated with a semanage_handle_t, including
>  * the pointer itself.  CAUTION: this function does not disconnect
>  * from the manager; be sure that a semanage_disconnect() was
>  * previously called. */
> void semanage_handle_free(semanage_handle_t *);

Dan asked why the API is assymetric (connect vs disconnect-free),
but no one has answered this question yet. In addition, I see a 
"CAUTION: don't do this" in free, which makes me wonder
why this function exists, and is not done inside disconnect.

> /* Return a string describing the most recently encountered error
>  * associated with a semanage_handle_t.  The returned string must not
>  * be modified by the caller.  Be aware that this string is not
>  * persistent; future calls to this library may alter the buffer
>  * contents. */
> const char *semanage_strerror(semanage_handle_t *);

Can you look at the sepol debugging system which I added,
and see if you have any objections to the same thing
being done in libsemanage.

> /* accessors for mls and role support structs */
> typedef struct semanage_mls semanage_role_t;
> typedef struct semanage_role semanage_role_t;

??

> const char* semanage_mls_get_range(semanage_mls *);
> const char* semanage_mls_get_level(semanage_mls *);
> 
> int semanage_mls_set_range(semanage_mls *);
> int semanage_mls_set_level(semanage_mls *);

Shouldn't the setters take a parameter of 
what to set? You omit those in many places.

> /* semanage_user management functions */
> int semanage_user_init(semanage_handle_t **);

You mean semanage_user_t** ?

> int semanage_user_add(semanage_handle_t *, semanage_user_t *userdata);
> int semanage_user_remove(semanage_handle_t *, semanage_user_t *userdata);
> int semanage_user_list(semanage_handle_t *, semanage_user_t **users, int *num_users);

There's still no query or a way to modify the user other than delete 
and re-add. This applies to the entire API. Delete and add may be
acceptable (even though that automatically means two iterations
in the file case), but no query just seems wrong. 

> /* semanage_homedir accessors */
> 
> const char* semanage_homedir_get_user(semanage_handle_t *);
> const char* semanage_homedir_get_path(semanage_handle_t *);
> 
> int semanage_homedir_set_user(semanage_handle_t *, char *user);
> int semanage_homedir_set_path(semanage_handle_t *, char *path); 

There is no api to trigger regeneration of the file_contexts file.

Also, I believe the mapping of paths to selinux users is 
fundamentally flawed, and needs to be more generic. I will
acknowledge that the code I've posted so far offers no solution 
either, and may actually be worse. 

I want to add a new expansion called... CONTENT_DIR, which maps
to a bunch of locations where I store music and movies on my home 
computer, and labels those to a certain type. 

I want to add a new expansion called... REMOVABLE_MNT_POINT, that
I want labeled removable_t via integration with udev, which follows
my custom naming policy.

How does this future-proof API handle those scenarios.

> struct semanage_handle {
> 	int con_id;		/* Connection ID */
> 	int policy_serial;	/* Policy serial number at connect time */
> 	char *err_buf;

We should not buffer errors - we should provide the user
with a better debugging system - do you oppose sepol_enable_debug* ?

> struct semanage_mls {
> 	char *level;
> 	char *range;
> }

Whether or not the mls data should be opaque I am not sure about.
It's certainly easier to deal with it that way...that's how
I'm implementing the sepol support... but it doesn't
offer much insight into the composition of level and range..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
