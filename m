Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEN6QWd003234
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 18:06:26 -0500
Received: by mail-it0-f68.google.com with SMTP id q124so17600846itd.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 15:06:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nE0i60LuYs7+zU=-54LA8jLb=N8GUK5hNQVEX_65yqXw@mail.gmail.com>
References: <20161114215712.18962-1-nicolas.iooss@m4x.org>
 <CAFftDdrFwOHGGSwzCK1UZAJZF8-h2dw9aLmLBQtR8EQ=6fcsqA@mail.gmail.com>
 <CAJfZ7=nE0i60LuYs7+zU=-54LA8jLb=N8GUK5hNQVEX_65yqXw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 14 Nov 2016 15:06:24 -0800
Message-ID: <CAFftDdodmRSq8FmFrYi+YyJWaw8s0KMU-nUTJ40F7ZtaP8Jh8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux,
 libsemanage: fall back to gcc in exception.sh
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 14, 2016 at 3:00 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> The SWIG wrapper already includes the header files using #include (look at
> the beginning of libselinux/src/selinuxswig_python.i [1] for example). The
> script exception.h reads the header files (through gcc -aux-info) to
> generate some SWIG code for almost every interface returning an integer
> (this code converts a negative return value to the raising of a Python
> OSError exception).
>
> In SWIG documentation [2] I have not found a way to automatically apply a
> %exception block to all functions matched by the pattern "it returns an
> integer". As you seem to believe I missed something,

I don't think you did.

could you please
> explain how you would proceed here?

Yeah that script is just generating a bunch of interface code, I would
just remove that script
and write it by hand. The only downfall is that you would have to add
a stub if you add something
to the header file, but I don't consider that a downside, I prefer to
be explicit. Especially
considering they already had to put a function in the script to skip.
I don't think the script provides
much value.

>
> Nicolas
>
> [1]
> https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/selinuxswig_python.i#L11
> [2] http://www.swig.org/Doc3.0/SWIGDocumentation.html
>
>
> On Mon, Nov 14, 2016 at 11:15 PM, William Roberts <bill.c.roberts@gmail.com>
> wrote:
>>
>> For a more long term solution, why not just give swig a header file
>> (you can ifdef on SWIG for anything to omit), or write the interface
>> file by hand. I ended up using a hybrid approach for one my projects
>> (the build system is a mess):
>>
>>
>> https://bitbucket.org/miniat/0x1-miniat/src/f84cb76ab0fbe645ee9c48d30221b29283745778/vm/src/miniat_python.i?at=master&fileviewer=file-view-default
>>
>>
>> On Mon, Nov 14, 2016 at 1:57 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
>> wrote:
>> > clang does not support -aux-info option. When exception.sh is run with
>> > CC=clang, use gcc to build selinuxswig_python_exception.i and
>> > semanageswig_python_exception.i.
>> >
>> > This does not solve the issue of building libselinux and libsemanage
>> > Python wrappers on a system without gcc. However parsing the result of
>> > "gcc -aux-info" is easier than parsing the header files so stay with
>> > this command at least for now.
>> >
>> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> > ---
>> >  libselinux/src/exception.sh  | 6 +++++-
>> >  libsemanage/src/exception.sh | 6 +++++-
>> >  2 files changed, 10 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
>> > index a58bf3f45778..a3ff83235ced 100755
>> > --- a/libselinux/src/exception.sh
>> > +++ b/libselinux/src/exception.sh
>> > @@ -15,6 +15,10 @@ echo "
>> >  ;;
>> >  esac
>> >  }
>> > -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
>> > ../include/selinux/selinux.h
>> > +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
>> > ../include/selinux/selinux.h
>> > +then
>> > +    # clang does not support -aux-info so fall back to gcc
>> > +    gcc -x c -c -I../include - -aux-info temp.aux <
>> > ../include/selinux/selinux.h
>> > +fi
>> >  for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except
>> > $i ; done
>> >  rm -f -- temp.aux -.o
>> > diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
>> > index d18959cbe85d..a4095f4f8ba6 100644
>> > --- a/libsemanage/src/exception.sh
>> > +++ b/libsemanage/src/exception.sh
>> > @@ -9,6 +9,10 @@ echo "
>> >  }
>> >  "
>> >  }
>> > -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
>> > ../include/semanage/semanage.h
>> > +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux <
>> > ../include/semanage/semanage.h
>> > +then
>> > +    # clang does not support -aux-info so fall back to gcc
>> > +    gcc -x c -c -I../include - -aux-info temp.aux <
>> > ../include/semanage/semanage.h
>> > +fi
>> >  for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ;
>> > done
>> >  rm -f -- temp.aux -.o
>> > --
>> > 2.10.2
>> >
>> > _______________________________________________
>> > Selinux mailing list
>> > Selinux@tycho.nsa.gov
>> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to
>> > Selinux-request@tycho.nsa.gov.
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>
>



-- 
Respectfully,

William C Roberts
