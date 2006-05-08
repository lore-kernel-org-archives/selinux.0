Subject: Re: libsemanage swig problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: SE Linux <selinux@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <445F7738.4070301@gentoo.org>
References: <445F7738.4070301@gentoo.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:11:43 -0400
Message-Id: <1147108303.23640.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 12:52 -0400, Joshua Brindle wrote:
> does anyone know what is up with this:
> 
> gcc -g -shared -o _semanage.so semanageswig_wrap.lo -L. -lsemanage 
> -lpython2.4 -L/usr/lib -Wl,-soname,_semanage.so,-z,defs
> semanageswig_wrap.lo: In function 
> `_wrap_semanage_module_list':semanageswig_wrap.c:(.text+0x38d1): 
> undefined reference to `SWIG_Python_AppendOutput'
> semanageswig_wrap.lo: In function 
> `_wrap_semanage_context_create':semanageswig_wrap.c:(.text+0x44a3): 
> undefined reference to `SWIG_Python_AppendOutput'
> semanageswig_wrap.lo: In function 
> `_wrap_semanage_context_clone':semanageswig_wrap.c:(.text+0x45e8): 
> undefined reference to `SWIG_Python_AppendOutput'
> semanageswig_wrap.lo: In function 
> `_wrap_semanage_context_from_string':semanageswig_wrap.c:(.text+0x47d0): 
> undefined reference to `SWIG_Python_AppendOutput'
> semanageswig_wrap.lo: In function 
> `_wrap_semanage_context_to_string':semanageswig_wrap.c:(.text+0x4903): 
> undefined reference to `SWIG_Python_AppendOutput'
> semanageswig_wrap.lo:semanageswig_wrap.c:(.text+0x4a45): more undefined 
> references to `SWIG_Python_AppendOutput' follow
> 
> I can't find where this function is suppose to be defined, there are no 
> swig header files (or libraries for that matter) so I assume it is 
> suppose to pull it in but it isn't. This happens in head right now if 
> you make swigify (apparently hasn't been done in a while) and try to 
> make pywrap. Googling SWIG_Python_AppendOutput is less than helpful :\

Hmmm...just tried doing a make distclean swigify pywrap here, and had no
problems (and nothing changed in the generated files).  Possibly tied to
swig version?  swig 1.3.29 here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
