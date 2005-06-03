Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j53DmdgA000391
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 09:48:39 -0400 (EDT)
Received: from web33204.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j53DgEjH029593
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 13:42:14 GMT
Message-ID: <20050603134210.76808.qmail@web33204.mail.mud.yahoo.com>
Date: Fri, 3 Jun 2005 06:42:10 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Re: Labeling confusion with apt-get/dpkg
To: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050603131809.GI8365@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:

> On Fri, Jun 03, 2005 at 05:18:34AM -0700, Roger Brunell wrote:
> > Chalk this up to inexperience, but I am confused, I think.
> > I used apt-get to install tcsh on my system. 
> 
>  you need to use se_apt-get, a wrapper around apt-get
>  that places apt-get into the right security domain or somethingorother
>  i forget what
>

Ok; I tried that, so-so results, the full console is far below, but the essence
is here:

root@flattop:/# se_apt-get tcsh
cannot find your entry in the passwd file.
authentication failed.

Is the auth procedure RedHat-centric?  I am running Debian based.



root@flattop:/# which se_apt-get
/usr/sbin/se_apt-get
root@flattop:/# ll /usr/sbin/se_apt-get
lrwxrwxrwx  1 root root 7 Jun  2 12:37 /usr/sbin/se_apt-get -> se_dpkg
root@flattop:/# ll /usr/sbin/se_dpkg   
-rwxr-xr-x  1 root root 118 Jan 19 12:26 /usr/sbin/se_dpkg
root@flattop:/# file /usr/sbin/se_dpkg
/usr/sbin/se_dpkg: Bourne shell script text executable
root@flattop:/# cat /usr/sbin/se_dpkg
#!/bin/sh

EXEC=`echo $0 | cut -f2 -d_`

if [ "$EXEC" != "dpkg" ]; then
  cd /
fi

exec /usr/sbin/run_init $EXEC "$@"
root@flattop:/# 
root@flattop:/# 
root@flattop:/# se_apt-get tcsh
cannot find your entry in the passwd file.
authentication failed.
root@flattop:/# 
root@flattop:/# grep root /etc/passwd
root:x:0:0:root:/root:/bin/bash
root@flattop:/# grep root /etc/shadow
root:DEADZByreU07Q:12527:0:99999:7:::
root@flattop:/# 


 
>  but if you run apt-get on its own, yep, that's pretty much what
>  happens...
> 
>  also have you installed the _modified_ version of dpkg - the one with
>  the /etc/dpkg/postinst.d patch?


   Can't really say. I used an archive of SEL-aware packages supplied by Manoj
Srivastava. (www.golden-gryphon.com/software/security/selinux.xhtml)


> 
>  ... get it while it hot, from selinux.lemuria.org/newselinux ...
> 
>  if you want something to do "proper" fix, you would do
>  well to analyse dpkg where it unpacks .debs and creates
>  files/directories/symlinks, and to patch it to do setfilecon()
>  calls at the appropriate points [just like rpm has been
>  so patched - and accepted, it being rpm, redhat requiring FC to
>  do selinux and all... ]
> 
>  l.
> 
> 
> > 'dpkg' was updated with the
> > sel-aware version. I then checked the labels and found conflicting data:
> > 
> > root@flattop:/usr/bin# cd /bin
> > root@flattop:/bin# ls -lZ bash
> > -rwxr-xr-x  root     root     system_u:object_r:shell_exec_t   bash
> > root@flattop:/bin# ls -lZ tcsh
> > -rwxr-xr-x  root     root     system_u:object_r:bin_t          tcsh
> > root@flattop:/bin# 
> > 
> > I look in /etc/selinux/strict/contexts/files/file_contexts:
> > 
> >     158 #
> >     159 # /bin
> >     160 #
> >     161 /bin(/.*)?                      system_u:object_r:bin_t
> >     162 /bin/tcsh               --      system_u:object_r:shell_exec_t
> >     163 /bin/bash               --      system_u:object_r:shell_exec_t
> >     164 /bin/bash2              --      system_u:object_r:shell_exec_t
> > 
> > bash's label came from line 163 (during a relabel op). While, it appears,
> that
> > tcsh's label is from 161 (updated by dpkg). But why not a match with 162?
> > 
> > Who reads and interprets the file_contexts file? It doesn't appear to be
> > conditional.
> > 
> > 
> > 
> > Roger Brunell
> > 
> > Infosec Engineer (retired)
> > "Born 20 years too early"
> > 
> > 
> > 		
> > __________________________________ 
> > Discover Yahoo! 
> > Have fun online with music videos, cool games, IM and more. Check it out! 
> > http://discover.yahoo.com/online.html
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.
> 
> -- 
> --
> <a href="http://lkcl.net">http://lkcl.net</a>
> --
> 


Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
