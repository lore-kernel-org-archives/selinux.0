Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA16563
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 17:12:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA13118
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 21:11:27 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id VAA13114
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 21:11:26 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: new packages
Date: Sun, 7 Jul 2002 17:11:48 -0400
Message-ID: <006201c225fa$e8389830$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020707204801.B3AC922A8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Yes I'm applying it over the debian kernel. apt-get install
kernel-source-2.4.18.  So far this kernel patch seems much improved over
the previous patches :)


Fingerd issues:

debian:/usr/src/selinux# dpkg -i
selinux-policy-default_2002070313-1_all.deb
Selecting previously deselected package selinux-policy-default.
(Reading database ... 9873 files and directories currently installed.)
Unpacking selinux-policy-default (from
selinux-policy-default_20020703131_all.deb) ...

Setting up selinux-policy-default (2002070313-1) ...

Copying the sample /usr/share/selinux/policy/current directory from
/usr/share/selinux/policy/default

Would you like to run
'make -C /usr/share/selinux/policy/current relabel' to assign SIDs
to all files on the system now [Y/n]?

make: Entering directory `/usr/share/selinux/policy/current'

make: *** No rule to make target `file_contexts/program/fingerd.fc',
needed by `file_contexts/file_contexts'.  Stop.

make: Leaving directory `/usr/share/selinux/policy/current'

dpkg: error processing selinux-policy-default (--install):
 subprocess post-installation script returned error exit status 2
Errors were encountered while processing:
 selinux-policy-default


Even with fingerd and finger installed I get the above messages.  Simply
deleting the fingerd.te file will allow a normal compile

Ed

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Sunday, July 07, 2002 4:48 PM
To: blacknet@simplyaquatics.com; 'SE Linux'
Subject: Re: new packages

On Sun, 7 Jul 2002 04:35, Ed Street wrote:
> Some quick notes on the new updates I found.
>
> 1) kernel patch file had a blurb on one file, stated already applied.
> (will get the section and past it)

Are you applying it over the Debian kernel-patch package?  If so try
getting 
the source from ftp.kernel.org.

> 2) fingerd.te gave me fits. Had to remote the file
> /usr/share/Selinux/policy/current/domains/program/fingerd.te (not
> running fingerd on this box)

What exactly was the problem?  Anyway that's not finished yet...

> 3) using apt-get while in enforcement mode gives some interesting
> errors.

Use se_apt-get, se_dpkg, and se_dselect instead of the usual programs.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
