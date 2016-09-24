MIME-Version: 1.0
In-Reply-To: <57E5D285.5080709@quarksecurity.com>
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
 <57E5D285.5080709@quarksecurity.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 23 Sep 2016 18:39:23 -0700
Message-ID: <CAFftDdrmbjJZXd7hQCAgCA5fqLWhSW62YfvY8OMpJyo+DCOwMw@mail.gmail.com>
Subject: Re: Libsepol Mac Build Errors
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 23, 2016 at 6:10 PM, Joshua Brindle
<brindle@quarksecurity.com> wrote:
> william.c.roberts@intel.com wrote:
>>
>> The patches below fix some warnings reported by Josh Brindle on
>> the libsepol build.
>>
>> Josh can you test these and see if those three warning go away
>> and give an ack if they are ok?
>>
>> [PATCH 1/3] libsepol: fix unused variable 'size' on mac build
>> [PATCH 2/3] libsepol: fix unused variable 'len' on mac build
>> [PATCH 3/3] libsepol: fix unitialized variable 'nread' on mac build
>
>
> That fixed the build errors. The linker does not like the soname, version
> map, etc stuff though so I still don't get a sofile out.

FYI I managed to set up macincloud today, so I have an el capitain instance
with 8 cores and 16GB ram I can use for testing. I'm currently syncing the
source tree, so ill be able to test on mac.
