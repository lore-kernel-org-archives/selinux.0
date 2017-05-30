From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "paul@paul-moore.com" <paul@paul-moore.com>
Subject: Re: [PATCH v2 2/2] selinux-testsuite: Infiniband endport tests
Date: Tue, 30 May 2017 17:53:29 +0000
Message-ID: <VI1PR05MB167813755EB88E78851D9CC5C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1496162091-129822-1-git-send-email-danielj@mellanox.com>
 <1496162091-129822-3-git-send-email-danielj@mellanox.com>
 <1496164182.2164.12.camel@tycho.nsa.gov>
 <VI1PR05MB1678A4215E4D0406273B87B9C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <1496166732.2164.18.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/30/2017 12:48 PM, Stephen Smalley wrote:
> On Tue, 2017-05-30 at 17:40 +0000, Daniel Jurgens wrote:
>> On 5/30/2017 12:05 PM, Stephen Smalley wrote:
>>> On Tue, 2017-05-30 at 19:34 +0300, Dan Jurgens wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> diff --git a/tests/infiniband_pkey/test
>>>> b/tests/infiniband_pkey/test
>>>> old mode 100644
>>>> new mode 100755
>>> Not a big deal, but it seems odd that this mode change wasn't just
>>> squashed into the first patch.
>>>
>>> Otherwise, it looks ok to me, but I don't have hardware to test it
>>> on.
>>> Did you confirm that when you run the tests, you get the expected
>>> avc
>>> denials in the audit logs?  Also, did you confirm that if you
>>> manually
>>> run the tests in permissive mode, that the tests you expect to fail
>>> do
>>> so (and the rest do not)?
>>>
>>>
>> I'm not sure what happened with the mode there.  I didn't change it
>> manually.  I can clean it up if you want.
> Looks like tests/Makefile does a chmod +x */test.
> I wouldn't bother re-spinning unless Paul has other comments.
>
>> Regarding testing the test. Yes, I did make sure they fail as
>> expected when in permissive mode.  Also I changed setting in the
>> configuration files to make sure all cases fail when they should
>> where that was possible.
> And avc: denied messages are as expected?
>
Yes, here's a sample:

type=AVC msg=audit(1496161222.307:1584): avc:  denied  { manage_subnet } for  pid=21976 comm="smpquery" device=mlx5_2 port_num=1 scontext=unconfined_u:unconfined_r:test_ibendport_manage_subnet_t:s0-s0:c0.c1023 tcontext=system_u:object_r:unlabeled_t:s0 tclass=infiniband_endport permissive=0
