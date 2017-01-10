Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0ADgIKK020727
 for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2017 08:42:18 -0500
In-Reply-To: <20170110131444.GA31676@meriadoc.perfinion.com>
References: <1482966318.30976.5.camel@trentalancia.net>
 <1483037107.25804.5.camel@trentalancia.net>
 <1483987150.20858.81.camel@tycho.nsa.gov>
 <8104068E-AEC9-47EC-B74A-4DBAF46812B7@trentalancia.net>
 <1483987873.20858.87.camel@tycho.nsa.gov>
 <1b263857-6347-b706-a273-0dac251fe90e@redhat.com>
 <B32D70F8-36D8-4E9F-A60F-5FAA442A6123@trentalancia.net>
 <20170110131444.GA31676@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2] libsemanage: special handling of the identity reserved
 to system objects
From: Guido Trentalancia <guido@trentalancia.net>
Date: Tue, 10 Jan 2017 14:42:34 +0100
CC: selinux <selinux@tycho.nsa.gov>
Message-ID: <BC08AFE1-EF75-4F0D-84AB-9E69E4703B4C@trentalancia.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello Jason, 

yes, you are right it's an obsolete problem in the Reference Policy. 

I was working on an obsolete git tree... 

Regards, 

Guido 

On the 10th of January 2017 14:14:44 CET, Jason Zaman <jason@perfinion.com> wrote:
>On Tue, Jan 10, 2017 at 02:11:24PM +0100, Guido Trentalancia wrote:
>> Hello. 
>> 
>> I am not using the Fedora policy, but in Reference Policy, if I
>comment out the line containing "system_u" in the files
>config/appconfig-{standard,mcs,mls}/seusers then the problem
>disappears... 
>
>They were removed from refpolicy months ago:
>https://github.com/TresysTechnology/refpolicy/commit/79f31a04739dad7c7369616cd7c666a57c365511
>you should git pull or something.
>
>-- Jason
>
>> 
>> Regards, 
>> 
>> Guido 
>> 
>> Il 10 gennaio 2017 09:09:57 CET, Petr Lautrbach <plautrba@redhat.com>
>ha scritto:
>> >On 01/09/2017 07:51 PM, Stephen Smalley wrote:
>> >> On Mon, 2017-01-09 at 19:46 +0100, Guido Trentalancia wrote:
>> >>> Hello, 
>> >>>
>> >>> the patch has been motivated by the fact that libsemanage
>currently
>> >>> searches for the user "system_u" in the passwd file and reports
>> >"user
>> >>> system_u not in passwd file".
>> >> 
>> >> Don't shoot the messenger. That warning is because the Fedora
>policy
>> >> wrongly has system_u in its seusers/login mapping as a login name.
>
>> >We
>> >> should fix it there instead by removing that entry, which should
>not
>> >be
>> >> needed.
>> >
>> >This is supposed to be fixed in selinux-policy-3.13.1-219.fc25
>> >
>> >Currently there's no plan to backport it to Fedora 24 as
>genhomedircon
>> >in Fedora 24 still uses hardcoded system_u.
>> >
>> >
>> >>>
>> >>> Also, I have considered the notes in the file policy/users from
>> >>> Reference Policy.
>> >>>
>> >>> Finally, the prefix for system_u is wrongly set to "user_u" (it
>> >>> shouldn't have it).
>> >>>
>> >>> I have tested the patch and it seems to work fine.
>> >>>
>> >>> I hope it helps. 
>> >>>
>> >>> Kind regards, 
>> >>>
>> >>> Guido Trentalancia 
>> >>>
>> >>> On the 9th of January 2017 19:39:10 CET, Stephen Smalley
>> ><sds@tycho.n
>> >>> sa.gov> wrote:
>> >>>>
>> >>>> On Thu, 2016-12-29 at 19:45 +0100, Guido Trentalancia wrote:
>> >>>>>
>> >>>>> The following patch makes sure that the SELinux identity
>> >>>>> reserved for system processes and objects is skipped
>> >>>>> when adding users.
>> >>>>>
>> >>>>> A warning is produced when a Unix identity is found to be
>> >>>>> equal to the SELinux user identity for system processes
>> >>>>> and objects.
>> >>>>>
>> >>>>> This patch also avoids creating an extra record for a user
>> >>>>> if there is no prefix.
>> >>>>
>> >>>> What problem are you encountering that motivated this patch?
>> >>>> What is a test case for this problem?
>> >>>> What is the behavior before and after this patch?
>> >>>>
>> >>>>>
>> >>>>>
>> >>>>> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
>> >>>>> ---
>> >>>>>  include/semanage/user_record.h |    2 ++
>> >>>>>  src/genhomedircon.c            |   23 +++++++++++++++++++----
>> >>>>>  src/user_extra_record.c        |   39
>> >>>>> ++++++++++++++++++++++++++++++++-------
>> >>>>>  src/user_record.c              |   40
>+++++++++++++++++++++++++-
>> >>>>> ----
>> >>>>> ----------
>> >>>>>  4 files changed, 78 insertions(+), 26 deletions(-)
>> >>>>>
>> >>>>> diff -pru a/include/semanage/user_record.h
>> >>>>> b/include/semanage/user_record.h
>> >>>>> --- a/include/semanage/user_record.h	2016-10-14
>> >>>>> 17:31:26.000000000 +0200
>> >>>>> +++ b/include/semanage/user_record.h	2016-12-28
>> >>>>> 23:22:50.848589870 +0100
>> >>>>> @@ -6,6 +6,8 @@
>> >>>>>  #include <stddef.h>
>> >>>>>  #include <semanage/handle.h>
>> >>>>>  
>> >>>>> +#define SYS_OBJECTS_USERID	"system_u"
>> >>>>> +
>> >>>>>  struct semanage_user;
>> >>>>>  typedef struct semanage_user semanage_user_t;
>> >>>>>  
>> >>>>> diff -pru a/src/genhomedircon.c b/src/genhomedircon.c
>> >>>>> --- a/src/genhomedircon.c	2016-10-14 17:31:26.000000000
>> >>>>> +0200
>> >>>>> +++ b/src/genhomedircon.c	2016-12-29 17:50:10.781727455
>> >>>>> +0100
>> >>>>> @@ -181,6 +181,9 @@ static int ignore(const char *homedir) {
>> >>>>>  static int prefix_is_homedir_role(const semanage_user_t *user,
>> >>>>>  				  const char *prefix)
>> >>>>>  {
>> >>>>> +	if (!prefix)
>> >>>>> +		return 0;
>> >>>>> +
>> >>>>>  	return strcmp(OBJECT_R, prefix) == 0 ||
>> >>>>>  		semanage_user_has_role(user, prefix);
>> >>>>>  }
>> >>>>> @@ -998,14 +1001,26 @@ static int add_user(genhomedircon_settin
>> >>>>>  		homedir_role = prefix;
>> >>>>>  	}
>> >>>>>  
>> >>>>> +	/* There should be no Unix identity corresponding
>> >>>>> +	 * to SELinux user reserved for system processes
>> >>>>> +	 * and objects */
>> >>>>>  	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen,
>> >>>>> &pwent);
>> >>>>> -	if (retval != 0 || pwent == NULL) {
>> >>>>> -		if (retval != 0 && retval != ENOENT) {
>> >>>>> +	if (strcmp(name, SYS_OBJECTS_USERID)) {
>> >>>>> +		if (retval != 0 || pwent == NULL) {
>> >>>>> +			if (retval != 0 && retval != ENOENT) {
>> >>>>> +				goto cleanup;
>> >>>>> +			}
>> >>>>> +
>> >>>>> +			WARN(s->h_semanage,
>> >>>>> +			     "user %s not in password file",
>> >>>>> name);
>> >>>>> +			retval = STATUS_SUCCESS;
>> >>>>>  			goto cleanup;
>> >>>>>  		}
>> >>>>> +	} else {
>> >>>>> +		if (retval)
>> >>>>> +			WARN(s->h_semanage,
>> >>>>> +			     "There should be no Unix identity
>> >>>>> \"%s\" !", SYS_OBJECTS_USERID);
>> >>>>>  
>> >>>>> -		WARN(s->h_semanage,
>> >>>>> -		     "user %s not in password file", name);
>> >>>>>  		retval = STATUS_SUCCESS;
>> >>>>>  		goto cleanup;
>> >>>>>  	}
>> >>>>> diff -pru a/src/user_extra_record.c b/src/user_extra_record.c
>> >>>>> --- a/src/user_extra_record.c	2016-10-14
>> >>>>> 17:31:26.000000000
>> >>>>> +0200
>> >>>>> +++ b/src/user_extra_record.c	2016-12-29
>> >>>>> 17:17:26.168737139
>> >>>>> +0100
>> >>>>> @@ -37,8 +37,9 @@ static int semanage_user_extra_key_extra
>> >>>>>  					   semanage_user_key_t
>> >>>>> **
>> >>>>> key_ptr)
>> >>>>>  {
>> >>>>>  
>> >>>>> -	if (semanage_user_key_create(handle, user_extra->name,
>> >>>>> key_ptr) < 0)
>> >>>>> -		goto err;
>> >>>>> +	if (user_extra)
>> >>>>> +		if (semanage_user_key_create(handle, user_extra-
>> >>>>>>
>> >>>>>> name, key_ptr) < 0)
>> >>>>> +			goto err;
>> >>>>>  
>> >>>>>  	return STATUS_SUCCESS;
>> >>>>>  
>> >>>>> @@ -54,7 +55,10 @@ static int semanage_user_extra_compare(c
>> >>>>>  	const char *name;
>> >>>>>  	semanage_user_key_unpack(key, &name);
>> >>>>>  
>> >>>>> -	return strcmp(user_extra->name, name);
>> >>>>> +	if (user_extra)
>> >>>>> +		return strcmp(user_extra->name, name);
>> >>>>> +	else
>> >>>>> +		return 1;
>> >>>>>  }
>> >>>>>  
>> >>>>>  static int semanage_user_extra_compare2(const
>> >>>>> semanage_user_extra_t
>> >>>>> *
>> >>>>> @@ -63,7 +67,10 @@ static int semanage_user_extra_compare2(
>> >>>>>  					user_extra2)
>> >>>>>  {
>> >>>>>  
>> >>>>> -	return strcmp(user_extra->name, user_extra2->name);
>> >>>>> +	if (user_extra && user_extra2)
>> >>>>> +		return strcmp(user_extra->name, user_extra2-
>> >>>>>> name);
>> >>>>> +	else
>> >>>>> +		return 1;
>> >>>>>  }
>> >>>>>  
>> >>>>>  static int semanage_user_extra_compare2_qsort(const
>> >>>>> semanage_user_extra_t **
>> >>>>> @@ -72,7 +79,10 @@ static int semanage_user_extra_compare2_
>> >>>>>  					      user_extra2)
>> >>>>>  {
>> >>>>>  
>> >>>>> -	return strcmp((*user_extra)->name, (*user_extra2)-
>> >>>>>> name);
>> >>>>> +	if (*user_extra && *user_extra2)
>> >>>>> +		return strcmp((*user_extra)->name,
>> >>>>> (*user_extra2)-
>> >>>>>>
>> >>>>>> name);
>> >>>>> +	else
>> >>>>> +		return 1;
>> >>>>>  }
>> >>>>>  
>> >>>>>  /* Name */
>> >>>>> @@ -80,7 +90,10 @@ hidden const char *semanage_user_extra_g
>> >>>>>  						user_extra)
>> >>>>>  {
>> >>>>>  
>> >>>>> -	return user_extra->name;
>> >>>>> +	if (user_extra)
>> >>>>> +		return user_extra->name;
>> >>>>> +	else
>> >>>>> +		return NULL;
>> >>>>>  }
>> >>>>>  
>> >>>>>  hidden int semanage_user_extra_set_name(semanage_handle_t *
>> >>>>> handle,
>> >>>>> @@ -88,6 +101,9 @@ hidden int semanage_user_extra_set_name(
>> >>>>>  					const char *name)
>> >>>>>  {
>> >>>>>  
>> >>>>> +	if (!user_extra)
>> >>>>> +		return STATUS_SUCCESS;
>> >>>>> +
>> >>>>>  	char *tmp_name = strdup(name);
>> >>>>>  	if (!tmp_name) {
>> >>>>>  		ERR(handle, "out of memory, could not set name
>> >>>>> %s "
>> >>>>> @@ -104,7 +120,10 @@ hidden const char *semanage_user_extra_g
>> >>>>>  						  user_extra)
>> >>>>>  {
>> >>>>>  
>> >>>>> -	return user_extra->prefix;
>> >>>>> +	if (user_extra)
>> >>>>> +		return user_extra->prefix;
>> >>>>> +	else
>> >>>>> +		return NULL;
>> >>>>>  }
>> >>>>>  
>> >>>>>  hidden int semanage_user_extra_set_prefix(semanage_handle_t *
>> >>>>> handle,
>> >>>>> @@ -112,6 +131,9 @@ hidden int semanage_user_extra_set_prefi
>> >>>>>  					  const char *prefix)
>> >>>>>  {
>> >>>>>  
>> >>>>> +	if (!user_extra)
>> >>>>> +		return STATUS_SUCCESS;
>> >>>>> +
>> >>>>>  	char *tmp_prefix = strdup(prefix);
>> >>>>>  	if (!tmp_prefix) {
>> >>>>>  		ERR(handle, "out of memory, could not set prefix
>> >>>>> %s
>> >>>>> "
>> >>>>> @@ -162,6 +184,9 @@ hidden int semanage_user_extra_clone(sem
>> >>>>>  				     semanage_user_extra_t **
>> >>>>> user_extra_ptr)
>> >>>>>  {
>> >>>>>  
>> >>>>> +	if (!user_extra)
>> >>>>> +		return STATUS_SUCCESS;
>> >>>>> +
>> >>>>>  	semanage_user_extra_t *new_user_extra = NULL;
>> >>>>>  
>> >>>>>  	if (semanage_user_extra_create(handle, &new_user_extra)
>> >>>>> < 0)
>> >>>>> diff -pru a/src/user_record.c b/src/user_record.c
>> >>>>> --- a/src/user_record.c	2016-10-14 17:31:26.000000000
>> >>>>> +0200
>> >>>>> +++ b/src/user_record.c	2016-12-29 19:23:11.783720792
>> >>>>> +0100
>> >>>>> @@ -313,6 +313,7 @@ hidden int semanage_user_join(semanage_h
>> >>>>>  {
>> >>>>>  
>> >>>>>  	const char *name;
>> >>>>> +	const char *prefix = NULL;
>> >>>>>  	semanage_user_t *tmp_user = calloc(1,
>> >>>>> sizeof(semanage_user_t));
>> >>>>>  	if (!tmp_user)
>> >>>>>  		goto omem;
>> >>>>> @@ -324,6 +325,9 @@ hidden int semanage_user_join(semanage_h
>> >>>>>  	else
>> >>>>>  		name = semanage_user_base_get_name(record1);
>> >>>>>  
>> >>>>> +	if (record2)
>> >>>>> +		prefix =
>> >>>>> semanage_user_extra_get_prefix(record2);
>> >>>>> +
>> >>>>>  	/* Join base record if it exists, create a blank one
>> >>>>> otherwise */
>> >>>>>  	if (record1) {
>> >>>>>  		if (semanage_user_base_clone(handle, record1,
>> >>>>> &tmp_user->base) <
>> >>>>> @@ -337,21 +341,27 @@ hidden int semanage_user_join(semanage_h
>> >>>>>  			goto err;
>> >>>>>  	}
>> >>>>>  
>> >>>>> -	/* Join extra record if it exists, create a blank one
>> >>>>> otherwise */
>> >>>>> -	if (record2) {
>> >>>>> -		if (semanage_user_extra_clone(handle, record2,
>> >>>>> &tmp_user->extra)
>> >>>>> -		    < 0)
>> >>>>> -			goto err;
>> >>>>> -	} else {
>> >>>>> -		if (semanage_user_extra_create(handle,
>> >>>>> &tmp_user-
>> >>>>>>
>> >>>>>> extra) < 0)
>> >>>>> -			goto err;
>> >>>>> -		if (semanage_user_extra_set_name(handle,
>> >>>>> tmp_user-
>> >>>>>>
>> >>>>>> extra, name)
>> >>>>> -		    < 0)
>> >>>>> -			goto err;
>> >>>>> -		if (semanage_user_extra_set_prefix
>> >>>>> -		    (handle, tmp_user->extra, "user") < 0)
>> >>>>> -			goto err;
>> >>>>> -	}
>> >>>>> +	/* SELinux identities without a prefix shall not have an
>> >>>>> extra record */
>> >>>>> +	if (prefix) { 
>> >>>>> +		/* Join extra record if it exists, create a
>> >>>>> blank
>> >>>>> one otherwise */
>> >>>>> +		if (record2) {
>> >>>>> +			if (&tmp_user->extra)
>> >>>>> +				if
>> >>>>> (semanage_user_extra_clone(handle, record2, &tmp_user->extra)
>> >>>>> +				    < 0)
>> >>>>> +					goto err;
>> >>>>> +		} else {
>> >>>>> +			if (semanage_user_extra_create(handle,
>> >>>>> &tmp_user->extra) < 0)
>> >>>>> +				goto err;
>> >>>>> +			if (semanage_user_extra_set_name(handle,
>> >>>>> tmp_user->extra, name)
>> >>>>> +			    < 0)
>> >>>>> +				goto err;
>> >>>>> +
>> >>>>> +			if (semanage_user_extra_set_prefix
>> >>>>> +			    (handle, tmp_user->extra, "user") <
>> >>>>> 0)
>> >>>>> +				goto err;
>> >>>>> +		}
>> >>>>> +	} else
>> >>>>> +		tmp_user->extra = NULL;
>> >>>>>  
>> >>>>>  	if (semanage_user_set_name(handle, tmp_user, name) < 0)
>> >>>>>  		goto err;
>> >>>>> _______________________________________________
>> >>>>> Selinux mailing list
>> >>>>> Selinux@tycho.nsa.gov
>> >>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> >>>>> To get help, send an email containing "help" to
>Selinux-request@t
>> >>>>> ycho
>> >>>>> .nsa.gov.
>> >> _______________________________________________
>> >> Selinux mailing list
>> >> Selinux@tycho.nsa.gov
>> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> >> To get help, send an email containing "help" to
>> >Selinux-request@tycho.nsa.gov.
>> >> 
>> 
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.
