Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MJP0gA008998
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:25:00 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MJKBYP021203
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 19:20:11 GMT
Message-ID: <42E146D3.60809@tresys.com>
Date: Fri, 22 Jul 2005 15:19:47 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>	<1122039886.24847.6.camel@celtics.boston.redhat.com>	<42E10804.5030401@tresys.com> <1122046798.25951.27.camel@celtics.boston.redhat.com>
In-Reply-To: <1122046798.25951.27.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>>That's why I'm asking for an intermediate representation. My particular
>>>implementation of it may not be very good (suggestions welcome), 
>>>but it's certainly better than what's out there - I don't think 
>>>passing in policy-dependent integer id's, and exposing internal data
>>>structures will make a successful api.
>>> 
>>>
>>>      
>>>
>>The module format is an intermediate representation.
>>    
>>
>
>No...an intermediate representation on the libsepol level,
>as well as the libsemanage level. 
>
>  
>
we need to figure out what we need to store before we decide if we need 
another policy representation.

>> I don't think 
>>anyone is suggesting we expose anything about the policy, the last few 
>>days of discussion has been about abstracting this. With respect to the 
>>proposed libsemanage API, please let us know what else you need, or 
>>better yet add some structs and functions and send an rfc. 
>>    
>>
>
>Can you please rename the library, so I can send patches against it?
>I tried to do this myself, but you didn't like my patch.
>
>  
>
It won't matter since the library doesn't currently match the proposed 
API. Probably the best thing would be to write your user and port 
management stuff against the new API and see if it actually works.

>>/* Disconnect from the manager given by the handle.  If already
>> * disconnected then this function does nothing.  Return 0 if
>> * disconnected properly or already disconnected, negative value on
>> * error. */
>>int semanage_disconnect(semanage_handle_t *);
>>
>>/* Deallocate all space associated with a semanage_handle_t, including
>> * the pointer itself.  CAUTION: this function does not disconnect
>> * from the manager; be sure that a semanage_disconnect() was
>> * previously called. */
>>void semanage_handle_free(semanage_handle_t *);
>>    
>>
>
>Dan asked why the API is assymetric (connect vs disconnect-free),
>but no one has answered this question yet. In addition, I see a 
>"CAUTION: don't do this" in free, which makes me wonder
>why this function exists, and is not done inside disconnect.
>
>  
>
it doesn't say not to do it, it says not to do it before disconnect. The 
reason there is a difference is because you may want to reuse the 
handles and we force the caller to initialize them therefore they have 
to destroy them.

<snip>

>>/* accessors for mls and role support structs */
>>typedef struct semanage_mls semanage_role_t;
>>typedef struct semanage_role semanage_role_t;
>>    
>>
>
>??
>
>  
>
??? those aren't directly used, they are for supporting users

>>const char* semanage_mls_get_range(semanage_mls *);
>>const char* semanage_mls_get_level(semanage_mls *);
>>
>>int semanage_mls_set_range(semanage_mls *);
>>int semanage_mls_set_level(semanage_mls *);
>>    
>>
>
>Shouldn't the setters take a parameter of 
>what to set? You omit those in many places.
>
>  
>
yea, my mistake, obviously I was writing this to get the concepts out 
and let you see if they actually work for you, hopefully they will :)

>>/* semanage_user management functions */
>>int semanage_user_init(semanage_handle_t **);
>>    
>>
>
>You mean semanage_user_t** ?
>
>  
>
probably :)

>>int semanage_user_add(semanage_handle_t *, semanage_user_t *userdata);
>>int semanage_user_remove(semanage_handle_t *, semanage_user_t *userdata);
>>int semanage_user_list(semanage_handle_t *, semanage_user_t **users, int *num_users);
>>    
>>
>
>There's still no query or a way to modify the user other than delete 
>and re-add. This applies to the entire API. Delete and add may be
>acceptable (even though that automatically means two iterations
>in the file case), but no query just seems wrong. 
>
>  
>
oops, add
semanage_user_change(semanage_handle_t *, semanage_user_t *userdata, 
char* key);
it would totally replace the datum, no unioning or anything like that

<snip>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
