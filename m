Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88G4iwV005881
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 12:04:44 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n88G45IT028386
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 16:04:05 GMT
Date: Tue, 08 Sep 2009 12:04:31 -0400
Subject: Re: libsemanage patch
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6CBF8CF.AA709%csellers@tresys.com>
In-Reply-To: <4AA4E41F.6040301@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/7/09 6:44 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 09/04/2009 09:56 AM, Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> If you have a homedir that ends in '/', genhomedircon gets confused.
>>> 
>>> # useradd -h /home2/dwalsh/ dwalsh
>>> # genhomedircon
>>> 
>>> Check out the labeling.  genhomedircon thinks dwalsh is a toplevel
>>> home root.
>>> 
>>> We should just get rid of this command...  :^)
>>> 
>>> Patch removes all trailing '/' from homedir.
>> 
>>> diff --exclude-from=exclude -N -u -r
>>> nsalibsemanage/src/genhomedircon.c libsemanage-2.0.33/src/genhomedircon.c
>>> --- nsalibsemanage/src/genhomedircon.c    2008-08-28
>>> 09:34:24.000000000 -0400
>>> +++ libsemanage-2.0.33/src/genhomedircon.c    2009-07-15
>>> 10:32:20.000000000 -0400
>>> @@ -304,6 +304,10 @@
>>>              continue;
>>>          if (!semanage_list_find(shells, pwbuf->pw_shell))
>>>              continue;
>>> +        int len = strlen(pwbuf->pw_dir) -1;
>>> +        for(; len > 0 && pwbuf->pw_dir[len]=='/'; len--) {
>>> +            pwbuf->pw_dir[len]=0;
>>> +        }
>>>          if (strcmp(pwbuf->pw_dir, "/") == 0)
>>>              continue;
>>>          if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
>> 
>> Why aren't you just doing:
>> 
>> len = strlen(pwbuf->pwdir);
>> if (pwbuf->pwdir[len] == '/')
>>     pwbuf->pwdir[len] = '\0';
>> 
>> ?
>> 
> What about /home/dwalsh//////
> Which I believe is legal
>> Also, won't this fail if the homedir is set to '/' ? This check should
>> probably go below the strcmp(pwbuf->pw_dir, "/") that is currently below
>> it.
> Yes good point.
> 
I thought it worked fine with '/'. Since the loop condition is len > 0
(where len is the index of the last character, not the length of the string,
which is a bit confusing and should probably be changed), it would never
reset the first character. And don't you want this before the
strcmp(pwbuf->pw_dir, "/") in case the path is ///// (which would of course
be silly, but I believe is legal anyway)?

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
