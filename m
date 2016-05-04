Subject: Re: SELinux build errors
To: David Merritt <david.d.merritt@gmail.com>
References: <CAMyQ4FwP25QU3EvAfw0oLQuH1x05S6G8a=F7G9vnsk2duJyCvg@mail.gmail.com>
 <8c58805a-6fc9-11b3-825a-c45529662d64@tycho.nsa.gov>
 <CAMyQ4FxDwjXXvu3k7rsuvN2XiWuh5Jgq-uO9oC_K6o+uQz+Lxg@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cea43a9e-085a-bf3d-6ad0-43cc7a2f4332@tycho.nsa.gov>
Date: Wed, 4 May 2016 13:01:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAMyQ4FxDwjXXvu3k7rsuvN2XiWuh5Jgq-uO9oC_K6o+uQz+Lxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2016 12:55 PM, David Merritt wrote:
> i've stood up a fedora 23 VM to build and test on...but am hitting
> multiple errors in compilation as well as missing packages.
> 
> has this been successfully built on 23?

Yes, builds fine for me on f23.  You installed the dependencies listed
in the README?

> 
> Dave
> 
> On Wed, May 4, 2016 at 12:18 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/04/2016 11:39 AM, David Merritt wrote:
>>> platform: CentOS 7 x64
>>>
>>> from:
>>>
>>> https://github.com/SELinuxProject/selinux
>>>
>>> git clone https://github.com/SELinuxProject/selinux.git
>>>
>>> cd selinux
>>>
>>> make DESTDIR=~/obj install install-pywrap
>>>
>>> yields:
>>>
>>> .
>>> .
>>> .
>>> make[2]: Entering directory `/root/Desktop/selinux/libsepol/src'
>>> cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
>>> -I. -I../include -D_GNU_SOURCE -I../cil/include -fPIC -c -o
>>> ../cil/src/cil_lexer.o ../cil/src/cil_lexer.c
>>> <stdout>: In function ‘cil_yy_scan_bytes’:
>>> <stdout>:1567:17: error: comparison between signed and unsigned
>>> integer expressions [-Werror=sign-compare]
>>> cc1: all warnings being treated as errors
>>> make[2]: *** [../cil/src/cil_lexer.o] Error 1
>>> make[2]: Leaving directory `/root/Desktop/selinux/libsepol/src'
>>> make[1]: *** [install] Error 2
>>> make[1]: Leaving directory `/root/Desktop/selinux/libsepol'
>>> make: *** [install] Error 1
>>
>> That's actually a bug in your flex package and will affect anything
>> flex-generated.  You can workaround it by building with
>> -Wno-sign-compare added to your CFLAGS, e.g.
>> make DESTDIR=~/obj CFLAGS+=-Wno-sign-compare install install-pywrap
>>
>> flex seems to be fixed in Fedora already.
>>
>>
> 
