Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9NGbGxW018566
 for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2017 12:37:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3yLMPq5m6qz1wyL2
 for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2017 16:32:31 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3yLMPm5T3nz21bww
 for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2017 16:32:28 +0000 (UTC)
Received: by mail-io0-f176.google.com with SMTP id h70so20721503ioi.4
 for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2017 09:27:58 -0700 (PDT)
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Daniel Cashman <dcashman@google.com>
References: <20171017163328.117702-1-dcashman@android.com>
 <1508423206.17050.4.camel@tycho.nsa.gov>
 <CAFftDdpVWRO2oKH=OdAMwipnMQkOhPrE3HLxxt1BdXEBG2L1OA@mail.gmail.com>
 <1508437655.17050.8.camel@tycho.nsa.gov>
 <1508442389.17050.10.camel@tycho.nsa.gov>
 <CAJfZ7=m2Qd2DAk0UYWR=iLQ3tjaNHtDzzZMnv6RFc6Nx4Fs-0A@mail.gmail.com>
 <CAFftDdpak=d6YZOStgPcHu0eiwBo7nUc4i_WLJM9wK4bBw0r3Q@mail.gmail.com>
 <458cbe6f-9747-7b20-75d7-52c96595ea21@android.com>
 <CAFftDdp=GJg0K_g3OJtvXqmrJQHEtm4_524c59NyY5iO=76+HQ@mail.gmail.com>
 <CAFftDdqPJL-hBu32JaGU-TAt9o4mWyF34v6L2EjeYMs6KPTJrA@mail.gmail.com>
From: Dan Cashman <dcashman@android.com>
Message-ID: <b1e464a2-6c88-e3e9-18ae-c66b2d35d0a8@android.com>
Date: Mon, 23 Oct 2017 09:27:56 -0700
MIME-Version: 1.0
In-Reply-To: <CAFftDdqPJL-hBu32JaGU-TAt9o4mWyF34v6L2EjeYMs6KPTJrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3] selinux: libselinux: Enable multiple input
 files to selabel_open.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/23/2017 09:20 AM, William Roberts wrote:
> On Mon, Oct 23, 2017 at 9:12 AM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> On Mon, Oct 23, 2017 at 8:57 AM, Dan Cashman <dcashman@android.com> wrote:
>>> On 10/20/2017 09:09 AM, William Roberts wrote:
>>>>
>>>> On Thu, Oct 19, 2017 at 3:12 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
>>>> wrote:
>>>>>
>>>>> On Thu, Oct 19, 2017 at 9:46 PM, Stephen Smalley <sds@tycho.nsa.gov>
>>>>> wrote:
>>>>>>
>>>>>> On Thu, 2017-10-19 at 14:27 -0400, Stephen Smalley wrote:
>>>>>>>
>>>>>>> On Thu, 2017-10-19 at 09:25 -0700, William Roberts wrote:
>>>>>>>>
>>>>>>>> On Thu, Oct 19, 2017 at 7:26 AM, Stephen Smalley <sds@tycho.nsa.gov
>>>>>>>>>
>>>>>>>>>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, 2017-10-17 at 09:33 -0700, Daniel Cashman wrote:
>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>> diff --git a/libselinux/src/label_file.c
>>>>>>>>>> b/libselinux/src/label_file.c
>>>>>>>>>> index 560d8c3d..b3b36bc2 100644
>>>>>>>>>> --- a/libselinux/src/label_file.c
>>>>>>>>>> +++ b/libselinux/src/label_file.c
>>>>>>>>>> @@ -709,28 +709,61 @@ static int init(struct selabel_handle
>>>>>>>>>> *rec,
>>>>>>>>>> const struct selinux_opt *opts,
>>>>>>>>>>                 unsigned n)
>>>>>>>>>>    {
>>>>>>>>>>         struct saved_data *data = (struct saved_data *)rec->data;
>>>>>>>>>> -     const char *path = NULL;
>>>>>>>>>> +     size_t num_paths = 0;
>>>>>>>>>> +     char **path = NULL;
>>>>>>>>>>         const char *prefix = NULL;
>>>>>>>>>> -     int status = -1, baseonly = 0;
>>>>>>>>>> +     int status = -1;
>>>>>>>>>> +     size_t i;
>>>>>>>>>> +     bool baseonly = false;
>>>>>>>>>> +     bool path_provided;
>>>>>>>>>>
>>>>>>>>>>         /* Process arguments */
>>>>>>>>>> -     while (n--)
>>>>>>>>>> -             switch(opts[n].type) {
>>>>>>>>>> +     i = n;
>>>>>>>>>> +     while (i--)
>>>>>>>>>> +             switch(opts[i].type) {
>>>>>>>>>>                 case SELABEL_OPT_PATH:
>>>>>>>>>> -                     path = opts[n].value;
>>>>>>>>>> +                     num_paths++;
>>>>>>>>>>                         break;
>>>>>>>>>>                 case SELABEL_OPT_SUBSET:
>>>>>>>>>> -                     prefix = opts[n].value;
>>>>>>>>>> +                     prefix = opts[i].value;
>>>>>>>>>>                         break;
>>>>>>>>>>                 case SELABEL_OPT_BASEONLY:
>>>>>>>>>> -                     baseonly = !!opts[n].value;
>>>>>>>>>> +                     baseonly = !!opts[i].value;
>>>>>>>>>>                         break;
>>>>>>>>>>                 }
>>>>>>>>>>
>>>>>>>>>> +     if (!num_paths) {
>>>>>>>>>> +             num_paths = 1;
>>>>>>>>>> +             path_provided = false;
>>>>>>>>>> +     } else {
>>>>>>>>>> +             path_provided = true;
>>>>>>>>>> +     }
>>>>>>>>>> +
>>>>>>>>>> +     path = calloc(num_paths, sizeof(*path));
>>>>>>>>>> +     if (path == NULL) {
>>>>>>>>>> +             goto finish;
>>>>>>>>>> +     }
>>>>>>>>>> +     rec->spec_files = path;
>>>>>>>>>> +     rec->spec_files_len = num_paths;
>>>>>>>>>> +
>>>>>>>>>> +     if (path_provided) {
>>>>>>>>>> +             for (i = 0; i < n; i++) {
>>>>>>>>>> +                     switch(opts[i].type) {
>>>>>>>>>> +                     case SELABEL_OPT_PATH:
>>>>>>>>>> +                             *path = strdup(opts[i].value);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Perhaps surprisingly, opts[i].value can be NULL here and some
>>>>>>>>> callers
>>>>>>>>> rely on that.  After applying your patch, coreutils,
>>>>>>>>> selabel_lookup,
>>>>>>>>> and other userspace programs all seg fault as a result.  The use
>>>>>>>>> case
>>>>>>>>> is programs where the selinux_opt structure is declared with a
>>>>>>>>> SELABEL_OPT_PATH entry whose value is subsequently filled in, and
>>>>>>>>> left
>>>>>>>>> NULL if they want to use the default path for file_contexts.
>>>>>>>>> Internally, libselinux also does this from the
>>>>>>>>> matchpathcon_init_prefix() function.
>>>>>>>>>
>>>>>>>>> In any event, you need to handle this case.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Poor Stephen has turned into your test bot :-)
>>>>>>>>
>>>>>>>> Does any of the test suite exercise this? Maybe make a PR
>>>>>>>> on github first to get Travis to test these?
>>>>>>>
>>>>>>>
>>>>>>> Unfortunately the travis-ci tests don't catch this one currently.
>>>>>>>
>>>>>>>> Stephen can you share with how your testing this so Dan can follow
>>>>>>>> suit?
>>>>>>>
>>>>>>>
>>>>>>> In this case, you could build and install to a private directory as
>>>>>>> per
>>>>>>> the README, then set your LD_LIBRARY_PATH=~/obj/lib or whatever and
>>>>>>> run
>>>>>>> selabel_lookup.
>>>>>>
>>>>>>
>>>>>> Ala:
>>>>>> $ make DESTDIR=~/obj install
>>>>>> $ LD_LIBRARY_PATH=~/obj/lib selabel_lookup -b file -k /etc
>>>>>> Segmentation fault (core dumped)
>>>>>>
>>>>>> BTW, I guess this exposes another issue with the patch; there is no
>>>>>> support for exercising the new code included with it, e.g. an extension
>>>>>> to utils/selabel_lookup.c to permit specifying multiple input files via
>>>>>> multiple -f options.  Otherwise, we have no upstream way of testing it.
>>>>>
>>>>>
>>>>> For selabel_lookup, it would be possible to write a test script (or a
>>>>> CUnit-based test program like libsepol and libsemanage have) which
>>>>> does not need an SELinux policy to be installed on the system, thanks
>>>>> to option -f.
>>>>> Nevertheless other parts of libselinux (and programs) can not
>>>>> currently be tested on a system without SELinux, as /etc/selinux and
>>>>> /sys/fs/selinux are needed. If we want to automatize the testing of
>>>>> such parts in a CI like Travis-CI, I suppose we would need to run a
>>>>> virtual machine with its own filesystem, a kernel with SELinux
>>>>> enabled, and some programs like coreutils compiled with the tested
>>>>> version of libselinux/libsepol/... As implementing such an idea may
>>>>> take quite a long time, would there be simpler ways to perform
>>>>> automatic testing of libselinux? Perhaps using another continuous
>>>>> integration system?
>>
>> We have travis up and running, but it's not excising this code path. Any PR
>> submitted to the selinux project on githib has travis "test" it via
>> the .travis.yml
>> file in the root of the tree.
>>
>> If you have a fork of selinux on github you could set up travis to run it. It's
>> pretty simple:
>> https://docs.travis-ci.com/user/getting-started/
>>
>> You could also just submit a PR for testing and publish a patch to the list
>> when you're ready for review...
> 
> My response might not be very clear, there are three things you need to do here:
> 1. Add a test as outlined previously in this thread
> 
> 2. Test your change:
>      Test your change with travis (optional):
>        1. Setting it up on your fork of selinux project on github (hardest)
>        2. Submitting a PR to the selinux github project (easiest)
> 
>       If its part of the test suite, you can run that by hand....
> 
> 3. Submit patch to mailing list for review.

Ok, I'll look into that a bit when I get around to attempting v4. 
Option 2 should suffice.
> 
> I know you tested all these on Android, but I think we need it as part of the
> test framework.,,
> 
Yes, this patch has clearly illustrated that android testing is 
insufficient for upstream use-cases.  That's why I'd like to eventually 
have the upstream tests running as part of android builds and also why 
I'm hoping to establish some sort of upstreaming workflow beyond "fire 
away and let sds@ catch issues."

Thanks!
Dan
>>
>>>>
>>>>
>>>> The free travis just provides an Ubuntu image.... if you use sudo: true
>>>> you get a full VM if you don't, you get a docker container.
>>>>
>>>> With that said, we could try to hack up the VM image to support what we
>>>> need,
>>>> or perhaps we can use CMockaand mock out the filesystem calls to
>>>> proc/selinuxfs
>>>> with something that replicates it.(not sure if that's how mock objects
>>>> work)
>>>>
>>>>
>>>>>
>>>>> Cheers,
>>>>> Nicolas
>>>>>
>>>>
>>>
>>> Is there selinux-specific travis documentation, or a pointer to appropriate
>>> travis documetnation in general?  I'd obviously like to cut down on bad
>>> patch submissions, so having a test suite batter a patch before wasting
>>> reveiwer time would be great.  We could/should probably add this to the
>>> README as well if a proper standard workflow is developed.
>>>
>>> Thanks,
>>> Dan
>>>
> 
> 
> 
