Message-ID: <47EBFED7.8010109@tycho.nsa.gov>
Date: Thu, 27 Mar 2008 16:08:55 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve G <linux_4ever@yahoo.com>
CC: Steve Grubb <sgrubb@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <729568.16778.qm@web51505.mail.re2.yahoo.com>
In-Reply-To: <729568.16778.qm@web51505.mail.re2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve G wrote:
> Well, it could. However, this is the API that you currently have:
>   

API can always be changed or augmented.  For heaven's sake, the man page 
for "audit_log_user_semanage_message" isn't even spelled correctly right 
now.

> extern int audit_log_user_avc_message(int audit_fd, int type,
>         const char *message, const char *hostname, const char *addr,
>         const char *tty, uid_t uid);
>
> The whole avc from msg=  up to the exe= statement comes from libselinux. So, libselinux has to do the escaping unless we build a better API for selinux use. I could probably expose the function that does the escaping, but I had really wanted to try to maintain some consistency in the event by API.
>   

I would like to see an API that takes an array of struct { name, value 
}, or a variadic (name, value, name, value...).  I think this would be 
far more flexible than the current situation where libaudit functions 
are being defined that take 10, 15, or more parameters.  Furthermore, 
libaudit would handle all escaping of these values according to whatever 
it's format du jour is.  Let's please not start

I realize that this API would be more open ended since it would not 
hardcode specific name/value pairs being passed in, which is what the 
current set of functions are attempting to do with their fixed 
arguments.  But this could be handled some other way, by printing out a 
warning in the logs, doing an assert in the code, or returning an error 
condition if the criteria ones are missing.  Or just doing question 
marks like the current implementation.  Which you're going to have to do 
anyway, because as I have pointed out, not all machines have IP 
addresses or hostnames and not all programs have terminals.

I also made a suggestion earlier about cleaning up the taxonomy of audit 
fields, perhaps by using namespacing such as "selinux.perms, 
selinux.result" etc.

Finally, a good place to start might be to start putting a version 
number field into the messages.  The version number could be bumped for 
each change to the format or fields.


>
>   
>>  That way we avoid promulgating this "standard" into every caller of libaudit.
>>
>> If everything is going to be name-value based, then I want a libaudit 
>> function that takes a list of name/value pairs.
>>     
>
> SE Linux is the only user of the audit system that does not follow the name=value standard. Would you (and the community) really be willing to convert selinux over to that if we have the API for it?  Do you have any suggestions about how you'd like to see the new API implemented?
>
>
>   
>>> Also, is there any information about who caused the event? uid, auid, gid? 
>>> Even though this was a denied action, what is the results? Were they 
>>> successful (permissive) or was it really a failed and denied request?
>>>   
>>>       
>> I don't understand this last part with the result of the action.  How am 
>> I supposed to specify this?
>>     
>
> res=0 for failed and res=1 for success even though the action was denied. Admittedly, the audit avc API does not require this from SE Linux, but I could fix that if we change the API to something around name value pairs.
>   


OK.

>
>   
>> I need to modify libselinux (again) to support all of this extra uid and 
>> hostname stuff getting passed into the logging callback.
>>     
>
> Yes, CAPP and other CC protection profiles require that sufficient information be logged to determine who did the action that was denied or granted. 
>
>  
>   
>>> Would it make sense to fill in the workspace:window information for the 
>>> terminal? If X is being used remotely, is the addr & hostname fields correct?
>>>   
>>>       
>> The X server has a terminal that it runs on, /dev/tty7 or whatever.  The 
>> desktop workspaces and gnome-terminal/xterm pseudo-tty's are external to 
>> the X server and it doesn't know about them.
>>     
>
> So, should we also make a new field that logs the workspace:window that a request came from?
>   

A request does not come from a window.  A request comes from a process.  
The process comm name is already in the message, and the PID of the 
process is also known.  For remote connections, the address and hostname 
are known and can be logged (with some API changes as I mentioned).

I think there's some misunderstanding here about the workspaces, so let 
me try to explain this in more detail.  There is no such thing as a 
"workspace" in the X Window System.   The concept of a workspace is 
completely internal to the metacity window manager.  When you switch 
workspaces, what actually happens is that metacity hides all the windows 
on your screen and then shows a new set of windows.  The only thing the 
X server sees is the requests that are coming in to hide and show 
windows.  There is no workspace information in any X protocol 
requests.   It is _not possible_ for me to log a workspace from the X 
server.


> Thanks,
> -Steve
>
>
>
>
>
>       ____________________________________________________________________________________
> Never miss a thing.  Make Yahoo your home page. 
> http://www.yahoo.com/r/hs
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
