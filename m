Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5LEPaA9027494
 for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2016 10:25:37 -0400
Received: by mail-qk0-f170.google.com with SMTP id p10so22772456qke.3
 for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2016 07:25:33 -0700 (PDT)
Message-ID: <57694E5B.3050604@quarksecurity.com>
Date: Tue, 21 Jun 2016 10:25:31 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Correctly detect unknown classes in
 sepol_string_to_security_class
References: <1464966566-14597-2-git-send-email-brindle@quarksecurity.com>
 <1464967076-24170-1-git-send-email-brindle@quarksecurity.com>
 <10cfe4a6-2d75-e821-3ed5-fff8704dde17@tycho.nsa.gov>
In-Reply-To: <10cfe4a6-2d75-e821-3ed5-fff8704dde17@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> On 06/03/2016 11:17 AM, Joshua Brindle wrote:
>> Bail before running off the end of the class index
>>
>> Change-Id: I47c4eaac3c7d789f8d85047e34e37e3f0bb38b3a
>> Signed-off-by: Joshua Brindle<brindle@quarksecurity.com>
>
> Applied this one and then rewrote it to use hashtab_search().
> Not sure why it wasn't that way in the first place.

Thank you, that was a much better fix that I should have noticed...

>
>> ---
>>   libsepol/src/services.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
>> index d64a8e8..665fcaa 100644
>> --- a/libsepol/src/services.c
>> +++ b/libsepol/src/services.c
>> @@ -1155,7 +1155,7 @@ int hidden sepol_string_to_security_class(const char *class_name,
>>   	char *class = NULL;
>>   	sepol_security_class_t id;
>>
>> -	for (id = 1;; id++) {
>> +	for (id = 1; id<= policydb->p_classes.nprim; id++) {
>>   		class = policydb->p_class_val_to_name[id - 1];
>>   		if (class == NULL) {
>>   			ERR(NULL, "could not convert %s to class id", class_name);
>> @@ -1166,6 +1166,8 @@ int hidden sepol_string_to_security_class(const char *class_name,
>>   			return STATUS_SUCCESS;
>>   		}
>>   	}
>> +	ERR(NULL, "unrecognized class %s", class_name);
>> +	return -EINVAL;
>>   }
>>
>>   /*
>>
>
