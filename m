Message-ID: <45DB3317.5010806@redhat.com>
Date: Tue, 20 Feb 2007 12:42:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole O_NONBLOCK change (Was:  Re: policycoreutils patch)
References: <45DB0AB8.3070803@redhat.com> <1171988261.14363.106.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1171988261.14363.106.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-02-20 at 09:50 -0500, Daniel J Walsh wrote:
>   
>> newrole hangs on a attached terminal device.  Nonblocking allows it to 
>> proceed.
>>     
>
> Won't this have side effects on programs run from the newrole'd shell?
> Should newrole open them with O_NONBLOCK and then clear it via fcntl
> before exec'ing the child shell
>   
Linda Knippers submitted this patch for bugzilla.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=228102


I am not sure if setting it back to non blocking would still cause the hang.
>   
>> plain text document attachment (diff)
>> diff --exclude-from=exclude --exclude=sepolgen-1.0.0 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-2.0.1/newrole/newrole.c
>> --- nsapolicycoreutils/newrole/newrole.c	2007-01-24 10:03:59.000000000 -0500
>> +++ policycoreutils-2.0.1/newrole/newrole.c	2007-02-15 15:16:09.000000000 -0500
>> @@ -640,7 +640,7 @@
>>  	}
>>  
>>  	/* Re-open TTY descriptor */
>> -	fd = open(ttyn, O_RDWR);
>> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>>  	if (fd < 0) {
>>  		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
>>  		return fd;
>> @@ -1131,13 +1131,13 @@
>>  		fprintf(stderr, _("Could not close descriptors.\n"));
>>  		goto err_close_pam;
>>  	}
>> -	fd = open(ttyn, O_RDONLY);
>> +	fd = open(ttyn, O_RDONLY|O_NONBLOCK);
>>  	if (fd != 0)
>>  		goto err_close_pam;
>> -	fd = open(ttyn, O_RDWR);
>> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>>  	if (fd != 1)
>>  		goto err_close_pam;
>> -	fd = open(ttyn, O_RDWR);
>> +	fd = open(ttyn, O_RDWR|O_NONBLOCK);
>>  	if (fd != 2)
>>  		goto err_close_pam;
>>  
>>     
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
