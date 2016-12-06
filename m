Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB6NCtda024699
 for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2016 18:12:55 -0500
Received: by mail-ua0-f193.google.com with SMTP id 12so37207371uas.3
 for <selinux@tycho.nsa.gov>; Tue, 06 Dec 2016 15:12:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bced50a2-5d74-ec8b-a9c0-f8eaba06b170@tycho.nsa.gov>
References: <20161205161403.9253-1-richard_c_haines@btinternet.com>
 <bced50a2-5d74-ec8b-a9c0-f8eaba06b170@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Dec 2016 18:12:48 -0500
Message-ID: <CAHC9VhRW1gDHn+3Xqa4h=NdhPq9e5jU9guiyX0hEAbAWoX6k2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add IPv6 client/server support
 plus tests
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 5, 2016 at 1:07 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/05/2016 11:14 AM, Richard Haines wrote:
>> Split the Netlabel tests into two, one for full labeling and the
>> other for plain CIPSO4.
>>
>> Added comments to tests where required to explain pass/fail as
>> there is no support for retrieving UDP peer labels on IPv6 stack.
>
> Thanks, this looks good to me except for the tests that are "expected to
> fail", i.e. the SCM_SECURITY for IPv6 test and the UDP MLS/MCS
> constraint denial.  I don't think I'd include those two, as I wouldn't
> want to view a subsequent change in either behavior as a regression.
> cc'd Paul for his opinion

I agree with Stephen about the "expected to fail" tests.  While I'm
generally not a fan of adding dead/commented code, I imagine we could
implement the tests as if SCM_SECURITY/IPv6 was functional and just
leave that test disabled.  Either way, drop or leave disabled, we
should probably make a note in the associated GitHub kernel issue
tracker so we remember to add/enable the tests once we've fixed the
kernel support.

 * https://github.com/SELinuxProject/selinux-kernel/issues/24

Oh, one more thing regarding "CIPSO4" ... if we want to be really
pedantic, it is just CIPSO, or if you want to stick with our
convention in NetLabel/LSM/SELinux it would be "CIPSOv4".  The
references you see to "cipsov4" (note the "v") in much of the code are
to signify this is CIPSO for IPv4 as specified in FIPS-188 and the
defunct IETF draft.  While CIPSO was never formally standardized for
IPv6, Solaris did support a variation of CIPSO for IPv6 and in the
early days of our NetLabel/CIPSO implementation it was unclear how we
were going to interoperate over IPv6 (this was before
CALIPSO/RFC-5570) and I wanted to make sure we would be able to
support two different CIPSO protocols, one for IPv4 and one for IPv6,
hence the "v4" suffix.  Needless to say, now that we have the CALIPSO
specification we have no need for a "CIPSOv6", but the old "v4" naming
legacy remains.

-- 
paul moore
www.paul-moore.com
