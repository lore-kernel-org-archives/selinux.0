From: Daniel Jurgens <danielj@mellanox.com>
To: James Carter <jwcart2@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 6/9] libsepol: Add IB end port handling to CIL
Date: Fri, 12 May 2017 15:57:56 +0000
Message-ID: <VI1PR05MB1678E6C7F2B5F85E0185FAB1C4E20@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-7-git-send-email-danielj@mellanox.com>
 <d4e96533-6be1-d934-1e10-8103ef1b3f31@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/11/2017 10:07 AM, James Carter wrote:
> On 05/09/2017 04:50 PM, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>>
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index 1df41da..69ce786 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -2038,6 +2038,31 @@ exit:
>>   	return rc;
>>   }
>>   
>> +int cil_resolve_ibendportcon(struct cil_tree_node *current, void *extra_args)
> Should have function prototype in cil_resolve_ast.h
>
> Jim
Done
