Message-ID: <1348.202.27.185.71.1052429174.squirrel@www.crypt.gen.nz>
Date: Fri, 9 May 2003 09:26:14 +1200 (NZST)
Subject: Re: Step 19 of install
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <ccarney@seacorp.com>
In-Reply-To: <001001c31581$d8abd450$e501a8c0@CarneyC>
References: <001001c31581$d8abd450$e501a8c0@CarneyC>
Cc: <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher Carney said:
> I got threw the install and I ran make relabel.  Now I am not sure where
> my path for modified utilities is. I am trying to follow step 19 but
> don't know how.
> 19) Add /usr/local/selinux/bin and /usr/local/selinux/sbin
> to your path for the modified utilities.

For RedHat, edit /etc/profile and add the directories to the "pathmunge"
lists:

  # Path manipulation
  if [ `id -u` = 0 ]; then
        pathmunge /sbin
        pathmunge /usr/sbin
        pathmunge /usr/local/bin
        pathmunge /usr/local/sbin
        pathmunge /usr/local/selinux/sbin
  fi

  pathmunge /usr/X11R6/bin after
  pathmunge /usr/local/bin
  pathmunge /usr/local/selinux/bin


... also you will probably want to add the SELinux man directory to
MANPATH, by editing /etc/man.config and adding:

  MANPATH /usr/local/selinux/man

BEFORE the usual system MANPATHs so that your man command will pickup the
SELinux man pages before the non-SE system ones.

I'll add this stuff to my FAQ ( http://www.crypt.gen.nz/selinux/faq.html )
in the next update.

Kerry









--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
