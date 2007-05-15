Message-ID: <4649EB49.1070302@manicmethod.com>
Date: Tue, 15 May 2007 13:18:01 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Caleb Case <ccase@tresys.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        B Topscher <bryan@jennandbryan.com>, selinux@tycho.nsa.gov,
        dgoeddel@TrustedCS.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [BUG] Segfault on duplicate require of sensitivity
References: <8b4cbe570704190829m67daa55di8c21a51408987b89@mail.gmail.com>	 <1179238573.25191.24.camel@localhost>	 <1179239973.5130.9.camel@localhost.localdomain> <1179248956.25191.41.camel@localhost>
In-Reply-To: <1179248956.25191.41.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Caleb Case wrote:
> On Tue, 2007-05-15 at 10:39 -0400, Karl MacMillan wrote:
>   
>> On Tue, 2007-05-15 at 10:16 -0400, Caleb Case wrote:
>>     
>>> It turns out that level_datum_t is not defined as an actual datum:
>>>
>>>       
>> [...]
>>
>>     
>>> The options I see here are not good.  One option: the level_datum_t
>>> should be changed into a conforming *_datum_t and the fallout of this
>>> change handled in the rest of the code which expects to see a
>>> level_datum_t->level.  Second option: level_datum_t is treated specially
>>> in require_symbol (using the symbol_type as the switch).
>>>
>>>       
>> Making it a _datum_t seems to be the right choice - what is your concern
>> about following that path?
>>
>> Karl
>>     
>
> Mainly I am concerned because level_datum_t is exported in libsepol's
> protected headers and will require changes to anything that statically
> links to libsepol.
>
>   
Err, I don't think this is the main issue. The level datum references 
the sens_datum, which exists independantly of the level_datum. I think 
it would cause all sorts of problems to try to change that in the 
current code base.

Another option is to just punt on this and it should be handled 
naturally in the policyrep branch.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
