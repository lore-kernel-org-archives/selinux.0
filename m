Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5EIGJTI016701
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 14:16:19 -0400
Subject: Re: [PATCH] libsepol/cil: Fix bugs when writing policy.conf rules
To: selinux@tycho.nsa.gov
References: <20170614173907.20493-1-jwcart2@tycho.nsa.gov>
 <20170614175643.GD5298@julius.enp8s0.d30>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <58a86265-991b-f396-5be4-e9b22d65515d@tycho.nsa.gov>
Date: Wed, 14 Jun 2017 14:17:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170614175643.GD5298@julius.enp8s0.d30>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/14/2017 01:56 PM, Dominick Grift wrote:
> On Wed, Jun 14, 2017 at 01:39:07PM -0400, James Carter wrote:
>> The typebounds rules should end with a ";".
>>
>> The netifcon and nodecon rules should not end with a ";".
>>
>> The default rules are missing a "_". They should be "default_usr",
>> "default_role" and "default_type".
> 
> I might be misunderstanding but according to https://selinuxproject.org/page/DefaultRules#default_user it should be "default_user"
> 

You are correct. I should have caught this when I tested it, but I think that I 
converted the cil file and then compiled the cil file instead of the conf file.

Thanks,
Jim

>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   libsepol/cil/src/cil_policy.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
>> index 2196ae8..f7fe24e 100644
>> --- a/libsepol/cil/src/cil_policy.c
>> +++ b/libsepol/cil/src/cil_policy.c
>> @@ -1069,7 +1069,7 @@ static void cil_typebounds_to_policy(FILE *out, struct cil_list *types)
>>   		child = i1->data;
>>   		if (child->bounds != NULL) {
>>   			parent = child->bounds;
>> -			fprintf(out, "typebounds %s %s\n", parent->datum.fqn, child->datum.fqn);
>> +			fprintf(out, "typebounds %s %s;\n", parent->datum.fqn, child->datum.fqn);
>>   		}
>>   	}
>>   }
>> @@ -1779,7 +1779,7 @@ static void cil_netifcons_to_policy(FILE *out, struct cil_sort *netifcons, int m
>>   		cil_context_to_policy(out, netifcon->if_context, mls);
>>   		fprintf(out, " ");
>>   		cil_context_to_policy(out, netifcon->packet_context, mls);
>> -		fprintf(out, ";\n");
>> +		fprintf(out, "\n");
>>   	}
>>   }
>>   
>> @@ -1836,7 +1836,7 @@ static void cil_nodecons_to_policy(FILE *out, struct cil_sort *nodecons, int mls
>>   		}
>>   
>>   		cil_context_to_policy(out, nodecon->context, mls);
>> -		fprintf(out, ";\n");
>> +		fprintf(out, "\n");
>>   	}
>>   }
>>   
>> @@ -1928,9 +1928,9 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
>>   	cil_commons_to_policy(out, lists[CIL_LIST_COMMON]);
>>   	cil_classes_to_policy(out, db->classorder);
>>   
>> -	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], CIL_KEY_DEFAULTUSER);
>> -	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], CIL_KEY_DEFAULTROLE);
>> -	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], CIL_KEY_DEFAULTTYPE);
>> +	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], "default_usr");
>> +	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], "default_role");
>> +	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], "default_type");
>>   
>>   	if (db->mls == CIL_TRUE) {
>>   		cil_default_ranges_to_policy(out, lists[CIL_LIST_DEFAULT_RANGE]);
>> -- 
>> 2.9.4
>>
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
