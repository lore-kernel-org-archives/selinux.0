From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: "Kerry Thompson" <kerry@crypt.gen.nz>, <ccarney@seacorp.com>
Subject: Re: Step 19 of install
Date: Fri, 9 May 2003 09:09:01 +0200
Cc: <SELinux@tycho.nsa.gov>
References: <001001c31581$d8abd450$e501a8c0@CarneyC> <1348.202.27.185.71.1052429174.squirrel@www.crypt.gen.nz>
In-Reply-To: <1348.202.27.185.71.1052429174.squirrel@www.crypt.gen.nz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2JYL4WT4HAI8QRC9ZWOM"
Message-Id: <200305090909.02295.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_2JYL4WT4HAI8QRC9ZWOM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, 8. Mai 2003 23:26 schrieb Kerry Thompson:
> Christopher Carney said:
> > I got threw the install and I ran make relabel.  Now I am not sure
> > where my path for modified utilities is. I am trying to follow step
> > 19 but don't know how.
> > 19) Add /usr/local/selinux/bin and /usr/local/selinux/sbin
> > to your path for the modified utilities.
>
> For RedHat, edit /etc/profile and add the directories to the
> "pathmunge" lists:
>
>   # Path manipulation
>   if [ `id -u` =3D 0 ]; then
>         pathmunge /sbin
>         pathmunge /usr/sbin
>         pathmunge /usr/local/bin
>         pathmunge /usr/local/sbin
>         pathmunge /usr/local/selinux/sbin
>   fi
>
>   pathmunge /usr/X11R6/bin after
>   pathmunge /usr/local/bin
>   pathmunge /usr/local/selinux/bin
>
>
> ... also you will probably want to add the SELinux man directory to
> MANPATH, by editing /etc/man.config and adding:
>
>   MANPATH /usr/local/selinux/man
>
> BEFORE the usual system MANPATHs so that your man command will pickup
> the SELinux man pages before the non-SE system ones.

An other possibility is to copy the attached script to /etc/profile.d=20
and you don't need to edit your config files :-)
On my SuSE  /etc/profile looks in /etc/profile.d and starts all shell=20
scripts inside this directory. I'm not sure, but on RedHat it should=20
run also.

Carsten

--------------Boundary-00=_2JYL4WT4HAI8QRC9ZWOM
Content-Type: application/x-shellscript;
  name="selinux.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="selinux.sh"

#
# /etc/profile.d/selinux.sh
#
# (c) 2003 Carsten Grohmann
# 
# Licence GPL
#

uname -r | grep --silent selinux

if [ "$?" = "0" ]; then

   #
   #  Expanding PATH
   #

   PATH=/usr/local/selinux/bin:$PATH
   test "$UID" = 0 && PATH=/usr/local/selinux/sbin:$PATH
   export PATH

   #
   #  Expanding MANPATH
   #

   MANPATH=/usr/local/selinux/man:$MANPATH
   export MANPATH
   
fi;

--------------Boundary-00=_2JYL4WT4HAI8QRC9ZWOM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
