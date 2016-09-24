Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8O1gj7I001570
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 21:42:45 -0400
Received: by mail-qk0-f169.google.com with SMTP id g67so61685278qkd.0
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 18:42:44 -0700 (PDT)
Message-ID: <57E5DA11.3020204@quarksecurity.com>
Date: Fri, 23 Sep 2016 21:42:41 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Libsepol Mac Build Errors
References: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
 <57E5D285.5080709@quarksecurity.com>
 <CAFftDdrmbjJZXd7hQCAgCA5fqLWhSW62YfvY8OMpJyo+DCOwMw@mail.gmail.com>
In-Reply-To: <CAFftDdrmbjJZXd7hQCAgCA5fqLWhSW62YfvY8OMpJyo+DCOwMw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
> On Fri, Sep 23, 2016 at 6:10 PM, Joshua Brindle
> <brindle@quarksecurity.com>  wrote:
>> william.c.roberts@intel.com wrote:
>>> The patches below fix some warnings reported by Josh Brindle on
>>> the libsepol build.
>>>
>>> Josh can you test these and see if those three warning go away
>>> and give an ack if they are ok?
>>>
>>> [PATCH 1/3] libsepol: fix unused variable 'size' on mac build
>>> [PATCH 2/3] libsepol: fix unused variable 'len' on mac build
>>> [PATCH 3/3] libsepol: fix unitialized variable 'nread' on mac build
>>
>> That fixed the build errors. The linker does not like the soname, version
>> map, etc stuff though so I still don't get a sofile out.
>
> FYI I managed to set up macincloud today, so I have an el capitain instance
> with 8 cores and 16GB ram I can use for testing. I'm currently syncing the
> source tree, so ill be able to test on mac.

Well that is neat.

FWIW I have an Android tree but I was building your selinux repo outside 
of Android. I personally keep around darwin libsepol.so files built out 
of Android for use with setools 4 since it works on Mac's now so I 
appreciate any work to make it work better on Mac :)
