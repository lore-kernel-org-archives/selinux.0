MIME-Version: 1.0
In-Reply-To: <b6e2eb23-40b3-aad2-dcd0-f7342ffa6018@tycho.nsa.gov>
References: <1474923189-26431-1-git-send-email-william.c.roberts@intel.com>
 <CAFftDdrmSvjCJZMESYP3hzjwoT04G9iH7K7MryJxA2MaT5ye-g@mail.gmail.com>
 <b6e2eb23-40b3-aad2-dcd0-f7342ffa6018@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 27 Sep 2016 08:09:22 -0700
Message-ID: <CAFftDdrwA9E+h2zgrB4ndqDi6v9ya3K7r=Jf3EbZ5HdjwRpVOQ@mail.gmail.com>
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

On Tue, Sep 27, 2016 at 7:03 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/26/2016 04:55 PM, William Roberts wrote:
>> On Mon, Sep 26, 2016 at 1:53 PM,  <william.c.roberts@intel.com> wrote:
>>> From: William Roberts <william.c.roberts@intel.com>
>>>
>>> To build the selinux host configuration, specify
>>> ANDROID_HOST=y on the Make command line.
>>>
>>> eg)
>>> make ANDROID_HOST=y
>>>
>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>> ---
>>>  libselinux/Makefile     |  8 +++++++-
>>>  libselinux/src/Makefile | 50 +++++++++++++++++++++++++++++++++----------------
>>>  2 files changed, 41 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/libselinux/Makefile b/libselinux/Makefile
>>> index 5a8d42c..50ae009 100644
>>> --- a/libselinux/Makefile
>>> +++ b/libselinux/Makefile
>>> @@ -10,6 +10,12 @@ ifeq ($(EMBEDDED),y)
>>>         override DISABLE_RPM=y
>>>         override DISABLE_BOOL=y
>>>  endif
>>> +ifeq ($(ANDROID_HOST),y)
>>> +       override DISABLE_SETRANS=y
>>> +       EMFLAGS+= -DDISABLE_RPM -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
>>
>> argghhh .. missing too much, drop DISABLE_RPM... copy+paste+edit fail.
>> Ill let v2 sit for a day, and aggregate other
>> feedback for v3. Sorry for the noise.
>
> Sorry, why can't you override DISABLE_RPM=y?
>
It's superfluous because it;s not used in the source files built for
ANDROID_HOST, and
it doesn't match the build recipe for Android. So if the goal would be
to provide a quick
flag to test the build against, it wouldn't meet that requirement.
