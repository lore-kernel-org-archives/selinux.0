Message-ID: <43B985EA.2040704@tresys.com>
Date: Mon, 02 Jan 2006 14:58:34 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Swig update: typemaps
References: <43AF074E.6040301@cornell.edu> <43B979B6.8090201@tresys.com>
In-Reply-To: <43B979B6.8090201@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
> 
<snip>
>> @@ -67,6 +73,14 @@
>>  %apply int *OUTPUT { int * };
>>  %apply int *OUTPUT { size_t * };
>>  
>> +%typemap(in, numinputs=0) char **(char *temp) {
>> +    $1 = &temp;
>> +}
>> +
>> +%typemap(argout) char** {
>> +    $result = t_output_helper($result, SWIG_FromCharPtr(*$1));
>> +}
>> +
> 
> 
> Have to be careful with this one, you don't want it messing with other 
> char**. Did you run all the tests in pywrap-test after rebuilding this 
> to make sure it didn't interrupt anything else?
> 
> The rest look fine.
> 

Speaking of which. Anytime you add anything to the wrapper please add 
the corresponding tests to pywrap-test. I'd like it if there was always 
a test for anything in mainline (I think Steve would too)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
