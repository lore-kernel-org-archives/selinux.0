Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i588d2rT010513
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 04:39:02 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i588cwcx028201
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 04:38:59 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 8 Jun 2004 08:38:45 -0000
Date: Tue, 8 Jun 2004 08:36:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dpkg fails on installing nvidia-glx because /etc/init.d/nvidia-glx start is run
Message-ID: <20040608083606.GN3305@lkcl.net>
References: <20040607231556.GI3305@lkcl.net> <200406080212.i582C1uG013226@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406080212.i582C1uG013226@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 07, 2004 at 10:12:01PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 07 Jun 2004 23:15:56 -0000, Luke Kenneth Casson Leighton <lkcl@lkcl.net>  said:
> > hiya (russell?)
> > 
> > i just installed the nvidia-glx package (don't ask :)
> 
> > i need to write an nvidia-glx policy, don't i?
> 
> Not necessarily.  At least under Fedora, all the NVidia stuff ends up
> labelled correctly by the contents of file_contexts/program/xserver.fc
> (All the /usr/lib *.so's  end up as shlib_t, and the /dev/nvidia.* end
> up as xserver_misc_device_t, and you're ready to rock-n-roll...)
> 
> You may just need to cd to /etc/<selinux-path> and do a 'make relabel'.
 
 *sigh*.  yeh, i did.

 i did the make relabel and th libGL.so.1.0.5336 is ... yep, shlib_t.
 the symlink is lib_t.


 btw during the install i got "cannot create symbolic link
 /usr/X11/lib/ libglx-something to /usr/lib/nvidia-something".

 ... why aren't these files _created_ with the correct permissions?

 can that be done?


 l.



-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
