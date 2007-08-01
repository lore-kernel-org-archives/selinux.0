Message-ID: <46B083DF.6010400@redhat.com>
Date: Wed, 01 Aug 2007 09:00:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problem with semanage, looks like we don't handle the <<none>>
 context type?
References: <46AF3C5E.8080700@redhat.com> <46AFA0C8.90608@tresys.com>	 <46AFA242.1010903@redhat.com> <1185971344.15215.247.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1185971344.15215.247.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-07-31 at 16:57 -0400, Daniel J Walsh wrote:
>   
>> Joshua Brindle wrote:
>>     
>>> Daniel J Walsh wrote:
>>>       
>>>> cat /tmp/test.py
>>>> #!/usr/bin/python
>>>> from semanage import *
>>>> sh = semanage_handle_create()
>>>> rc, con = semanage_context_from_string(sh, "<<none>>")
>>>> rc,fcontext = semanage_fcontext_create(sh)
>>>> semanage_fcontext_set_con(sh, fcontext, con)
>>>>
>>>>
>>>> # python /tmp/test.py
>>>> Segmentation fault
>>>>         
>>> Granted the segfault needs to be fixed but what exactly are you trying 
>>> to accomplish? <<none>> is not a type, its just something matchpathcon 
>>> uses to short circuit its labeling behavior.
>>>
>>>       
>> I have a request from someone who wants to setup a directory that 
>> shortcuts the labeling behaviour.  IE wants restorecon and friends to do 
>> nothing in the directory.
>>     
>
> libsemanage maps a NULL context to <<none>>.
>
>   
Ok if I change the python to not set the context at all, then semanage 
does the right thing.

# semanage fcontext -a -t '<<none>>' /data

                if type != "<<none>>":
                       (rc, con) = semanage_context_create(self.sh)
                       ...
                       rc = semanage_fcontext_set_con(self.sh, fcontext, 
con)

Of course the syntax is a bit misleading from a technical point of view 
<<none>> is not a type.  But it works for me.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
