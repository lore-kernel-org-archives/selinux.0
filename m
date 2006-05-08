Message-ID: <445F7738.4070301@gentoo.org>
Date: Mon, 08 May 2006 12:52:08 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Ivan Gyurdiev <ivg2@cornell.edu>
Subject: libsemanage swig problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

does anyone know what is up with this:

gcc -g -shared -o _semanage.so semanageswig_wrap.lo -L. -lsemanage 
-lpython2.4 -L/usr/lib -Wl,-soname,_semanage.so,-z,defs
semanageswig_wrap.lo: In function 
`_wrap_semanage_module_list':semanageswig_wrap.c:(.text+0x38d1): 
undefined reference to `SWIG_Python_AppendOutput'
semanageswig_wrap.lo: In function 
`_wrap_semanage_context_create':semanageswig_wrap.c:(.text+0x44a3): 
undefined reference to `SWIG_Python_AppendOutput'
semanageswig_wrap.lo: In function 
`_wrap_semanage_context_clone':semanageswig_wrap.c:(.text+0x45e8): 
undefined reference to `SWIG_Python_AppendOutput'
semanageswig_wrap.lo: In function 
`_wrap_semanage_context_from_string':semanageswig_wrap.c:(.text+0x47d0): 
undefined reference to `SWIG_Python_AppendOutput'
semanageswig_wrap.lo: In function 
`_wrap_semanage_context_to_string':semanageswig_wrap.c:(.text+0x4903): 
undefined reference to `SWIG_Python_AppendOutput'
semanageswig_wrap.lo:semanageswig_wrap.c:(.text+0x4a45): more undefined 
references to `SWIG_Python_AppendOutput' follow

I can't find where this function is suppose to be defined, there are no 
swig header files (or libraries for that matter) so I assume it is 
suppose to pull it in but it isn't. This happens in head right now if 
you make swigify (apparently hasn't been done in a while) and try to 
make pywrap. Googling SWIG_Python_AppendOutput is less than helpful :\

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
