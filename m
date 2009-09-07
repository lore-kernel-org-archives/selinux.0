Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n87AipFl017366
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 06:44:51 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n87Ak8UD013620
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 10:46:09 GMT
Message-ID: <4AA4E41F.6040301@redhat.com>
Date: Mon, 07 Sep 2009 06:44:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage patch
References: <4A5DE96B.7080400@redhat.com> <4AA11C73.6000109@manicmethod.com>
In-Reply-To: <4AA11C73.6000109@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/04/2009 09:56 AM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> If you have a homedir that ends in '/', genhomedircon gets confused.
>>
>> # useradd -h /home2/dwalsh/ dwalsh
>> # genhomedircon
>>
>> Check out the labeling.  genhomedircon thinks dwalsh is a toplevel
>> home root.
>>
>> We should just get rid of this command...  :^)
>>
>> Patch removes all trailing '/' from homedir.
> 
>> diff --exclude-from=exclude -N -u -r
>> nsalibsemanage/src/genhomedircon.c libsemanage-2.0.33/src/genhomedircon.c
>> --- nsalibsemanage/src/genhomedircon.c    2008-08-28
>> 09:34:24.000000000 -0400
>> +++ libsemanage-2.0.33/src/genhomedircon.c    2009-07-15
>> 10:32:20.000000000 -0400
>> @@ -304,6 +304,10 @@
>>              continue;
>>          if (!semanage_list_find(shells, pwbuf->pw_shell))
>>              continue;
>> +        int len = strlen(pwbuf->pw_dir) -1;
>> +        for(; len > 0 && pwbuf->pw_dir[len]=='/'; len--) {
>> +            pwbuf->pw_dir[len]=0;
>> +        }
>>          if (strcmp(pwbuf->pw_dir, "/") == 0)
>>              continue;
>>          if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
> 
> Why aren't you just doing:
> 
> len = strlen(pwbuf->pwdir);
> if (pwbuf->pwdir[len] == '/')
>     pwbuf->pwdir[len] = '\0';
> 
> ?
> 
What about /home/dwalsh//////
Which I believe is legal
> Also, won't this fail if the homedir is set to '/' ? This check should
> probably go below the strcmp(pwbuf->pw_dir, "/") that is currently below
> it.
Yes good point.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
