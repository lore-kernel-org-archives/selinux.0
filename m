Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2NBA0Do021011
	for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2005 06:10:01 -0500 (EST)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2NB7SQ4028555
	for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2005 11:07:28 GMT
Date: Wed, 23 Mar 2005 12:10:03 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: latest diff
Message-ID: <20050323110957.GI12610@rom.cip.ifi.lmu.de>
References: <423BCC68.3090003@redhat.com> <1111248890.5582.20.camel@chris.pebenito.net> <423C54F5.5060205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <423C54F5.5060205@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Daniel J Walsh <dwalsh@redhat.com> [2005-03-19 17:56]:
> Christopher J. PeBenito wrote:
> 
> >On Sat, 2005-03-19 at 01:53 -0500, Daniel J Walsh wrote:
> >
> >>I think we can remove the hostname policy, it adds little value.  
> >>
> >[cut]
> >
> >>I think it would work fine without hostname policy.  I think we could 
> >>probably get rid of consoletype also.
> >>   
> >
> >I don't remember why hostname and consoletype were added in the first
> >place, but a quick look through them makes me think that its so we don't
> >have to give sys_admin capability to initrc_t when these programs are
> >run from init scripts.  Sys_admin is a huge set a privileges, so I'd say
> >its worthwhile to keep them around.

Would it be possible to decompose sys_admin into a set of selinux
permissions? I think this would be the best solution. 
Probably difficult with the current design, but maybe capable() could
get a second parameter specifying what type of access is to be granted,
or the code could call an lsm function in addition to the capable()
call.
Is this doable?

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
