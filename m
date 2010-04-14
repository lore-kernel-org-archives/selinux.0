Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3ECNIxn006104
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 08:23:18 -0400
Received: from mailgw1a.lmco.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3ECOBaU017093
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 12:24:11 GMT
Date: Wed, 14 Apr 2010 08:23:02 -0400
From: "Benedict, Phillip M" <phillip.m.benedict@lmco.com>
Subject: RE: MLS telnet question
In-reply-to: <201004131754.58738.paul.moore@hp.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-id: <6235CF4DC66FD5478F0E350E17C202FF251F46F50F@HVXMSP3.us.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com> <20100413164236.GE16595@myhost.felk.cvut.cz>
 <201004131754.58738.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, I will take another look at Netlabel's fallback/static labeling. 
So how can I verify if my kernel (the default RHEL 5.3 kernel 2.6.128) has Netlabel support?
Also I currently have separate ssh daemons running at certain sensitivities (runcon) and bound to specific IP addresses (separate sshd_config files). Will fallback labeling impact my ssh setup?

Thanks
Mike


-----Original Message-----
From: Paul Moore [mailto:paul.moore@hp.com]
Sent: Tuesday, April 13, 2010 5:55 PM
To: Benedict, Phillip M
Cc: Michal Svoboda; selinux@tycho.nsa.gov
Subject: Re: MLS telnet question

On Tuesday 13 April 2010 12:42:36 pm Michal Svoboda wrote:
> Benedict, Phillip M wrote:
> >    The network does not carry any cipso data for evaluation by my
> >    server, so I don’t think I can use netlabel.
> 
> You can use the fallback label feature that can assign labels 
> statically per remote IP.

NetLabel fallback/static label example configuration:

 * http://paulmoore.livejournal.com/1758.html

--
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
