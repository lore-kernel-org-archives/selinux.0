Message-ID: <45DC7551.9090200@mentalrootkit.com>
Date: Wed, 21 Feb 2007 11:37:37 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chcat changes (Was:  Re: policycoreutils patch)
References: <45DB0AB8.3070803@redhat.com> <1171988571.14363.111.camel@moss-spartans.epoch.ncsc.mil> <45DB3637.7080400@redhat.com>
In-Reply-To: <45DB3637.7080400@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Stephen Smalley wrote:
>> On Tue, 2007-02-20 at 09:50 -0500, Daniel J Walsh wrote:
>>  
>>> chcat fixes:
>>>     * Broken stderr handling fix
>>>     * if serange ends in a ":" chop it off.
>>>     * Switch chcat to exec semanage rather than use builtin so that 
>>> proper transitions happen, otherwise I would have to run chcat under 
>>> an semanage context.
>>>     
>>
>> Why would a range end in a ":"?  Context translation issue?
>>
>>   
> No.
>      new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, 
> ","))
>        if new_serange[-1:] == ":":
>            new_serange = new_serange[:-1]
> If you did not have cats you would end up with s0-s0:
> 

Then why not something more direct (completely untested):

new_serange = "%s-%s" % (searange[0], top[0])
new_cats = ",".join(cats)
if new_cats != '':
	new_serange = new_serange + ":" + new_cats

I think that the list subscripting with -1 and : is confusing to 
non-python programmers. Also, I think that use of string.join is 
discouraged in favor of using the join method on strings - though that 
likely looks as odd as a -1 index to a non-python programmer.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
