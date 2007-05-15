Message-ID: <4649F0A8.10800@manicmethod.com>
Date: Tue, 15 May 2007 13:40:56 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Caleb Case <ccase@tresys.com>, B Topscher <bryan@jennandbryan.com>,
        selinux@tycho.nsa.gov, dgoeddel@TrustedCS.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [BUG] Segfault on duplicate require of sensitivity
References: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>	 <1179238573.25191.24.camel@localhost>	 <1179239973.5130.9.camel@localhost.localdomain>	 <1179248956.25191.41.camel@localhost>  <4649EB49.1070302@manicmethod.com> <1179249578.22749.3.camel@localhost.localdomain>
In-Reply-To: <1179249578.22749.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Tue, 2007-05-15 at 13:18 -0400, Joshua Brindle wrote:
>   
>> Caleb Case wrote:
>>     
>>> On Tue, 2007-05-15 at 10:39 -0400, Karl MacMillan wrote:
>>>   
>>>       
>>>> On Tue, 2007-05-15 at 10:16 -0400, Caleb Case wrote:
>>>>     
>>>>         
>>>>> It turns out that level_datum_t is not defined as an actual datum:
>>>>>
>>>>>       
>>>>>           
>>>> [...]
>>>>
>>>>     
>>>>         
>>>>> The options I see here are not good.  One option: the level_datum_t
>>>>> should be changed into a conforming *_datum_t and the fallout of this
>>>>> change handled in the rest of the code which expects to see a
>>>>> level_datum_t->level.  Second option: level_datum_t is treated specially
>>>>> in require_symbol (using the symbol_type as the switch).
>>>>>
>>>>>       
>>>>>           
>>>> Making it a _datum_t seems to be the right choice - what is your concern
>>>> about following that path?
>>>>
>>>> Karl
>>>>     
>>>>         
>>> Mainly I am concerned because level_datum_t is exported in libsepol's
>>> protected headers and will require changes to anything that statically
>>> links to libsepol.
>>>
>>>   
>>>       
>> Err, I don't think this is the main issue. The level datum references 
>> the sens_datum, which exists independantly of the level_datum. I think 
>> it would cause all sorts of problems to try to change that in the 
>> current code base.
>>
>>     
>
> What kind of problems?
>
>   
What do we put in the symtab_datum? Do we reproduce what is in the 
sens_datum? They aren't the same data, I'm not totally sure why they are 
separated (Darrell, want to chime in on this?). The really crappy thing 
is that we decided to support mls in require statements by just using 
the whole string (eg., s0:c0.c126-s15:c0.c128) so that whole string gets 
a level datum (iirc). I guess we can try adding a symtab_datum and see 
what the fallout is but I think there are alot of assumptions about how 
level_datum and sens_datum relate.

>> Another option is to just punt on this and it should be handled 
>> naturally in the policyrep branch.
>>     
>
> We can't punt on a reproducible segfault - it needs to be fixed in
> stable.
>   
I know, I was half joking...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
