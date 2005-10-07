Message-ID: <4345D717.4000404@cmcrc.com>
Date: Fri, 07 Oct 2005 12:01:59 +1000
From: Johan Fischer <jfischer@cmcrc.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
Subject: Re: matchpathcon regcomp return code
References: <43436F35.4040204@cmcrc.com>	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>	 <1128522566.22129.20.camel@sgc.columbia.tresys.com>	 <1128522897.24059.152.camel@moss-spartans.epoch.ncsc.mil> <1128620330.22129.76.camel@sgc.columbia.tresys.com>
In-Reply-To: <1128620330.22129.76.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just proposing an idea (possibly stupid or out of focus compare to the
new algorithm which I don't know about yet)....

What happens if you have a sort of headers .fc file for suggested
replaceable types (like the / and subtree context) and a trailer .fc to
override important context in any case ( the lost+context and subdir) ?


Christopher J. PeBenito wrote:

>On Wed, 2005-10-05 at 10:34 -0400, Stephen Smalley wrote:
>  
>
>>On Wed, 2005-10-05 at 10:29 -0400, Christopher J. PeBenito wrote:
>>    
>>
>>>We kept it separate because we were still working with the algorithm.
>>>More importantly, we don't want to affect the example policy, since it
>>>altered the order on at least one occasion, as discussed before.  If you
>>>don't have a problem with this, we can certainly work on a patch for
>>>matchpathcon.
>>>      
>>>
>>Yes, I think it would be preferable to have it directly in matchpathcon,
>>and we can add further pathname regexes as needed to fix any undesired
>>changes in the actual labeling.  I don't know if you've done anything
>>further with respect to the idea floated earlier about (optional)
>>explicit precedence/order specifiers in file contexts, but we might want
>>to introduce those at the same time.
>>    
>>
>
>We haven't added any precedence/order specifiers in the file contexts,
>since, the previous problem I mentioned was fixed by adding another more
>specific regex.  If we do want to add the optional specifiers, the
>question becomes how we want to use it for comparison?  Should it be
>used as the last comparison, like a tie-breaker, or as the first
>comparison, which would group regexes of the same priority?  Also, what
>happens if one regex has a precedence and the other doesn't?
>
>  
>

-- 
Johan Fischer
Capital Markets CRC Limited
Level 2, 9 Castlereagh Street, Sydney NSW 2000
Tel: +61 2 9233 7999   Direct: +61 2 9236 9150
Fax: +61 2 9236 9177   http://www.cmcrc.com

Capital Markets CRC Ltd (CMCRC) - Confidential Communication
The information contained in this e-mail is confidential.  It is intended solely for the addressee. If you receive this e-mail by mistake please promptly inform us by reply e-mail and then delete the e-mail and destroy any printed copy. You must not disclose or use in any way the information in the e-mail. There is no warranty that this e-mail is error or virus free. It may be a private communication, and if so, does not represent the views of the CMCRC and its associates. If it is a private communication, care should be taken in opening it to ensure that undue offence is not given.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
