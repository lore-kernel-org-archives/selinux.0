Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3DrvWt029723
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 08:53:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3DraC7008660
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 13:53:36 GMT
Received: from carbine.dsl.net (carbine.dsl.net [65.84.81.3])
	by jazzswing.ncsc.mil  with ESMTP id hA3Drauw008654
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 13:53:36 GMT
Message-ID: <3FA65E3B.6080008@tresys.com>
Date: Mon, 03 Nov 2003 08:55:07 -0500
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: specifying groups of types
References: <200310111435.46684.russell@coker.com.au>	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>	 <3F8C46E4.1030403@tresys.com> <1067794997.5374.42.camel@chris.pebenito.net>
In-Reply-To: <1067794997.5374.42.camel@chris.pebenito.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I didn't receive any comments on it.  I'd emphasize again that my 
solution was not a "proper" fix (it leaves open too many 
inconsistencies) and was not intended to be accepted as an official 
patch until it was cleaned up.  If no one comes up with a clean solution 
I'll fix mine when I have the chance.  Right now I'm trying to finish up 
the parsing code for our conditional policy modification among other things.

David

Chris PeBenito wrote:
> Was there any resolution to this?  I think this would be useful for
> checkpolicy to have, but it hasn't been merged (at least on the
> sourceforge cvs).  I don't remember seeing any official response from
> the NSA team about it nor any criticism/improvements of it.
> 
> On Tue, 2003-10-14 at 13:56, David Caplan wrote:
> 
>>Russell,
>>
>>Here's a quick hack that appears to work.  It turns off the type (or 
>>list of types if used on an attribute) when building the bitmap of types 
>>for a rule.  The syntax is to use a '-' in front of a type or attribute 
>>name.
>>
>>allow some_domain { file_type -shadow_t -null_device_t -exec_type}:...
>>
>>The proper way to do this is in the yacc parsing section.  All I did was 
>>allow '-' as the first character of an identifier (policy_scan.l) and 
>>handle the subtraction of the type/attribute in 
>>policy_parse.y:set_types().  The danger is that types (and anything 
>>using the identifier definition) can be declared with '-' as the first 
>>character and cause problems.  The advantage, in theory, is that 
>>wherever a list of types/attributes is processed, the '-' notation can 
>>be used to turn off types.  So, you should also be able to do something 
>>like:
>>
>>allow { auth -crond_t } file_type:...
>>
>>Types/attributes are processed in order, and subsequent allow rules can 
>>also override the subtraction.
>>
>>I'd recommend trying this out and if you find it useful change the parse 
>>rules.  I tested it on some real basic policy, so it may cause other 
>>unintended problems.  I'm throwing it out more as a starting point 
>>rather than something intended to be integrated into checkpolicy.
>>
>>David
>>
>>Stephen Smalley wrote:
>>
>>>On Sat, 2003-10-11 at 00:35, Russell Coker wrote:
>>>
>>>
>>>>Following a discussion on IRC, it occurs to me that it would be handy to have 
>>>>the following in the policy language:
>>>>allow some_domain { file_type !shadow_t }:...
>>>>
>>>>So we can specify everything in file_type except for shadow_t.
>>>
>>>
>>>Yes, although I'm not sure about the notation; might be better to
>>>provide a set difference operator, e.g.
>>>	file_type - shadow_t
>>>
>>>Are you offering to implement this enhancement to checkpolicy?
>>>


-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
