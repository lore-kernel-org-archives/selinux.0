Message-ID: <43CE8AB3.1070103@cornell.edu>
Date: Wed, 18 Jan 2006 11:36:35 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu> <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-01-18 at 11:12 -0700, Ivan Gyurdiev wrote:
>   
>>>> python chcat -L -l dwalsh
>>>> libsemanage.semanage_create_store: Could not access module store at 
>>>> /etc/selinux/targeted/modules, or it is not a directory.
>>>> libsemanage.assert_init: A direct or server connection is needed to 
>>>> use this function - please call the corresponding connect() method
>>>> libsemanage.enter_ro: could not enter read-only section
>>>> Traceback (most recent call last):
>>>>  File "chcat", line 366, in ?
>>>>    sys.exit(listusercats(cmds))
>>>>  File "chcat", line 303, in listusercats
>>>>    seusers = seobject.loginRecords().get_all()
>>>>  File "/usr/lib/python2.4/site-packages/seobject.py", line 175, in 
>>>> get_all
>>>>    raise ValueError("Could not list login mappings")
>>>> ValueError: Could not list login mappings
>>>>
>>>>
>>>> This needs to be legal.  What is happening to cause this problem?  Or 
>>>> do I need to code around this by reading the seusers file?
>>>>         
>>> It's a permissions problem - you have to be root to create the store, 
>>> because you're writing to /etc/selinux/targeted/modules (or reading 
>>> from it, it doesn't really matter), and at least on my machine all 
>>> folders and files under that folder are owned by root, and not 
>>> writable/readable by anyone else. Of course, it should fail on 
>>> connect  and stop there, but you're still not checking rc values where 
>>> necessary.
>>>
>>> Btw, it seems that handle_create can also fail in a variety of ways, 
>>> while that is undocumented in the headers - should change the headers. 
>>> It returns NULL on failure.
>>>       
>> Apparently it needs rwx on /etc/targeted/modules, and it doesn't have 
>> write as non-root.
>> I think it will need to write lock files in there to do anything at all.
>>
>> int mode_mask = R_OK | W_OK | X_OK;
>>
>> Then it has no permissions under /active as non-root, and therefore 
>> won't be able to read any information out of there.
>>     
>
> If you want this to be useable by ordinary users (subject only to policy
> restrictions), then you likely want it to act on the installed seusers
> file instead of the libsemanage-managed one.
>   
Shouldn't the policy server improve this situation when it's merged?

(By the way, now that you've merged my patches, there's no more 
dependency on semanage_store.c in database.c, which means there's no 
further known obstacles to implementing a pserver backend to the 
database, if the server is merged, and line protocol is decided upon).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
