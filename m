MIME-Version: 1.0
In-Reply-To: <CAJfZ7=m2Qd2DAk0UYWR=iLQ3tjaNHtDzzZMnv6RFc6Nx4Fs-0A@mail.gmail.com>
References: <20171017163328.117702-1-dcashman@android.com>
 <1508423206.17050.4.camel@tycho.nsa.gov>
 <CAFftDdpVWRO2oKH=OdAMwipnMQkOhPrE3HLxxt1BdXEBG2L1OA@mail.gmail.com>
 <1508437655.17050.8.camel@tycho.nsa.gov>
 <1508442389.17050.10.camel@tycho.nsa.gov>
 <CAJfZ7=m2Qd2DAk0UYWR=iLQ3tjaNHtDzzZMnv6RFc6Nx4Fs-0A@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 20 Oct 2017 09:09:14 -0700
Message-ID: <CAFftDdpak=d6YZOStgPcHu0eiwBo7nUc4i_WLJM9wK4bBw0r3Q@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel Cashman <dcashman@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3] selinux: libselinux: Enable multiple input
 files to selabel_open.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 19, 2017 at 3:12 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Thu, Oct 19, 2017 at 9:46 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On Thu, 2017-10-19 at 14:27 -0400, Stephen Smalley wrote:
>>> On Thu, 2017-10-19 at 09:25 -0700, William Roberts wrote:
>>> > On Thu, Oct 19, 2017 at 7:26 AM, Stephen Smalley <sds@tycho.nsa.gov
>>> > >
>>> > wrote:
>>> > > On Tue, 2017-10-17 at 09:33 -0700, Daniel Cashman wrote:
>>> > > > [...]
>>> > > > diff --git a/libselinux/src/label_file.c
>>> > > > b/libselinux/src/label_file.c
>>> > > > index 560d8c3d..b3b36bc2 100644
>>> > > > --- a/libselinux/src/label_file.c
>>> > > > +++ b/libselinux/src/label_file.c
>>> > > > @@ -709,28 +709,61 @@ static int init(struct selabel_handle
>>> > > > *rec,
>>> > > > const struct selinux_opt *opts,
>>> > > >               unsigned n)
>>> > > >  {
>>> > > >       struct saved_data *data = (struct saved_data *)rec->data;
>>> > > > -     const char *path = NULL;
>>> > > > +     size_t num_paths = 0;
>>> > > > +     char **path = NULL;
>>> > > >       const char *prefix = NULL;
>>> > > > -     int status = -1, baseonly = 0;
>>> > > > +     int status = -1;
>>> > > > +     size_t i;
>>> > > > +     bool baseonly = false;
>>> > > > +     bool path_provided;
>>> > > >
>>> > > >       /* Process arguments */
>>> > > > -     while (n--)
>>> > > > -             switch(opts[n].type) {
>>> > > > +     i = n;
>>> > > > +     while (i--)
>>> > > > +             switch(opts[i].type) {
>>> > > >               case SELABEL_OPT_PATH:
>>> > > > -                     path = opts[n].value;
>>> > > > +                     num_paths++;
>>> > > >                       break;
>>> > > >               case SELABEL_OPT_SUBSET:
>>> > > > -                     prefix = opts[n].value;
>>> > > > +                     prefix = opts[i].value;
>>> > > >                       break;
>>> > > >               case SELABEL_OPT_BASEONLY:
>>> > > > -                     baseonly = !!opts[n].value;
>>> > > > +                     baseonly = !!opts[i].value;
>>> > > >                       break;
>>> > > >               }
>>> > > >
>>> > > > +     if (!num_paths) {
>>> > > > +             num_paths = 1;
>>> > > > +             path_provided = false;
>>> > > > +     } else {
>>> > > > +             path_provided = true;
>>> > > > +     }
>>> > > > +
>>> > > > +     path = calloc(num_paths, sizeof(*path));
>>> > > > +     if (path == NULL) {
>>> > > > +             goto finish;
>>> > > > +     }
>>> > > > +     rec->spec_files = path;
>>> > > > +     rec->spec_files_len = num_paths;
>>> > > > +
>>> > > > +     if (path_provided) {
>>> > > > +             for (i = 0; i < n; i++) {
>>> > > > +                     switch(opts[i].type) {
>>> > > > +                     case SELABEL_OPT_PATH:
>>> > > > +                             *path = strdup(opts[i].value);
>>> > >
>>> > > Perhaps surprisingly, opts[i].value can be NULL here and some
>>> > > callers
>>> > > rely on that.  After applying your patch, coreutils,
>>> > > selabel_lookup,
>>> > > and other userspace programs all seg fault as a result.  The use
>>> > > case
>>> > > is programs where the selinux_opt structure is declared with a
>>> > > SELABEL_OPT_PATH entry whose value is subsequently filled in, and
>>> > > left
>>> > > NULL if they want to use the default path for file_contexts.
>>> > > Internally, libselinux also does this from the
>>> > > matchpathcon_init_prefix() function.
>>> > >
>>> > > In any event, you need to handle this case.
>>> > >
>>> >
>>> > Poor Stephen has turned into your test bot :-)
>>> >
>>> > Does any of the test suite exercise this? Maybe make a PR
>>> > on github first to get Travis to test these?
>>>
>>> Unfortunately the travis-ci tests don't catch this one currently.
>>>
>>> > Stephen can you share with how your testing this so Dan can follow
>>> > suit?
>>>
>>> In this case, you could build and install to a private directory as
>>> per
>>> the README, then set your LD_LIBRARY_PATH=~/obj/lib or whatever and
>>> run
>>> selabel_lookup.
>>
>> Ala:
>> $ make DESTDIR=~/obj install
>> $ LD_LIBRARY_PATH=~/obj/lib selabel_lookup -b file -k /etc
>> Segmentation fault (core dumped)
>>
>> BTW, I guess this exposes another issue with the patch; there is no
>> support for exercising the new code included with it, e.g. an extension
>> to utils/selabel_lookup.c to permit specifying multiple input files via
>> multiple -f options.  Otherwise, we have no upstream way of testing it.
>
> For selabel_lookup, it would be possible to write a test script (or a
> CUnit-based test program like libsepol and libsemanage have) which
> does not need an SELinux policy to be installed on the system, thanks
> to option -f.
> Nevertheless other parts of libselinux (and programs) can not
> currently be tested on a system without SELinux, as /etc/selinux and
> /sys/fs/selinux are needed. If we want to automatize the testing of
> such parts in a CI like Travis-CI, I suppose we would need to run a
> virtual machine with its own filesystem, a kernel with SELinux
> enabled, and some programs like coreutils compiled with the tested
> version of libselinux/libsepol/... As implementing such an idea may
> take quite a long time, would there be simpler ways to perform
> automatic testing of libselinux? Perhaps using another continuous
> integration system?

The free travis just provides an Ubuntu image.... if you use sudo: true
you get a full VM if you don't, you get a docker container.

With that said, we could try to hack up the VM image to support what we need,
or perhaps we can use CMockaand mock out the filesystem calls to proc/selinuxfs
with something that replicates it.(not sure if that's how mock objects work)


>
> Cheers,
> Nicolas
>
