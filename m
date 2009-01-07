From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        selinux-devel@lists.alioth.debian.org
Subject: Re: [libsemanage] Also check for the uppoer bound on user ids in /etc/login.defs
References: <1231195520-10286-1-git-send-email-manoj.srivastava@stdc.com>
	<49629037.7020604@redhat.com>
	<87k599fidc.fsf@anzu.internal.golden-gryphon.com>
	<496353FA.5020906@redhat.com>
	<87fxjwlc7f.fsf@anzu.internal.golden-gryphon.com>
	<1231254550.9746.53.camel@localhost.localdomain>
	<4963873A.2040701@redhat.com>
Date: Tue, 06 Jan 2009 18:41:11 -0600
In-Reply-To: <4963873A.2040701@redhat.com> (Daniel J. Walsh's message of "Tue,
	06 Jan 2009 11:30:50 -0500")
Message-ID: <87wsd8j6c8.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 06 2009, Daniel J Walsh wrote:

> Stephen Smalley wrote:
>> On Tue, 2009-01-06 at 08:51 -0600, Manoj Srivastava wrote:
>>> On Tue, Jan 06 2009, Daniel J Walsh wrote:
>>>
>>>> Manoj Srivastava wrote:
>>>>> On Mon, Jan 05 2009, Daniel J Walsh wrote:
>>>>>
>>>>>> Manoj Srivastava wrote:
>>>>>>> From: Manoj Srivastava <srivasta@debian.org>
>>>>>>>
>>>>>>> Some non-Debian packages (like qmail, shudder) create users not below
>>>>>>> MIN_UID, but above MAX_UID, in /etc/login.defs (non-system users are
>>>>>>> supposed to have uids between MIN_UID and MAX_UID.
>>>>>>>
>>>>>>> genhomedircon.c:gethomedirs() checks pwent.pw_uid against MIN_UID in
>>>>>>> /etc/login.defs to exclude system users from generating homedir
>>>>>>> contexts. But unfortunately it does not check it against MAX_UID
>>>>>>> setting from the same file.
>>>>>>>
>>>>>>> This gets us lines like the following in the
>>>>>>> contexts/files/file_contexts.homedirs file:
>>>>>>>
>>>>>>> ,----
>>>>>>> |  #
>>>>>>> |  # Home Context for user user_u
>>>>>>> |  #
>>>>>>> |  /var/qmail/[^/]*/.+     user_u:object_r:user_home_t:s0
>>>>>>> |  /var/qmail/[^/]*/\.ssh(/.*)?    user_u:object_r:user_home_ssh_t:s0
>>>>>>> |  /var/qmail/[^/]*/\.gnupg(/.+)?  user_u:object_r:user_gpg_secret_t:s0
>>>>>>> |  /var/qmail/[^/]*        -d      user_u:object_r:user_home_dir_t:s0
>>>>>>> |  /var/qmail/lost\+found/.*       <<none>>
>>>>>>> |  /var/qmail      -d      system_u:object_r:home_root_t:s0
>>>>>>> |  /var/qmail/\.journal    <<none>>
>>>>>>> |  /var/qmail/lost\+found  -d      system_u:object_r:lost_found_t:s0
>>>>>>> |  /tmp/gconfd-.*  -d      user_u:object_r:user_tmp_t:s0
>>>>>>> `----
>>>>>>>
>>>>>>> This commit adds checking uid value againt MAX_UID too.
>>>>>>>
>>>>>>> Signed-off-by: Manoj Srivastava <srivasta@debian.org>
>>>>>>> ---
>>>>>>>  src/genhomedircon.c |   22 ++++++++++++++++++----
>>>>>>>  1 files changed, 18 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/src/genhomedircon.c b/src/genhomedircon.c
>>>>>>> index ce15807..a5306d7 100644
>>>>>>> --- a/src/genhomedircon.c
>>>>>>> +++ b/src/genhomedircon.c
>>>>>>> @@ -219,8 +219,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>>>>>>>  	char *rbuf = NULL;
>>>>>>>  	char *path = NULL;
>>>>>>>  	long rbuflen;
>>>>>>> -	uid_t temp, minuid = 0;
>>>>>>> -	int minuid_set = 0;
>>>>>>> +	uid_t temp, minuid = 0, maxuid = 0;
>>>>>>> +	int minuid_set = 0, maxuid_set = 0;
>>>>>>>  	struct passwd pwstorage, *pwbuf;
>>>>>>>  	struct stat buf;
>>>>>>>  	int retval;
>>>>>>> @@ -270,6 +270,16 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>>>>>>>  	}
>>>>>>>  	free(path);
>>>>>>>  	path = NULL;
>>>>>>> +	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
>>>>>>> +	if (path && *path) {
>>>>>>> +		temp = atoi(path);
>>>>>>> +		if (!maxuid_set || temp > maxuid) {
>>>>>>> +			maxuid = temp;
>>>>>>> +			maxuid_set = 1;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +	free(path);
>>>>>>> +	path = NULL;
>>>>>>>  
>>>>>>>  	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
>>>>>>>  	if (path && *path) {
>>>>>>> @@ -286,6 +296,10 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>>>>>>>  		minuid = 500;
>>>>>>>  		minuid_set = 1;
>>>>>>>  	}
>>>>>>> +	if (!maxuid_set) {
>>>>>>> +		maxuid = 60000;
>>>>>>> +		maxuid_set = 1;
>>>>>>> +	}
>>>>>>>  
>>>>>>>  	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>>>>>  	if (rbuflen <= 0)
>>>>>>> @@ -295,7 +309,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>>>>>>>  		goto fail;
>>>>>>>  	setpwent();
>>>>>>>  	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
>>>>>>> -		if (pwbuf->pw_uid < minuid)
>>>>>>> +		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
>>>>>>>  			continue;
>>>>>>>  		if (!semanage_list_find(shells, pwbuf->pw_shell))
>>>>>>>  			continue;
>>>>>>> @@ -322,7 +336,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>>>>>>>  
>>>>>>>  			/* NOTE: old genhomedircon printed a warning on match */
>>>>>>>  			if (hand.matched) {
>>>>>>> -				WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid);
>>>>>>> +			  WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or greater than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid, maxuid);
>>>>>>>  			} else {
>>>>>>>  				if (semanage_list_push(&homedir_list, path))
>>>>>>>  					goto fail;
>>>>>> I think the default MAX_UID is not big enough.
>>>>>>
>>>>>> Shouldn't it be MAXINT?
>>>>>         Not unless I am misunderstanding the logic here. The way I see
>>>>>  it, the code below:
>>>>> ,----
>>>>> | while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
>>>>> |         if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
>>>>> |                 continue;
>>>>> |         if (!semanage_list_find(shells, pwbuf->pw_shell))
>>>>> |                 continue;
>>>>> |         if (strcmp(pwbuf->pw_dir, "/") == 0)
>>>>> |                 continue;
>>>>> |         if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
>>>>> |                 continue;
>>>>> |         if (!(path = strdup(pwbuf->pw_dir))) {
>>>>> |                 break;
>>>>> |         }
>>>>> |    /* DO STUFF HERE */
>>>>> | }
>>>>> `----
>>>>>
>>>>>         Does nothing iff: pw_uid < minuid || pw_uid > maxuid, so it
>>>>>  only does things if the UID is in the range legal for non-system users;
>>>>>  and the UID range for system users is UID_MIN < uid < UID_MAX.
>>>>>
>>>>>         If you change the upper bound to max int, then we will create
>>>>>  the entries for UIDs in the range above 60000 -- which is where the
>>>>>  bletcherous qmail install script places the qmail uid.
>>>>>
>>>>>         The current behaviour, but not checking the upper bound of the
>>>>>  acceptable user range would be equivalent to the raising the upper
>>>>>  bound to INT_MAX; and indeed, would make this patch redundant.
>>>>>
>>>>>         From login.defs(5):
>>>>> ,----
>>>>> |        UID_MAX (number), UID_MIN (number)
>>>>> |            Range of user IDs used for the creation of regular users by
>>>>> |            useradd or newusers.
>>>>> `----
>>>>>
>>>>>         Therefore I think that the right thing to do would be to check
>>>>>  for both the upper and the lower bound, not just the lower bound
>>>>>  check, which is all we do now.
>>>>>
>>>>>         manoj
>>>> my point being, if I have a legitimate UID > 60000 for a real user and
>>>> do not define UID_MAX, My account will not work.
>>>>
>>>> I do not have a problem with checking UID_MAX, just that the default
>>>> should be much higer then 60000.
>>>         I just went with the Debian policy default value; 60000 is the
>>>  upper limit of uid's on Debian (and probably most Debian derivative)
>>>  machines, and UID's lager than that are reserved by policy for Debian
>>>  packages to use (after discussion on the development mailing lists).
>> 
>> The same appears to be true in Fedora; UID_MAX is set to 60000 by
>> default in /etc/login.defs there as well.
>> 
>>>         Having said that, I have no objection to making the default max
>>>  uid a preprocessor constant, which can be tweaked by the
>>>  distributions. Should I send in an updated patch?
>> 
> Talking to Nalin, he thinks this number should be ignored,  Imagine a
> university with > 60000 students or a large government Department (Say
> DOD),  this will cause users with UID 600001 to not work correctly.
>
> UID_MAX is just there to tell useradd to give up when trying to find the
> next available UID to add, it means nothing when you have a network of
> Users.

        Is this not why we have /etc/login.defs in the first place?
 These installations should change UID_MAX to whatever makes
 sense for their site. Otherwise, we have a mismatch between stated
 policies (/etc/logindefs.conf) and practice, and I would much rather
 have our code follow the stated policy than not.

        I think I no not see the value with ignoring the upper bound to
 user IDs, it serves as a sanity check, for example, on some machines
 against the bugs that happened due to qmail creating a user with no
 regards to policies.

        manoj
-- 
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
