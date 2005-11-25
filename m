Message-ID: <438656CE.6030804@cmcrc.com>
Date: Fri, 25 Nov 2005 11:11:58 +1100
From: Johan Fischer <jfischer@cmcrc.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: [refpolicy][PATCH] fix Makefile BASE_MODS and MOD_MODS	detection
References: <43715253.2070108@cmcrc.com> <1131546156.24234.58.camel@sgc>
In-Reply-To: <1131546156.24234.58.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI,

the solution to the problem....

make sure that you're using gawk and not mawk as the default awk on your
system.

possibly the gawk and mawk way of adding extra anchors might be
different making it fail on my installation ( I don't how when I
installed mawk or why, but anyway....)

Cheers.
J.


Christopher J. PeBenito wrote:

>On Wed, 2005-11-09 at 12:35 +1100, Johan Fischer wrote:
>  
>
>>quick patch to fix the modules detection from the modules.conf file...
>>
>>before:
>>$ awk '/^[[:blank:]]*[[:alpha:]]/{ if ($3 == "module") print $1 }'
>>policy/modules.conf
>>(no result)
>>
>>after:
>>$ awk '/^[[:blank:]]*[[:alpha:]]*/{ if ($3 == "module") print $1 }'
>>policy/modules.conf
>>apm
>>apache
>>bluetooth
>>    
>>
>
>I can't reproduce this behavior.  I don't believe this patch is correct,
>as it makes the regex too inspecific.  With the change, the regex
>matches all lines, so if the second word in a comment was "module", it
>would print out "#", causing errors.
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
