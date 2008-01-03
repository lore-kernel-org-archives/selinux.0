Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03FdbV9002446
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 10:39:37 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m03FdaAY014868
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 15:39:37 GMT
Subject: Re: startx
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30712201349n311e41c4y99dfa8af337f6d2b@mail.gmail.com>
References: <dd18b0c30712201349n311e41c4y99dfa8af337f6d2b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 10:38:35 -0500
Message-Id: <1199374715.12626.297.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-20 at 13:49 -0800, Justin Mattock wrote:
> Hello Im a bit confused with starting the xserver with startx; the
> system starts fine with everything set to permissive, but as soon as
> changing to enforce mode
> startx reacts extremly slow; with a blank screen and a curser at the
> top left of the screen.  Do I need to set xdm_systadm_login to 1 or do
> I need to just be patient while  the xserver starts then  add the
> avc's to local.te 

Are you using strict?  If so, the X server policy isn't well tested, so
it likely needs additional rules.  Based on your description, it sounds
like its being denied something and patience likely won't help.  You'll
have to handle the denials in permissive.  The above boolean only
controls if sysadm can log in via xdm.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
