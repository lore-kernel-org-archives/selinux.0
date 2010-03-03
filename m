Message-ID: <4B8EA77E.2040008@gmail.com>
Date: Wed, 03 Mar 2010 10:16:30 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: AlannY <m@alanny.ru>, SELinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Problem with compiling refpolicy base.pp
References: <4B8E72D2.8030802@alanny.ru>	 <1267629710.6048.63.camel@moss-pluto.epoch.ncsc.mil> <1267633395.6048.116.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267633395.6048.116.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/03/2010 08:23 AM, Stephen Smalley wrote:
> On Wed, 2010-03-03 at 10:21 -0500, Stephen Smalley wrote:
>> On Wed, 2010-03-03 at 17:31 +0300, AlannY wrote:
>>> Hi there.
>>>
>>> I'm trying to compile refpolicy. I have checkpolicy 2.0.20 and misc
>>> tools (libselinux policycoreutils). I'm trying to:
>>>
>>>      make bare
>>>      make conf
>>>      make base.pp
>>>
>>> My configuration:
>>>
>>> TYPE=mcs
>>> NAME=refpolicy
>>> UNK_PERMS=allow
>>> DIRECT_INITRC=n
>>> MONOLITHIC=n
>>> UBAC=n
>>> MLS_CATS=1024
>>> MCS_CATS=1024
>>>
>>> But, the last command failed with the following error:
>>>
>>>      Creating refpolicy base module base.conf
>>>      cat tmp/pre_te_files.conf tmp/all_attrs_types.conf
>>> tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_post.conf>  base.conf
>>>      Compiling refpolicy base module
>>>      /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
>>>      /usr/bin/checkmodule:  loading policy configuration from base.conf
>>>      base.conf:2032:ERROR 'syntax error' at token ':c0.c1023' on line 2032:
>>>      level s0:c0.c1023;
>>>
>>> Seems to be, it's a good line (2032), but checkmodule can't eat it.
>>>
>>> Where can be the probem?
>>
>> Looks like a scanner problem to me.  There have been problems with some
>> versions of flex, e.g. see:
>> http://marc.info/?t=125613782400001&r=1&w=2
>> but no one has ever tracked it down precisely and I've never been able
>> to reproduce.  Modify your checkpolicy Makefile to pass -d to $(LEX) so
>> that it generates debug output and then capture the stderr of running
>> checkpolicy on base.conf.  Here I get the following output for that
>> line:
>> --accepting rule at line 55 ("
>> level s0:c0.c1023;")
>> --accepting rule at line 116 ("level")
>> --accepting rule at line 227 (" ")
>> --accepting rule at line 219 ("s0")
>> --accepting rule at line 235 (":")
>> --accepting rule at line 219 ("c0.c1023")
>> --accepting rule at line 236 (";")
>>
>> Note that the ":" gets treated as a separate token above, as it should,
>> whereas your checkmodule seems to not be splitting it properly.
>>
>> You can look at checkpolicy/policy_scan.l and see if anything strikes
>> you as problematic, but it looks sane to me.  Maybe it is matching on
>> ipv6_addr instead.  On second look, I'm wondering why ipv6_addr has . in
>> the pattern.  Does this help?
>>
>> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
>> index 48128a8..b7b8f0a 100644
>> --- a/checkpolicy/policy_scan.l
>> +++ b/checkpolicy/policy_scan.l
>> @@ -219,7 +219,7 @@ PERMISSIVE			{ return(PERMISSIVE); }
>>   {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
>>   {digit}+|0x{hexval}+            { return(NUMBER); }
>>   {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>> -{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>> +{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":")*  { return(IPV6_ADDR); }
>>   {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
>>   #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
>>   #line[ ]{digit}+	        { source_lineno = atoi(yytext+6)-1; }
>
> It turns out there was a reason why we originally allowed "." in the
> ipv6_addr pattern - for embedded ipv4 addresses,
> http://www.tcpipguide.com/free/t_IPv6IPv4AddressEmbedding.htm
>
> Re-considering this, I don't see why we'd match on ipv6_addr anyway
> (":c0.c1023" doesn't match the pattern as it lacks two colons), so
> perhaps this is still a bug in flex.
>
> It did first seem to manifest after the ipv6_addr pattern was added
> though, so I think that the ipv6_addr pattern is the trigger for the
> bug.
> http://marc.info/?t=109338686200002&r=1&w=2
>
>


man!! seeing all of the bickering towards the end
really looks bad.

Anyways I made a wrapper with the -l option and tried other options
as well, and still am able to reproduce this syntax error.

FWIW here's the -v option while building checkmodule/checkpolicy with 
new/older
versions of flex:

  scanner options: -lvI8 -Cem
   1677/2000 NFA states
   944/1000 DFA states (8671 words)
   188 rules
   Compressed tables always back-up
   1/40 start conditions
   494 epsilon states, 252 double epsilon states
   28/100 character classes needed 458/500 words of storage, 0 reused
   50312 state/nextstate pairs created
   3621/46691 unique/duplicate transitions
   988/1000 base-def entries created
   2182/4000 (peak 5221) nxt-chk entries created
   396/5000 (peak 3520) template nxt-chk entries created
   0 empty table entries
   49 protos created
   44 templates created, 98 uses
   80/256 equivalence classes created
   9/256 meta-equivalence classes created
   0 (17 saved) hash collisions, 2680 DFAs equal
   3 sets of reallocations needed
   6676 total table entries needed


and the -v option with the older version of flex that
works:

/flex version 2.5.4 usage statistics:
   scanner options: -lvI8 -Cem
   1621/2000 NFA states
   891/1000 DFA states (8396 words)
   188 rules
   Compressed tables always back-up
   1/40 start conditions
   465 epsilon states, 236 double epsilon states
   13/100 character classes needed 161/500 words of storage, 14 reused
   48957 state/nextstate pairs created
   3506/45451 unique/duplicate transitions
   907/1000 base-def entries created
   2038/4000 (peak 2927) nxt-chk entries created
   144/2500 (peak 1280) template nxt-chk entries created
   0 empty table entries
   21 protos created
   16 templates created, 48 uses
   80/256 equivalence classes created
   9/256 meta-equivalence classes created
   1 (15 saved) hash collisions, 2618 DFAs equal
   2 sets of reallocations needed
   6226 total table entries needed



I thinking I'll try a go at bisecting flex(if possible),and see,
but might take some time.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
