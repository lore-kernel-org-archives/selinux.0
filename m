Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2PGPc6I016525
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2010 12:25:38 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2PGPDWu020558
	for <selinux@tycho.nsa.gov>; Thu, 25 Mar 2010 16:25:13 GMT
Message-ID: <4BAB8E7D.6040701@redhat.com>
Date: Thu, 25 Mar 2010 12:25:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils warnings
References: <4BAB7B06.7090206@tresys.com>
In-Reply-To: <4BAB7B06.7090206@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/25/2010 11:02 AM, Joshua Brindle wrote:
> Any idea about these Dan?
>
>> xgettext: warning: file `../audit2allow/audit2allow' extension `' is 
>> unknown; will try C
>> ../semanage/seobject.py:547: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:559: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:745: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:762: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:764: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:768: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:774: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:778: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:782: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:786: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:791: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:795: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:799: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:821: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:823: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:827: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:838: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:876: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:878: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:882: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:884: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:888: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                       The translator cannot reorder 
>> the arguments.
>>                                       Please consider using a format 
>> string with named arguments,
>>                                       and a mapping instead of a 
>> tuple for the arguments.
>> ../semanage/seobject.py:1632: warning: 'msgid' format string with 
>> unnamed arguments cannot be properly localized:
>>                                        The translator cannot reorder 
>> the arguments.
>>                                        Please consider using a format 
>> string with named arguments,
>>                                        and a mapping instead of a 
>> tuple for the arguments.
>> xgettext: warning: file `../scripts/chcat' extension `' is unknown; 
>> will try C
>> xgettext: warning: file `../scripts/fixfiles' extension `' is 
>> unknown; will try C
>> ../scripts/fixfiles:163: warning: unterminated string literal
>> ../scripts/fixfiles:168: warning: unterminated string literal
>> ../scripts/fixfiles:196: warning: unterminated string literal
>> ../scripts/fixfiles:204: warning: unterminated string literal
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
Do you have the policycoreutils translation libraries installed?

How are you testing these?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
