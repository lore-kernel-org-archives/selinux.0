Message-ID: <4ADC872D.5050205@redhat.com>
Date: Mon, 19 Oct 2009 11:35:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1
References: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>	 <4AD489A5.7010708@manicmethod.com>	 <87k4yypls7.fsf@anzu.internal.golden-gryphon.com>	 <1255962053.3099.22.camel@moss-pluto.epoch.ncsc.mil>	 <4ADC80A0.6010809@redhat.com> <1255965103.3099.51.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1255965103.3099.51.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2009 11:11 AM, Stephen Smalley wrote:
> On Mon, 2009-10-19 at 11:07 -0400, Daniel J Walsh wrote:
>> On 10/19/2009 10:20 AM, Stephen Smalley wrote:
>>> On Wed, 2009-10-14 at 00:49 -0500, Manoj Srivastava wrote:
>>>> On Tue, Oct 13 2009, Joshua Brindle wrote:
>>>>
>>>>
>>>>> Yes, I'm not sure why you'd need libsemanage during early boot, we
>>>>> probably should apply this:
>>>>>
>>>>> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
>>>>> index cfb9558..c531a2f 100644
>>>>> --- a/libsemanage/src/Makefile
>>>>> +++ b/libsemanage/src/Makefile
>>>>> @@ -1,7 +1,7 @@
>>>>>  # Installation directories.
>>>>>  PREFIX ?= $(DESTDIR)/usr
>>>>>  LIBDIR ?= $(PREFIX)/lib
>>>>> -SHLIBDIR ?= $(DESTDIR)/lib
>>>>> +SHLIBDIR ?= $(PREFIX)/lib
>>>>>  INCLUDEDIR ?= $(PREFIX)/include
>>>>>  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" %
>>>>> sys.version_info[0:2]')
>>>>>  PYINC ?= /usr/include/${PYLIBVER}
>>>>>
>>>>
>>>>         I've applied this patch in Debian unstable.
>>>
>>> My only concern with relocating libsemanage is whether it will create
>>> any compatibility problems for existing binaries previously linked
>>> against /lib/libsemanage.so.1.  Also it could get confusing if you build
>>> and install the newer version and existing binaries keep using the old
>>> library at the old location.  You likely need/want to
>>> symlink /lib/libsemanage.so.1 to the new location.
>>>
>> Why does it need to be moved?  Are you doing semanage functions during boot up?
> 
> It's moving the other direction (presently in /lib, moving to /usr/lib).
> Manoj pointed out that because of the ustr dependency, it no longer
> makes sense to keep libsemanage in /lib, because libustr lives
> in /usr/lib.
> 
Oh, I misread. I think  like a symbolic link should handle this

Although the only entry I see for this is 

 ls -l /lib | grep '\.\.'
lrwxrwxrwx.  1 root root      14 2009-10-11 07:36 cpp -> ../usr/bin/cpp




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
