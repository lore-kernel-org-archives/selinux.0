Message-ID: <461A57D7.3040704@redhat.com>
Date: Mon, 09 Apr 2007 11:12:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: libselinux patch
References: <461530F6.3030407@redhat.com>	 <1175795098.5711.90.camel@moss-spartans.epoch.ncsc.mil>	 <46156363.7010007@redhat.com> <1176128256.15415.71.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1176128256.15415.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-04-05 at 17:00 -0400, Daniel J Walsh wrote:
>   
>> Second pass.
>>
>>
>> plain text document attachment (diff)
>>     
>
>   
>> diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getsebool.c libselinux-2.0.9/utils/getsebool.c
>> --- nsalibselinux/utils/getsebool.c	2006-11-16 17:15:17.000000000 -0500
>> +++ libselinux-2.0.9/utils/getsebool.c	2007-04-05 16:57:51.000000000 -0400
>> @@ -14,7 +14,7 @@
>>  
>>  int main(int argc, char **argv)
>>  {
>> -	int i, rc = 0, active, pending, len = 0, opt;
>> +	int i, get_all = 0, rc = 0, active, pending, len = 0, opt;
>>  	char **names;
>>  
>>  	while ((opt = getopt(argc, argv, "a")) > 0) {
>> @@ -39,6 +39,7 @@
>>  				printf("No booleans\n");
>>  				return 0;
>>  			}
>> +			get_all = 1;
>>  			break;
>>  		default:
>>  			usage(argv[0]);
>> @@ -72,6 +73,8 @@
>>  	for (i = 0; i < len; i++) {
>>  		active = security_get_boolean_active(names[i]);
>>  		if (active < 0) {
>> +			if (! get_all && errno == EACCES) 
>> +				continue;
>>     
>
> Shouldn't that be if (get_all && errno == EACCES)?
> The goal is to only suppress the warnings upon getsebool -a, not the
> other way around.
>
>   
Yes. 
>>  			fprintf(stderr, "Error getting active value for %s\n",
>>  				names[i]);
>>  			rc = -1;
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
