Subject: Re: [PATCH] genhomedircon: add support for %group syntax
To: Gary Tierney <gary.tierney@gmx.com>
References: <1469654706-26930-1-git-send-email-gary.tierney@gmx.com>
 <2a66b4e4-6064-1248-bdfc-8b41b822c749@tycho.nsa.gov>
 <20160816155910.GA12097@workstation.home>
Cc: selinux@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6bd10751-18f5-0e05-8119-79a80511cd0d@tycho.nsa.gov>
Date: Tue, 16 Aug 2016 13:13:02 -0400
MIME-Version: 1.0
In-Reply-To: <20160816155910.GA12097@workstation.home>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/16/2016 11:59 AM, Gary Tierney wrote:
> Hi Stephen,
> 
> Replied inline below.
> 
> On Mon, Aug 15, 2016 at 03:58:44PM -0400, Stephen Smalley wrote:
>> On 07/27/2016 05:25 PM, Gary Tierney wrote:
>>> semanage-login supports login mappings using the %group syntax,
>>> but genhomedircon does not expand groups to the users belonging
>>> to them.
>>> 
>>> This commit adds support for generating home directory contexts
>>> for login mappings using the group syntax and adds error
>>> reporting for handling cases where there is ambiguity due to a
>>> user belonging to multiple groups mapped by semanage-login. If
>>> a login mapping is added for the user which belongs to multiple
>>> groups it will take precedence and resolve the ambiguity
>>> issue.
>> 
>> Sorry for the long delay in responding.  One question/comment
>> below.
>> 
>>> Signed-off-by: Gary Tierney <gary.tierney@gmx.com> --- 
>>> libsemanage/src/genhomedircon.c | 319
>>> +++++++++++++++++++++++++++++++--------- 1 file changed, 247
>>> insertions(+), 72 deletions(-)
>>> 
>>> diff --git a/libsemanage/src/genhomedircon.c
>>> b/libsemanage/src/genhomedircon.c index c5ea436..2955b19
>>> 100644 --- a/libsemanage/src/genhomedircon.c +++
>>> b/libsemanage/src/genhomedircon.c @@ -838,94 +1064,43 @@ static
>>> genhomedircon_user_entry_t *get_users(genhomedircon_settings_t
>>> * s, nusers = 0; }
>>> 
>>> +	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *), +
>>> &seuser_sort_func); qsort(user_list, nusers,
>>> sizeof(semanage_user_t *), (int (*)(const void *, const void
>>> *))&user_sort_func);
>>> 
>>> -	/* Allocate space for the getpwnam_r buffer */ -	rbuflen =
>>> sysconf(_SC_GETPW_R_SIZE_MAX); -	if (rbuflen <= 0) -		goto
>>> cleanup; -	rbuf = malloc(rbuflen); -	if (rbuf == NULL) -		goto
>>> cleanup; - for (i = 0; i < nseusers; i++) { seuname =
>>> semanage_seuser_get_sename(seuser_list[i]); name =
>>> semanage_seuser_get_name(seuser_list[i]);
>>> 
>>> -		if (strcmp(name,"root") && strcmp(seuname,
>>> s->fallback->sename) == 0) -			continue; -
>> 
>> This appears to change the behavior of genhomedircon in general,
>> not just with respect to %group handling.  Was this intentional? 
>> I'm not necessarily opposed to this change, but I am unclear on
>> the implications.  It seems that previously genhomedircon would
>> not generate file_contexts.homedirs entries for users who were
>> mapped to the fallback seuser, with an exception for root for
>> /root labeling.  With this change, they will have entries added.
>> 
> 
> Hmm, yes, you're right. This is a mistake. We do need to skip this 
> conditional however, so we can check if a user already has a
> mapping when we're expanding the members of a group.
> 
> To prevent this from happening it should suffice to check if the
> user that we're writing contexts for shares an sename with the
> __default__ mapping, and if so, simply skip writing contexts for
> that user.  We can do this check inside
> write_gen_home_dir_contexts() like so:
> 
> https://github.com/garyttierney/selinux/commit/ebdb7f225ddbd5f311b2db75f68e2896285a5090#diff-b298746a257be78548f69d5d296dcd09R1140
>
>  An alternative fix would be to prevent these users from being
> added to the `genhomedircon_user_entry_t` stack in the first place,
> and have get_group_users() search the seusers list for a login
> mapping which matches the group members username, skipping the
> group member if a match is found.
> 
> Any thoughts on either of these solutions?

I'm actually inclined to just take your patch as is, removing this
test altogether, but I wanted to check whether this might have
undesirable side effects.  I am unclear on the correctness of the
current code before your patch, e.g. what if the Linux user/login name
is mapped to the same seuser as the fallback but has a more specific
level within the authorized range for that seuser?  The fact that we
already have an exception for root suggests that something is wrong
with this test.  At worst, removing the test may lead to some
unnecessary (but harmless) entries in file_contexts.homedirs, but only
if there is an entry in seusers for that Linux user/login in the first
place, and they can obviously address that by deleting the user's
entry if they do not truly need to map them to a different seuser
and/or level.
