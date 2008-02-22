Message-ID: <47BF0CD6.6000802@manicmethod.com>
Date: Fri, 22 Feb 2008 12:56:38 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: segfault in semodule
References: <1203696668.2914.25.camel@localhost.localdomain>	 <47BEFE89.4080201@manicmethod.com> <1203702113.2804.71.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1203702113.2804.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-02-22 at 11:55 -0500, Joshua Brindle wrote:
>   
>> Eric Paris wrote:
>>     
>>> I added "allow-unknown = deny" in semanage.conf and ran semodule -R
>>>
>>> [root@dhcp231-146 ~]# semodule -R
>>> error parsing semanage configuration file: syntax error
>>> semodule:  Could not create semanage handle
>>> semodule: handle.c:123: semanage_is_connected: Assertion `sh != ((void *)0)' failed.
>>> Segmentation fault
>>>
>>> It was supposed to bail (allow-unknown is not a valid entry, it should
>>> be handle-unknown) but it wasn't supposed to segfault.  Maybe someone
>>> who knows this code can find/fix it really quickly, if not I'm sure I'll
>>> get to look at it when it gets to the top of my list in 10 or 12
>>> months  :)
>>>
>>> policycoreutils-2.0.43-2.fc9.x86_64
>>>   
>>>       
>> This is totally untested but should fix it:
>>     
>
> I suppose the other option would be to make semanage_is_connected()
> return 0 if sh == NULL rather than assert'ing that sh is non-NULL.
> Then the same error path could be used.  
>
>   

I suppose, I think the basic philosophy in this library was that passing 
a null handle to any function that requires a handle is a bug and should 
be fixed. I'd hate to fix it in semanage_is_connected() and leave the 
asserts every where else.

>> Index: trunk/policycoreutils/semodule/semodule.c
>> ===================================================================
>> --- trunk/policycoreutils/semodule/semodule.c   (revision 2808)
>> +++ trunk/policycoreutils/semodule/semodule.c   (working copy)
>> @@ -285,7 +285,7 @@
>>         if (!sh) {
>>                 fprintf(stderr, "%s:  Could not create semanage handle\n",
>>                         argv[0]);
>> -               goto cleanup;
>> +               goto cleanup_nohandle;
>>         }
>>  
>>         if (store) {
>> @@ -473,6 +473,8 @@
>>                 }
>>         }
>>         semanage_handle_destroy(sh);
>> +
>> +      cleanup_nohandle:
>>         cleanup();
>>         exit(status);
>>  }
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>     



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
