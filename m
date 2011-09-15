Message-ID: <4E71E8FD.8020505@tresys.com>
Date: Thu, 15 Sep 2011 08:01:01 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        <guido@trentalancia.com>
Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>  <1316026239-27148-2-git-send-email-eparis@redhat.com>  <1316027881.26965.15.camel@moss-pluto> <1316031697.2738.37.camel@localhost>
In-Reply-To: <1316031697.2738.37.camel@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/14/11 16:21, Eric Paris wrote:
> On Wed, 2011-09-14 at 15:18 -0400, Stephen Smalley wrote:
>> On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
>>> At the moment we create a symlink:
>>>
>>> /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
>>>
>>> This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
>>> ../../.  Instead create a symlink from
>>>
>>> $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
>>>
>>> Thus it works no matter what values one might use for LIBDIR and
>>> SHLIBDIR.
>>
>> I'm not sure this works the way you would want.  Consider rpm build of
>> libselinux - it does:
>> make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
>> SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install
>>
>> And then rpm collects up the files into the package.
>> But if the symlink encodes the full pathname used at make install time,
>> then it will be wrong on the final system when the rpm is installed.
>> Haven't actually tested that theory, but I think it is true.  Welcome to
>> hell.
> 
> error: Symlink points to BuildRoot: /usr/lib64/libselinux.so
> -> /root/rpmbuild/BUILDROOT/libselinux-2.1.5-4.fc16.1.eparis.x86_64/lib64/libselinux.so.1
> 
> GRRRRRR.   Every other package I see with similar symlinks seems to be
> an autoconf package and I can't understand how they work.  What we have
> isn't right, but I don't know how to fix it....

Its easy.  The makefile needs to be tweaked so you don't have to specify %{buildroot} as part of the LIBDIR, SHLIBDIR, and BINDIR variables.  Then when you use those variables, you prepend DESTDIR as necessary.  So if you have usages like

install foo $(BINDIR)

it turns into

install foo $(DESTDIR)(BINDIR)

Then when you have your symlink you can do

ln -s $(SHLIBDIR)/bar.so.1 $(DESTDIR)$(SHLIBDIR)/bar.so


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
