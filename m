Message-ID: <45F02A80.5050708@tresys.com>
Date: Thu, 08 Mar 2007 10:23:44 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>	 <1173284267.10747.9.camel@sgc>  <45F010A4.4020201@kaigai.gr.jp>	 <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>	 <45F022A0.3020105@kaigai.gr.jp> <1173366058.10467.67.camel@moss-spartans.epoch.ncsc.mil> <45F02A09.5060301@tresys.com>
In-Reply-To: <45F02A09.5060301@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Thu, 2007-03-08 at 23:50 +0900, KaiGai Kohei wrote:
>>> Stephen Smalley wrote:
>>>> On Thu, 2007-03-08 at 22:33 +0900, KaiGai Kohei wrote:
>>>>> Christopher J. PeBenito wrote:
>>>>>> On Mon, 2007-03-05 at 23:41 +0900, KaiGai Kohei wrote:
>>>>>>> The attached patch adds new object classes, access vectors and
>>>>>>> booleans related to database.
>>>>>>> SE-PostgreSQL uses them to manage the various kinds of database
>>>>>>> objects such as tables, columns, tuples and so on.
>>>>>>>
>>>>>>> The most of security policies are provided as a binary security
>>>>>>> policy within RPM package. But it requires the definition of new
>>>>>>> object classes, access vectors and booleans in the base policy.
>>>>>>>
>>>>>>> Please apply it.
>>>>>> Is the code on a path to being merged upstream?  I'm hesitant to 
>>>>>> apply
>>>>>> class changes until the code is on a plan to be merged.
>>>>> Pushing to the upstreamed PostgreSQL is one of the next activities.
>>>>> No need to say, I'm targeting it to be merged as a part of PostgreSQL.
>>>>>
>>>>> I'll submit a patch to add new object classes again after discussion
>>>>> in the pgsql-hackers list. But I'm desiring the object class numbers
>>>>> are fixed earlier. (currently, I uses 60 - 65 to represent them)
>>>> Where do things stand wrt dynamic userspace object class and permission
>>>> discovery?  It would be nice to avoid further spread of hardcoded
>>>> classes and permissions in applications if we can avoid it.
>>> See, 
>>> http://sepgsql.googlecode.com/svn/trunk/src/include/security/sepgsql_internal.h 
>>>
>>> When I started to develop, 'context' class has the maximum number of 
>>> object
>>> class, so I defined 'SECCLASS_DATABASE' next to it.
>>> # But it will conflict with 'dccp_socket' class now... :-(
>>
>> Yes, you'll have to re-base.  Of course, you should be using the
>> libselinux headers instead of your own private definitions, i.e.
>>     cd refpolicy/policy/flask
>>     (update security_classes and access_vectors to add your defs)
>>     make
>>     make LIBSEL=/path/to/libselinux tolib
>>     cd /path/to/libselinux
>>     make install relabel
>>
>> Then just #include <selinux/flask.h> and #include
>> <selinux/av_permissions.h> in your SE-PostgreSQL code.  Don't duplicate
>> the definitions there - that makes it even worse.
>>
>> But in the long term, we want to move away from using #define's
>> altogether and have the object managers dynamically map the class and
>> permission string names during startup to values via libselinux
>> functions (which in turn can use a selinuxfs node or an auxiliary policy
>> file to get the information).
>>
> 
> We'll be resuming work on dynamic object class discovery soon, 
> unfortunately the SELinux Symposium interferes with real work. IIRC the 
> current decision was to use an selinuxfs node to get values to avoid 
> desynchronization of class numbers in the kernel and on disk.
> 

It might be nice to get an API nailed down and put it in immediately so 
that sepostgres can start using it and put in functions that use the 
static numbers.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
