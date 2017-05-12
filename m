From: Daniel Jurgens <danielj@mellanox.com>
To: James Carter <jwcart2@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 5/9] libsepol: Add ibendport ocontext handling
Date: Fri, 12 May 2017 15:54:04 +0000
Message-ID: <VI1PR05MB167830C2DC2947111F198B03C4E20@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-6-git-send-email-danielj@mellanox.com>
 <fa60c70b-9be4-ceb5-4ce6-61deaf022889@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/11/2017 10:20 AM, James Carter wrote:
> Like I mentioned for patch 2, kernel_to_cil.c and kernel_to_conf.c need to be 
> updated.
>
> Jim
Added

> On 05/09/2017 04:50 PM, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Add support for reading, writing, and copying IB end port ocontext data.
>> Also add support for querying a IB end port sid to checkpolicy.
>>
