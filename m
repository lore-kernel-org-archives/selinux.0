MIME-Version: 1.0
In-Reply-To: <CAFftDdqMNUG256Y_0EnkPog8eabHsL+zqAmSSj_2ztPuBZ2oGA@mail.gmail.com>
References: <CAFftDdoa-iO3E62FSefdnARHGVzLE4znzaFfSd2Q=9bhdG3=eQ@mail.gmail.com>
 <1507841294.30307.4.camel@tycho.nsa.gov>
 <CAFftDdpFtE3fDPJxYTb5Q7Ooa3UpEHAHzRJYee60a_QsNxngiw@mail.gmail.com>
 <CAJfZ7=n7j6kbxd2SGW3FjxMr=EZSiYdttG9mfotUt0F3UFEdgQ@mail.gmail.com>
 <CAFftDdqD-tCZrSu2yB37p0BrtKu7avKes_W5OLmEGCO9ofWt0A@mail.gmail.com>
 <1508269837.21073.4.camel@tycho.nsa.gov>
 <CAFftDdqfBkaomb3SpcEv0vt=a1riHzYQEfzPY5W8OiSEmHrYSw@mail.gmail.com>
 <1508861159.22356.4.camel@tycho.nsa.gov>
 <CAFftDdoQ8HDtnSp9aakXFH4VV2kUMtJ6pShau99=YXpiYypgCQ@mail.gmail.com>
 <1508875836.22356.6.camel@tycho.nsa.gov>
 <CAFftDdqMNUG256Y_0EnkPog8eabHsL+zqAmSSj_2ztPuBZ2oGA@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 24 Oct 2017 23:00:29 +0200
Message-ID: <CAJfZ7=kpJj=cz4UHZmd2gjuxOWHXsg0obg6btk6BMQ_VrVXpsw@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: travis CI
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 24, 2017 at 10:20 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Oct 24, 2017 13:05, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On Tue, 2017-10-24 at 09:26 -0700, William Roberts wrote:
>> Error 52, which if it lines up with what I am reading is
>> CURLE_GOT_NOTHING
>> https://curl.haxx.se/libcurl/c/libcurl-errors.html
>>
>> That url/command combo seems valid, likely a transient issue with
>> github.
>
> I restarted the job, and it failed again in the same way (but on
> different cases).  Then I restarted it a third time, and this time it
> ran to completion.  This seems problematic; we likely need to
> reconsider any use of curl from the travis.yml file.
>
>
> Weird. I wget things from sourceforge all the time. The only time I have
> issues is when sourceforge is down.
>
>> On Tue, Oct 24, 2017 at 9:05 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
[[...]]
>> > Our .travis.yml seems to yield unstable results,
>> > https://travis-ci.org/SELinuxProject/selinux/jobs/292128434
>> >
>> > Don't know if it would help to instead download a refpolicy release
>> > and
>> > extract it, or if this is just transient.
>> >

It looks like transient networking issues between Travis-CI and
Github. A possible fix would consists in using the Ubuntu package
which provides refpolicy files: selinux-policy-dev. This however
introduces the drawback that the package pulls in Ubuntu's version of
checkpolicy, policycoreutils, libsepol... which may introduce
incorrect test success if they happen to be used instead of the
programs from the tested build. So I am not convinced by this.

I am wondering whether using curl's --retry option would help to work
around the networking issues which occurred. I am testing this in my
"curl-retry" branch on Github [1] and will submit a patch if you think
this may work.

Nicolas

[1] https://github.com/fishilico/selinux/commits/curl-retry
