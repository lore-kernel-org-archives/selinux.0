Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UM1QDo019527
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:01:26 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2ULvXph014498
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 21:57:34 GMT
Date: Wed, 30 Mar 2005 23:09:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jim McCullough <jim.mccullough@gmail.com>
Cc: ivg2@cornell.edu, Casey Schaufler <casey@schaufler-ca.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050330220947.GB9752@lkcl.net>
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com> <20050330172630.GA10139@lkcl.net> <1112204662.8592.42.camel@cobra.ivg2.net> <ae023b60050330100976b46528@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ae023b60050330100976b46528@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 30, 2005 at 01:09:57PM -0500, Jim McCullough wrote:
> There as been multiple instances on other lists where an "admin" or
> "developer" has been totally ignorant of any type of security
> practices.  Cases of do as I will and roll with the punches.  This
> occurs on all platforms of development.   Freedom of implementation
> should also require some common sense.  I like the content folders
> Ivan suggested.   

 kdbfs.  modelled on the MAC OS/X "finder".  absolutely brilliant.

 a pity its back-end is implemented in ocaml.

 kdbfs is similar to famd / locate, only the author went a stage further
 and wrote a front-end that modifies the dialog boxes in KDE 3.2 [which
 i later ported to 3.3].

 the reason i mention it is because its default installation assumes
 that there exists ~/Applications, ~/Music, ~/Pictures etc, ~/Documents,
 ~/Video.

 what it does is, depending on the mime-type [file extension], it will
 present you with a file-save dialog box where there is NO CHOICE about
 where the [new] file you are saving goes.  IT WILL be saved in ~/Music
 if it has a .mpg extension.  IT WILL be saved in ~/Pictures if it has a
 .jpg extension.

 you get the idea.

 i loved it - but it wasn't integrated "enough" - unlike the MAC OS/X
 functionality it was trying to emulate.

 and unfortunately it's not a half-way-house solution: recompiling
 openoffice.org to use it for example was not an option [no KDE
 extensions available at the time, will have to wait for OO 2.0
 and _then_ specially recompile the KDE 3.3 or KDE 3.4 libs with
 the kdbfs patches... you get the idea]...

 
 basically, if there existed a linux distro which had kdbfs "rolled out"
 as an option, then it would be worthwhile having a kdbfs.te which
 defined an option that then enforced saving of files in these specific
 locations.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
