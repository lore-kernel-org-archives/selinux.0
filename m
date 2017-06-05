Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v566BTG5008758
 for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2017 02:11:29 -0400
Received: by mail-lf0-f65.google.com with SMTP id v20so7612019lfa.2
 for <selinux@tycho.nsa.gov>; Mon, 05 Jun 2017 15:13:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496166732.2164.18.camel@tycho.nsa.gov>
References: <1496162091-129822-1-git-send-email-danielj@mellanox.com>
 <1496162091-129822-3-git-send-email-danielj@mellanox.com>
 <1496164182.2164.12.camel@tycho.nsa.gov>
 <VI1PR05MB1678A4215E4D0406273B87B9C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <1496166732.2164.18.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Jun 2017 18:13:29 -0400
Message-ID: <CAHC9VhThFfXpJeMn+3bsBwpnxNmLcRyOLjF68-UXB6uiVPYyWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux-testsuite: Infiniband endport tests
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel Jurgens <danielj@mellanox.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 30, 2017 at 1:52 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-05-30 at 17:40 +0000, Daniel Jurgens wrote:
>> On 5/30/2017 12:05 PM, Stephen Smalley wrote:
>> > On Tue, 2017-05-30 at 19:34 +0300, Dan Jurgens wrote:
>> > > From: Daniel Jurgens <danielj@mellanox.com>
>> > >
>> > > New tests for Infiniband endports. Most users do not have
>> > > infiniband
>> > > hardware, and if they do the device names can vary.  There is a
>> > > configuration file for enabling the tests and setting environment
>> > > specific configurations.  If the tests are disabled they always
>> > > show
>> > > as
>> > > passed.
>> > >
>> > > A special test application was unnecessary, a standard diagnostic
>> > > application is used instead.  This required a change to the make
>> > > file
>> > > to avoid trying to build an application in the new subdir.
>> > >
>> > > Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

...

> I wouldn't bother re-spinning unless Paul has other comments.

Nothing worthy of a respin.

Daniel, have you run these tests against the kernel, userspace, and
policy code that has been merged?  It would be nice to have a sanity
check that something didn't break while we were merging everything.

[SIDE NOTE: This afternoon I noticed what I think may be a problem
with my COPR kernel builds that affects the test suite, so YMMY at the
moment.]

-- 
paul moore
www.paul-moore.com
