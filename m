Message-ID: <43C8AB11.3070405@cornell.edu>
Date: Sat, 14 Jan 2006 00:41:05 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [SEMANAGE(tool)] Fix many issues
References: <43C89A43.3020105@cornell.edu> <43C8A1FF.8090605@cornell.edu>
In-Reply-To: <43C8A1FF.8090605@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>> Further notes:
>> - Multiple roles don't seem to work - I get the usage() printout
>> - Modifying with -R doesn't work properly - it adds roles on top of 
>> the current ones, when it should clear the current role set first - 
>> you can use the del_role function, or better, the set_roles function 
>> (not sure if it will work, let joshua know if the swig typemaps 
>> create problems for that case).
>> - I would recommend a message be printed out after a delete() that 
>> leaves a policy object behind (do exists check again), that says: 
>> "Deleted local modifications to <object>, falling back to policy 
>> default". This describes what the delete function really does in that 
>> case.
> Another thing - I am still not clear on memory management vs python.
> I don't see a single thing being freed in the python semanage - is 
> that a problem? Valgrind certainly prints a full 10 screens of errors 
> that complain about uninitialized value and invalid read on 
> PyObject_Free, but I'm not sure I understand what's going on.
I doubt that python can manage memory for precompiled code that it 
calls. I would guess it should be freeing things.
Another issue that I hadn't noticed is that the rc value on all exists 
functions isn't checked anywhere.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
