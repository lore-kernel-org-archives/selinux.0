From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 1/2] selinux-testsuite: Infiniband pkey tests
Date: Tue, 30 May 2017 16:28:56 +0000
Message-ID: <VI1PR05MB1678326A96A93EC6431F6F50C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
 <1495635523-84017-2-git-send-email-danielj@mellanox.com>
 <1495742176.22368.8.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/25/2017 2:52 PM, Stephen Smalley wrote:
> On Wed, 2017-05-24 at 17:18 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> +corenet_ib_pkey(test_ibpkey_t)
>> +corenet_ib_access_unlabeled_pkeys(test_ibpkey_access_t)
> This will break the build on current Fedora and RHEL.
> So, you can either conditionalize inclusion of test_ibpkey.te in the
> Makefile (see other examples already there) so that it is omitted
> entirely if refpolicy lacks the requisite support, or wrap these
> interface calls with suitable ifdefs, e.g.
> ifdef(`corenet_ib_pkey', `
> corenet_ib_pkey(test_ibpkey_t)
> ')
> ...
>
> Probably the latter is best so that we get at least some build testing.

Done, with ifdefs.

>> +
>>
>> +TARGETS=create_modify_qp
>> +
>> +LDLIBS+= -libverbs
> This is a new build dependency (libibverbs-devel), which should be
> listed in the README.

Done

>
>> +int init_ib_rsrc(char* deviceName)
>> +{
>> +	int                 ndev = 0;
>> +	struct ibv_device  **dlist = ibv_get_device_list(&ndev);
>> +	struct ibv_device  *device = NULL;;
>> +	struct ibv_srq_init_attr srqiattr;
>> +	struct ibv_qp_init_attr qpiattr;
>> +	int i;
>> +
>> +	if (!ndev)
>> +	{
> Can you run these test programs through
> astyle --options=none --lineend=linux --mode=c --style=linux --
> indent=force-tab=8 --indent-preprocessor --indent-col1-comments --min-
> conditional-indent=0 --max-instatement-indent=80 --pad-oper --align-
> pointer=name --align-reference=name --max-code-length=80 --break-after-
> logical

Done.
