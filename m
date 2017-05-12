From: Daniel Jurgens <danielj@mellanox.com>
To: James Carter <jwcart2@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/9] libsepol: Add ibpkey ocontext handling
Date: Fri, 12 May 2017 15:31:45 +0000
Message-ID: <VI1PR05MB1678A30736F05FC321970636C4E20@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-3-git-send-email-danielj@mellanox.com>
 <d7e907c5-6910-96d4-cadb-2bb62753132f@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/11/2017 10:18 AM, James Carter wrote:
> libsepol now has the functionality to write cil or a policy.conf from a kernel 
> policy, so kernel_to_cil.c and kernel_to_conf.c need to be updated as well. 
> Doing that shouldn't be any more complicated than what was done for module_to_c.
>
> Jim
Added.  Thanks for reviewing, completely missed when those files were added.
>
> On 05/09/2017 04:50 PM, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Add support for reading, writing, and copying Infinabinda Pkey ocontext
>> data. Also add support for querying a Pkey sid to checkpolicy.
>>
