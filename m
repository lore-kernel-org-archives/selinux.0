MIME-Version: 1.0
In-Reply-To: <0e982db1-15d4-8f84-6606-d22b8d9abd80@tycho.nsa.gov>
References: <1474923189-26431-1-git-send-email-william.c.roberts@intel.com>
 <85b69cd8-e882-e68a-235f-ee444b3f0813@tycho.nsa.gov>
 <CAFftDdqUs82JM2JCxbFFxre62hc-PNM7rYoKAMrxMfcUiuheQA@mail.gmail.com>
 <0e982db1-15d4-8f84-6606-d22b8d9abd80@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 27 Sep 2016 12:13:58 -0700
Message-ID: <CAFftDdqJWc4oVsOHarwZr+76-mt5O_1A+W0GWFb_jBjf=0apjA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add ANDROID_HOST=y build option
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
>>> Don't you actually want to also pick up utils/sefcontext_compile?
>>> That is built and used on the build host.  And I'm not sure why we'd
>>> drop the other SUBDIRS.
>>
>> You'll start running into linking issues if things that use
>> libselinux, use something not
>> in the build host IIRC. Perhaps, if that is the issue, we just limit
>> it to sefcontext_compile.
>
> Sure, the utils/Makefile can remove entries the same way it already does
> for DISABLE_*.

Well actually, that means every-time their is a new file added, the
Makefile needs to be modified,
I was trying to avoid that. Also, the remove list is super long, so it
looks pretty unwieldy.

<snip>
