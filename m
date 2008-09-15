Message-ID: <48CE5AC9.6000408@redhat.com>
Date: Mon, 15 Sep 2008 08:53:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Ivan Gyurdiev <ivg231@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com> <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil> <48B41D0E.6060509@redhat.com> <48B4B348.2080801@gmail.com> <48C7D9F0.4000405@redhat.com> <48CABAA8.5020302@tresys.com>
In-Reply-To: <48CABAA8.5020302@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> Ivan Gyurdiev wrote:
>>>>>> I'm a little unclear on what this is doing - can you clarify?
>>>>>>     
>>>>> This is clearing the existing seusers.final file, otherwise delete was
>>>>> not working.
>>>>>   
>>>> I think the previous code was doing more - it was merging the local file
>>>> with the shipped base package file, like this:
>>>>
>>>>    data = extract_file_from_policy_package( )
>>>>    write_file ( "seusers.final", data )
>>>>    if ( data != null ) {
>>>>        seusers.clear_cache()  // thereby forcing reload from
>>>> seusers.final when cache() is called again (in merge_components)
>>>>    } else {
>>>>        seusers.clear()
>>>>    }
>>>>
>>>> It's also doing this three times (once for fcontexts, once for seusers,
>>>> once for seusers_extra).
>>>> The problem is that you're skipping the link_sandbox call, which builds
>>>> the base package, containing this information.
>>>>
>>>> Ivan
>>>>
>>>>
> Ok I found some problems with the previous patch and did some code
> reuse.  I added a function that only read base.pp in order to handle the
>  base user_extra and seusers problem.
> 
> 
>>

> The patch looks good but the test looks like it was written to be standalone and make test under libsemanage won't compile anymore (duplicate definition of main()). Please use the CUnit test infrastructure we have in place.

How about we create a new directory called examples and throw it there.

I wrote this up as an example to be used by libvirt guys to assign a
context on the fly.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
