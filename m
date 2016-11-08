MIME-Version: 1.0
In-Reply-To: <a0f11107-cf30-9aa1-155d-535996bad45e@m4x.org>
References: <20161105212403.30462-1-nicolas.iooss@m4x.org>
 <61dd695f-31bd-069b-9865-bf45ea377de9@tycho.nsa.gov>
 <CAFftDdrN_vC0EgqT+co82486atTNBLzFOMGBPnZqBEmQ8bDNiA@mail.gmail.com>
 <a0f11107-cf30-9aa1-155d-535996bad45e@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 8 Nov 2016 08:46:34 -0800
Message-ID: <CAFftDdoo0dF1rzJ9eXyEdS4MNSrtL0Snf3r40XMrSo3aoiseDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux,
 libsemanage: remove *swig_python_exception.i if its creation failed
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 7, 2016 at 2:07 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On 07/11/16 22:19, William Roberts wrote:
>> On Nov 7, 2016 13:03, "Stephen Smalley" <sds@tycho.nsa.gov
>> <mailto:sds@tycho.nsa.gov>> wrote:
>>>
>>> On 11/05/2016 05:24 PM, Nicolas Iooss wrote:
>>> > When compiling libselinux with CC=clang, "make pywrap" reports the
>>> > following message:
>>> >
>>> >     bash exception.sh > selinuxswig_python_exception.i
>>> >     clang-3.9: error: no such file or directory: 'temp.aux'
>>> >     awk: fatal: cannot open file `temp.aux' for reading (No such file or
>>> >     directory)
>>> >
>>> > This does not make the build fail as exception.sh returns an "OK"
>>> > status. Use "bash -e" with this script to make it return an error value.
>>> >
>>> > In order not to keep an empty selinuxswig_python_exception.i file after
>>> > a build fails (which would make a second run of "make pywrap"
>> incorrectly
>>> > succeed), remove the file when exception.sh fails.
>>> >
>>> > As libsemanage uses the same code to build
>>> > semanageswig_python_exception.i, modify its Makefile too.
>>> >
>>> > By the way, on Linux clang does not seem to currently support -aux-info
>>> > so it cannot be used to craft selinuxswig_python_exception.i.
>>>
>>> Thanks, applied all three.  Maybe we need to just always set CC to gcc
>>> in exception.sh?
>>>
>>
>> What if you don't have GCC? We should support CC consistently and not
>> set it under the hood IMHO.
>
> There are also valid scenarios where exception.sh works without CC being
> gcc, for example when cross-compiling with CC=arm-....-gcc, or building
> with wrappers like CC=musl-gcc, etc.
> What about using gcc as a fallback if $CC did not work? i.e. something
> like this in exception.sh:
>
> if ! ${CC:-gcc} -x c -c -I../include - -aux-info .... ; then
>     # clang does not support -aux-info so fall back to gcc
>     gcc -x c -c -I../include - -aux-info ....
> fi
>
> Nicolas

Looking at exception.sh it appears that it takes in selinux.h and
produces custom
exception handlers for the swig interface.

We could potentially do this without -aux-info and just write the swig
interface by hand.
