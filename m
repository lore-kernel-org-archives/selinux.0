Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KEtiRb019309
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:55:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KErIB2001997
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:53:18 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
	by jazzswing.ncsc.mil  with SMTP id i4KErHwi001994
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:53:17 GMT
Date: Thu, 20 May 2004 14:52:58 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040520145258.GF8810@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <20040519100822.GA31914@colombo.cip.ifi.lmu.de> <20040519115039.GB4221@lkcl.net> <20040520121157.GA2146@jmh.mhn.de> <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 08:49:40AM -0400, Stephen Smalley wrote:
> On Thu, 2004-05-20 at 08:11, Thomas Bleher wrote:
> > I just rechecked, and it is indeed working fine on a SuSE box
> > (kdebase3-kdm-3.2.2-8) without any patches, just using the selinux pam
> > module.
> 
> Interesting.  We weren't able to use pam_selinux with gdm, as
> pam_open_session was called from a different process.
 
 i _do_ notice in permissive / audit mode that kdeinit attempts to
 do an su:

 May 20 14:53:58 tv kernel: audit(1085064838.508:0): avc:  denied  {
 execute } for  pid=2616 exe=/usr/bin/kdeinit name=su dev=hda5 ino=93620
 scontext=lkcl:user_r:user_t tcontext=system_u:object_r:su_exec_t
 tclass=file

 May 20 14:53:58 tv kernel: audit(1085064838.509:0): avc:  denied  {
 getattr } for  pid=2616 exe=/usr/bin/kdeinit path=/bin/su dev=hda5
 ino=93620 scontext=lkcl:user_r:user_t
 tcontext=system_u:object_r:su_exec_t tclass=file

 this is _without_ doing a pam session, but with a patched
 kdm.

 checking the source code... kdm/process/client.c:StartClient()
 the get_default_context is at line 1102.

 pam_open_session() is at line 1172.

 track track track... oo, wossat?  a fork()???  ah, that's at line 1184.
 
 okay, so i prepare a context, then open the pam session, and _then_
 there's a fork (this is horrible code, btw - really large switch
 statements and yuk indentation: i'm actually giving up looking for
 the end of the switch statement or another case or the default :)

 so, if pam_open_session() does all the work, then i don't need to
 have patched kdm, and a line in /etc/pam.d/kdm to include module
 pam_selinux would do the job just as well.

 oh well :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
