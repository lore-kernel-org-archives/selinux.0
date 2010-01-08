Subject: Re: This patch fixes the exception handling in libselinux-python
 bindings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1262964740.13162.24.camel@moss-pluto.epoch.ncsc.mil>
References: <C6A74D22.A99BD%csellers@tresys.com> <4A830B34.60402@redhat.com>
	 <4AB139E8.50700@manicmethod.com> <4AB13E06.7020308@manicmethod.com>
	 <4AB15164.1020507@redhat.com> <4ABAC3C3.1000100@manicmethod.com>
	 <4ABBB78E.30501@manicmethod.com> <4ABBC642.8020709@manicmethod.com>
	 <4AC1095A.9070504@redhat.com>
	 <1262964740.13162.24.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 08 Jan 2010 15:06:28 -0500
Message-Id: <1262981188.20881.13.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-01-08 at 10:32 -0500, Stephen Smalley wrote:
> On Mon, 2009-09-28 at 15:07 -0400, Daniel J Walsh wrote:
> > On 09/24/2009 03:19 PM, Joshua Brindle wrote:
> > > Joshua Brindle wrote:
> > >> Joshua Brindle wrote:
> > >>>
> > >>>
> > >>> Daniel J Walsh wrote:
> > >>>> On 09/16/2009 03:35 PM, Joshua Brindle wrote:
> > >>>>>
> > >>>>> Joshua Brindle wrote:
> > >>>>>>
> > >>>>>> Daniel J Walsh wrote:
> > >>>>>>> What do you think of this one. Removed excess swig cruft,
> > >>>>>>>
> > >>>>>>> You need to run
> > >>>>>>>
> > >>>>>>> make swigify to generate those changes.
> > >>>>>>>
> > >>>>>> Ok, looking at this now. I don't completely get how it works. I'm
> > >>>>>> trying
> > >>>>>> to reproduce what you are doing by hand but nothing comes out of gcc:
> > >>>>>>
> > >>>>>> [root@localhost src]# echo '#include "../include/selinux/selinux.h"'>
> > >>>>>> temp.c
> > >>>>>> [root@localhost src]# gcc -c temp.c -aux-info temp.aux
> > >>>>>> [root@localhost src]# ls temp.*
> > >>>>>> temp.c temp.o
> > >>>>>>
> > >>>>>>
> > >>>
> > >>> I got this "sort of" working locally. It works when I call it directly
> > >>> on the header but it leaves a .gch file sitting in the include
> > >>> directory.
> > >>>
> > >>> Trying to use stdin I get:
> > >>>
> > >>> [root@localhost src]# gcc -x c-header -c - -aux-info temp.aux <
> > >>> ../include/selinux/selinux.h
> > >>> <stdin>:569: internal compiler error: Segmentation fault
> > >>> Please submit a full bug report,
> > >>> with preprocessed source if appropriate.
> > >>> See <http://bugzilla.redhat.com/bugzilla> for instructions.
> > >>>
> > >>>
> > >>> Other comments:
> > >>>
> > >>> The disconnect between swigify and clean targets remains: If make
> > >>> swigify builds this, and it is checked in to the tree then make clean
> > >>> shouldn't remove it, else it should be in the pywrap target and not
> > >>> installed.
> > >>>
> > >>> I'm not sure what the header re-ordering in selinuxswig.i and the
> > >>> copytree/install functions have to do with this patch.
> > >>>
> > >>
> > >>
> > >> Applied with this diff on top:
> > >>
> > >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > >> index 928a1df..74b1e6a 100644
> > >> --- a/libselinux/src/Makefile
> > >> +++ b/libselinux/src/Makefile
> > >> @@ -16,14 +16,14 @@ LIBVERSION = 1
> > >>
> > >> LIBA=libselinux.a
> > >> TARGET=libselinux.so
> > >> -SWIGIF= selinuxswig_python.i
> > >> +SWIGIF= selinuxswig_python.i selinuxswig_python_exception.i
> > >> SWIGRUBYIF= selinuxswig_ruby.i
> > >> SWIGCOUT= selinuxswig_wrap.c
> > >> SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
> > >> SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT))
> > >> SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT))
> > >> SWIGSO=_selinux.so
> > >> -SWIGFILES=$(SWIGSO) selinux.py
> > >> +SWIGFILES=$(SWIGSO) selinux.py selinuxswig_python_exception.i
> > >> SWIGRUBYSO=_rubyselinux.so
> > >> LIBSO=$(TARGET).$(LIBVERSION)
> > >> AUDIT2WHYSO=audit2why.so
> > >> @@ -103,7 +103,7 @@ $(SWIGCOUT): $(SWIGIF)
> > >> $(SWIGRUBYCOUT): $(SWIGRUBYIF)
> > >> $(SWIGRUBY) $^
> > >>
> > >> -swigify: $(SWIGIF) selinuxswig_python_exception.i
> > >> +swigify: $(SWIGIF)
> > >> $(SWIG) $<
> > >>
> > >> install: all
> > >> @@ -127,7 +127,7 @@ relabel:
> > >> /sbin/restorecon $(SHLIBDIR)/$(LIBSO)
> > >>
> > >> clean:
> > >> - -rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO)
> > >> $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~ selinuxswig_python_exception.i
> > >> + -rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO)
> > >> $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
> > >>
> > >> distclean: clean
> > >> rm -f $(GENERATED) $(SWIGFILES)
> > >> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> > >> old mode 100644
> > >> new mode 100755
> > >> index b2a3799..c3e61a5
> > >> --- a/libselinux/src/exception.sh
> > >> +++ b/libselinux/src/exception.sh
> > >> @@ -15,7 +15,6 @@ echo "
> > >> ;;
> > >> esac
> > >> }
> > >> -echo '#include "../include/selinux/selinux.h"' > temp.c
> > >> -gcc -c temp.c -aux-info temp.aux
> > >> -for i in `awk '/..\/include\/selinux\/selinux.h.*extern int/ { print $6
> > >> }' temp.aux`; do except $i ; done
> > >> -rm -f temp.c temp.aux temp.o
> > >> +gcc -x c -c - -aux-info temp.aux < ../include/selinux/selinux.h
> > >> +for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except
> > >> $i ; done
> > >> +rm -f -- temp.aux -.o
> > >>
> > > 
> > > 
> > > Merged in libselinux-2.0.87
> > 
> > 
> > I have VERSION 2.0.86 in git?
> 
> This seems to break make install-pywrap on the current selinux trunk:
> bash exception.sh > selinuxswig_python_exception.i 
> swig -Wall -python -o selinuxswig_wrap.c -outdir ./ selinuxswig_python.i selinuxswig_python_exception.i
> swig error : Unrecognized option selinuxswig_python.i
> Use 'swig -help' for available options.

This btw prevents use of Caleb's patches on Fedora 12.  If I can't build
and install the python modules from the selinux repo, then there is an
undefined dependency from the Fedora libsemanage-python module on the
upstream libsemanage (some symbol introduced in the Fedora patches to
libsemanage) and thus migrate.py is unable to import semanage and
aborts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
