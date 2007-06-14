Message-ID: <46715599.7070300@manicmethod.com>
Date: Thu, 14 Jun 2007 10:50:01 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: russell@coker.com.au, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
References: <558323.22266.qm@web36612.mail.mud.yahoo.com>
In-Reply-To: <558323.22266.qm@web36612.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Russell Coker <russell@coker.com.au> wrote:
>
>   
>> On Wednesday 13 June 2007 22:31, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>     
>>> On Wed, 2007-06-13 at 21:16 +1000, Russell Coker wrote:
>>>       
>>>> On Wednesday 13 June 2007 01:57, Stephen Smalley <sds@tycho.nsa.gov> 
>>>>         
>> wrote:
>>     
>>>>> Well, first, no script should be allowed a capability that is not given
>>>>> to its caller directly ;)
>>>>>           
>>>> Why not?  Isn't that the entire point of this authoritative granting of
>>>> capabilities patch?
>>>>         
>>> _script_, not program.
>>>       
>> OK, that's a bit of a topic change.
>>
>> I've been thinking about the script issue.  It seems to me that a problem we 
>> face is the replacement of executables by scripts (which often happens in 
>> distributions and sometimes happens with programs that are relevant to system
>>
>> integrity).
>>     
>
> That should only be a problem on a name based system, right?
>
> OK, sorry for the dig. Anyhow, it seems that the program that
> sets the policy (labels the file system?) ought to be checking
> the "type" of the file if it matters. You also might consider
> that as 21st century programming (special purpose scripting)
> replaces 20th century programming (general purpose binaries)
> fewer people are going to be tolerent of a distintion between
> a "program" and a "script" and look seriously at how you might
> avoid having to treat them differently.
>   

We don't have to treat them differently if the interpreters will respect 
ATSECURE and cleanse the environment across domain transitions or setuid 
just like the linker does for compiled binaries. The race will still be 
there but is alot harder to exploit than environment changes that change 
the interpreter behavior.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
