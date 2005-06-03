Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j53DG4gA000138
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 09:16:04 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j53D9Ghg027402
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 13:09:16 GMT
Date: Fri, 3 Jun 2005 14:18:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Labeling confusion with apt-get/dpkg
Message-ID: <20050603131809.GI8365@lkcl.net>
References: <20050603121834.73852.qmail@web33206.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050603121834.73852.qmail@web33206.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 03, 2005 at 05:18:34AM -0700, Roger Brunell wrote:
> Chalk this up to inexperience, but I am confused, I think.
> I used apt-get to install tcsh on my system. 

 you need to use se_apt-get, a wrapper around apt-get
 that places apt-get into the right security domain or somethingorother
 i forget what

 but if you run apt-get on its own, yep, that's pretty much what
 happens...

 also have you installed the _modified_ version of dpkg - the one with
 the /etc/dpkg/postinst.d patch?

 ... get it while it hot, from selinux.lemuria.org/newselinux ...

 if you want something to do "proper" fix, you would do
 well to analyse dpkg where it unpacks .debs and creates
 files/directories/symlinks, and to patch it to do setfilecon()
 calls at the appropriate points [just like rpm has been
 so patched - and accepted, it being rpm, redhat requiring FC to
 do selinux and all... ]

 l.


> 'dpkg' was updated with the
> sel-aware version. I then checked the labels and found conflicting data:
> 
> root@flattop:/usr/bin# cd /bin
> root@flattop:/bin# ls -lZ bash
> -rwxr-xr-x  root     root     system_u:object_r:shell_exec_t   bash
> root@flattop:/bin# ls -lZ tcsh
> -rwxr-xr-x  root     root     system_u:object_r:bin_t          tcsh
> root@flattop:/bin# 
> 
> I look in /etc/selinux/strict/contexts/files/file_contexts:
> 
>     158 #
>     159 # /bin
>     160 #
>     161 /bin(/.*)?                      system_u:object_r:bin_t
>     162 /bin/tcsh               --      system_u:object_r:shell_exec_t
>     163 /bin/bash               --      system_u:object_r:shell_exec_t
>     164 /bin/bash2              --      system_u:object_r:shell_exec_t
> 
> bash's label came from line 163 (during a relabel op). While, it appears, that
> tcsh's label is from 161 (updated by dpkg). But why not a match with 162?
> 
> Who reads and interprets the file_contexts file? It doesn't appear to be
> conditional.
> 
> 
> 
> Roger Brunell
> 
> Infosec Engineer (retired)
> "Born 20 years too early"
> 
> 
> 		
> __________________________________ 
> Discover Yahoo! 
> Have fun online with music videos, cool games, IM and more. Check it out! 
> http://discover.yahoo.com/online.html
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
