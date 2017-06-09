Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v59Ep3ed024002
 for <selinux@tycho.nsa.gov>; Fri, 9 Jun 2017 10:51:03 -0400
Received: by mail-lf0-f65.google.com with SMTP id v20so5301303lfa.2
 for <selinux@tycho.nsa.gov>; Fri, 09 Jun 2017 07:50:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DB6PR0501MB28566D9AD30D2586E1E631E0C4CE0@DB6PR0501MB2856.eurprd05.prod.outlook.com>
References: <1496162091-129822-1-git-send-email-danielj@mellanox.com>
 <1496162091-129822-3-git-send-email-danielj@mellanox.com>
 <1496164182.2164.12.camel@tycho.nsa.gov>
 <VI1PR05MB1678A4215E4D0406273B87B9C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <1496166732.2164.18.camel@tycho.nsa.gov>
 <CAHC9VhThFfXpJeMn+3bsBwpnxNmLcRyOLjF68-UXB6uiVPYyWQ@mail.gmail.com>
 <DB6PR0501MB28569A5654DE040C7AE9EB47C4CA0@DB6PR0501MB2856.eurprd05.prod.outlook.com>
 <DB6PR0501MB28566D9AD30D2586E1E631E0C4CE0@DB6PR0501MB2856.eurprd05.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jun 2017 10:50:53 -0400
Message-ID: <CAHC9VhQW3pNsic=mKfQsGj7qAoChO8tO2cW6tYWGp4C1Nk70ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux-testsuite: Infiniband endport tests
To: Daniel Jurgens <danielj@mellanox.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 9, 2017 at 10:44 AM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 6/5/2017 5:34 PM, Daniel Jurgens wrote:
>> On 6/5/2017 5:13 PM, Paul Moore wrote:
>>> On Tue, May 30, 2017 at 1:52 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On Tue, 2017-05-30 at 17:40 +0000, Daniel Jurgens wrote:
>>>>> On 5/30/2017 12:05 PM, Stephen Smalley wrote:
>>>>>> On Tue, 2017-05-30 at 19:34 +0300, Dan Jurgens wrote:
>>>>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>>>>
>>>>>>> New tests for Infiniband endports. Most users do not have
>>>>>>> infiniband
>>>>>>> hardware, and if they do the device names can vary.  There is a
>>>>>>> configuration file for enabling the tests and setting environment
>>>>>>> specific configurations.  If the tests are disabled they always
>>>>>>> show
>>>>>>> as
>>>>>>> passed.
>>>>>>>
>>>>>>> A special test application was unnecessary, a standard diagnostic
>>>>>>> application is used instead.  This required a change to the make
>>>>>>> file
>>>>>>> to avoid trying to build an application in the new subdir.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>> ...
>>>
>>>> I wouldn't bother re-spinning unless Paul has other comments.
>>> Nothing worthy of a respin.
>>>
>>> Daniel, have you run these tests against the kernel, userspace, and
>>> policy code that has been merged?  It would be nice to have a sanity
>>> check that something didn't break while we were merging everything.
>>>
>>> [SIDE NOTE: This afternoon I noticed what I think may be a problem
>>> with my COPR kernel builds that affects the test suite, so YMMY at the
>>> moment.]
>>>
>> I ran them against the merged kernel and selinux code.  But I used the same policy RPMs that I had been using, I didn't try to rebuild the RPMs against the new refpolicy.
>>
> Are these tests good to go? I haven't gotten any additional comments since v2.

Yes, my apologies for not getting back to you sooner; I had hoped to
talk to some of the IB folks at Red Hat to see if they could verify
everything (or at least get access to a IB system so I could verify
it) but I got wrapped in a few audit issues this week and didn't get
to it.

I'll merge these patches later this afternoon.

-- 
paul moore
www.paul-moore.com
