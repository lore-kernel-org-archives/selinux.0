Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09EYUCr006037
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 09:34:30 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09EZG2v022264
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 14:35:17 GMT
Message-ID: <45A3A7F3.20904@mentalrootkit.com>
Date: Tue, 09 Jan 2007 09:34:27 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] allow semodule -i to accept list of modules
References: <1168292627.14203.2.camel@localhost.localdomain> <45A31548.8030807@tresys.com>
In-Reply-To: <45A31548.8030807@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Karl MacMillan wrote:
>> The following patch allows semodule to handle a list of modules for
>> installation (i.e., semodule -i *.pp now works).
>>
>>   
> Hrm, while the current syntax isn't ideal I don't think its the best 
> idea to change it abruptly. maybe you could make -I use the rest of the 
> arguments or something otherwise this will break any number of rpm's, 
> portage, the refpolicy makefiles and so on.
> 

I don't see how this could cause breakage as it doesn't change how any 
currently valid option sequence is processed. Instead, it makes invalid 
syntax valid (if you look closely at the patch, you can see that I am 
actually changing a fatal error path - so what I describe is guaranteed 
to be true).

I prefer this approach because I think it is the least surprising. I 
constantly try the syntax this patch allows only to remember that it 
doesn't work.

Karl

>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>>
>> diff -r e37f9d8d6611 policycoreutils/semodule/semodule.c
>> --- a/policycoreutils/semodule/semodule.c    Mon Jan 08 15:00:14 2007 
>> -0500
>> +++ b/policycoreutils/semodule/semodule.c    Mon Jan 08 16:37:23 2007 
>> -0500
>> @@ -225,15 +225,6 @@ static void parse_command_line(int argc,
>>              }
>>          }
>>      }
>> -    if (optind < argc) {
>> -        fprintf(stderr, "Extraneous arguments:  ");
>> -        while (optind < argc)
>> -            fprintf(stderr, "%s", argv[optind++]);
>> -        fprintf(stderr, "\n");
>> -        usage(argv[0]);
>> -        cleanup();
>> -        exit(1);
>> -    }
>>      if ((build || reload) && num_commands) {
>>          fprintf(stderr,
>>              "build or reload should not be used with other commands\n");
>> @@ -244,6 +235,24 @@ static void parse_command_line(int argc,
>>          fprintf(stderr, "At least one mode must be specified.\n");
>>          usage(argv[0]);
>>          exit(1);
>> +    }
>> +
>> +    if (optind < argc) {
>> +        /* if -i was the last command treat any remaining
>> +         * arguments as modules to allow 'semodule -i *.pp' to
>> +         * work as expected.
>> +         */
>> +        if (commands[num_commands - 1].mode == INSTALL_M) {
>> +            while (optind < argc)
>> +                set_mode(INSTALL_M, argv[optind++]);
>> +        } else {
>> +            fprintf(stderr, "unknown additional arguments:\n");
>> +            while (optind < argc)
>> +                fprintf(stderr, " %s", argv[optind++]);
>> +            fprintf(stderr, "\n\n");
>> +            usage(argv[0]);
>> +            exit(1);
>> +        }
>>      }
>>  }
>>  
>>
>>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>>   
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
