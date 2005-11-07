Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA7FJ0MA023638
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 10:19:01 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA7FCOKP002342
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 15:12:29 GMT
Message-ID: <436F6EEF.50907@redhat.com>
Date: Mon, 07 Nov 2005 10:12:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Stephen Smalley <sds@epoch.ncsc.mil>,
   selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>,
   Frank Mayer <mayerf@tresys.com>, chris pebenito <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
Subject: Re: [ LIBSEMANAGE ] Runtime control over preservebools argument
References: <436915FB.3040500@tresys.com> <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil> <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu> <1131110455.23420.187.camel@moss-spartans.epoch.ncsc.mil> <436B6E9E.4050108@cornell.edu> <1131113812.23420.236.camel@moss-spartans.epoch.ncsc.mil> <436C59DE.6050408@cornell.edu> <436F66C9.9020201@tresys.com>
In-Reply-To: <436F66C9.9020201@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
>> Stephen Smalley wrote:
>>
>>> On Fri, 2005-11-04 at 09:22 -0500, Ivan Gyurdiev wrote:
>>>  
>>>
>>>> So, how do I specify that this is not a transient change, and I 
>>>> want my booleans loaded into policy immediately?
>>>>     
>>>
>>>
>>> Ah, I see - setsebool -P wants to both update the saved settings and
>>> load the result rather than preserving current settings.  So it wants
>>> libsemanage to call load_policy with -b, unlike semodule.  Options are:
>>> - add a semanage interface to set a property on the handle to control
>>> whether booleans are preserved or not (by altering the args to
>>> load_policy for that handle), similar to the existing interface for
>>> controlling whether reloads are performed, or
>>>   
>>
>> Editing an argument string for programs in C is... probably one of 
>> the most uncool patches I've ever written.
>> I guess the end justifies the means...
>>
>> Should pass valgrind, and work when called repeatedly with values 0 
>> or 1. Maybe the reload=0 case is a bit wrong - argument string cannot 
>> contain "-b" anywhere.
>>
>> I also fixed the memory leak in setsebool - see other patch (which 
>> should be applied first).
>>
>> Now booleans update correctly (minus migration issues - see other mail).
>> Next: make them update in less than 10 seconds :)
>>
>>
> <snip>
>
>> +    if (do_reload) {
>> +        char* prev_args = conf->load_policy->args;
>> +        int len = (prev_args == NULL)? 0: strlen(prev_args);
>> +        char* ptr = (char*) realloc(prev_args, len + 4);
>> +
>> +        if (!ptr) {
>> +            ERR(sh, "out of memory, could not configure "
>> +                "boolean reload");
>> +            return STATUS_ERR;
>> +        }
>> +        strcpy(ptr + len, " -b");
>> +        conf->load_policy->args = ptr;
>> +
>> +    } else {
>> +        char* ptr = conf->load_policy->args;
>> +
>> +        while(*ptr++) {
>> +            if (!strcmp(ptr, "-b")) {
>> +                *ptr++ = ' ';   
>> +                *ptr++ = ' ';
>> +            }
>> +        }
>> +    }
>> +    return STATUS_SUCCESS;
>> +}
>> +
> I think you are doing this in the wrong place. Rather than mangling 
> the argument string every time this function is called you should just 
> add something to the handle that indicates whether or not to preserve 
> booleans, and do this at load time.
>
> However, I don't know if this is the right approach anyway. If someone 
> sets a boolean without -P , foo, and then sets another boolean with -P 
> you will revert foo when loading the new policy.
>
> IMHO while we will need to regenerate the policy we should not load it 
> and instead just set the runtime state. This will work for the common 
> case but there is something of a corner case where the above scenerio 
> happens and a module is also inserted in the same transaction, not 
> sure how to handle that one.
>
> Joshua

I agree setsebool should not be loading policy.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
