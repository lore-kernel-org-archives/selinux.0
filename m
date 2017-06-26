Subject: Re: [PATCH] Fix consistency of PYTHONLIBDIR variable
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20170626164651.20452-1-bigon@debian.org>
 <1498505865.13301.37.camel@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <59aa18b2-5f23-ffe1-ed66-45b4cc4ad3a4@debian.org>
Date: Mon, 26 Jun 2017 23:58:11 +0200
MIME-Version: 1.0
In-Reply-To: <1498505865.13301.37.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 26/06/17 à 21:37, Stephen Smalley a écrit :
> On Mon, 2017-06-26 at 18:46 +0200, bigon@debian.org wrote:
>> From: Laurent Bigonville <bigon@bigon.be>
>>
>> PYTHONLIBDIR is currently not consistant, at one place it's
>> influanced
>> by DESTDIR an at another one it's not.
>>
>> Fix this and make it consistant
> Seems like it is influenced by DESTDIR before and after this change
> (before, PYTHONLIBDIR is defined relative to LIBDIR which is defined
> relative to PREFIX which is define relative to DESTDIR).
>
> If I do a make DESTDIR=/path/to/foo install before and after this
> change (with an empty /path/to/foo before each run), the only
> difference is that it moves from $(DESTDIR)/usr/lib/pythonM.N/site-
> packages to $(DESTDIR)/usr/lib64/pythonM.N/site-packages.
>
> This makes it consistent with sepolgen but inconsistent with sepolicy,
> which is installed to usr/lib, not usr/lib64.
>
> So, I'm unclear on whether this is an improvement.

With the debian build system, LIBDIR is set to 
$(DESTDIR)/usr/lib/<arch-triplet> this means that PYTHONLIBDIR will end 
up as $(DESTDIR)/usr/lib/<arch-triplet>/python/<version>.

If I override PYTHONLIBDIR to $(DESTDIR)/usr/lib/python/<version> I ends 
up with sepolicy being installed in 
$(DESTDIR)/$(DESTDIR)/usr/lib/<arch-triplet>/python/<version> which is 
not what I want either

>
>> ---
>>   python/semanage/Makefile | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
>> index 60c36a3a..132162bc 100644
>> --- a/python/semanage/Makefile
>> +++ b/python/semanage/Makefile
>> @@ -5,8 +5,8 @@ PREFIX ?= $(DESTDIR)/usr
>>   LIBDIR ?= $(PREFIX)/lib
>>   SBINDIR ?= $(PREFIX)/sbin
>>   MANDIR = $(PREFIX)/share/man
>> -PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" %
>> sys.version_info[0:2])')
>> -PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
>> +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig
>> import *; print(get_python_lib(1))")
>> +PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
>>   BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-
>> completion/completions
>>   
>>   TARGETS=semanage
>> @@ -20,8 +20,8 @@ install: all
>>   	-mkdir -p $(SBINDIR)
>>   	install -m 755 semanage $(SBINDIR)
>>   	install -m 644 *.8 $(MANDIR)/man8
>> -	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d
>> $(PYTHONLIBDIR)/site-packages
>> -	install -m 755 seobject.py $(PYTHONLIBDIR)/site-packages
>> +	test -d $(PACKAGEDIR) || install -m 755 -d $(PACKAGEDIR)
>> +	install -m 755 seobject.py $(PACKAGEDIR)
>>   	-mkdir -p $(BASHCOMPLETIONDIR)
>>   	install -m 644 $(BASHCOMPLETIONS)
>> $(BASHCOMPLETIONDIR)/semanage
>>   
