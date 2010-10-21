Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9L2Xbb6017269
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 22:33:37 -0400
Received: from hrndva-omtalb.mail.rr.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9L2Xa2M005538
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 02:33:36 GMT
Date: Wed, 20 Oct 2010 21:44:31 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: Re: load_policy() with upstart on mint 9 fluxbox
Message-ID: <20101021024431.GA25516@hallyn.com>
References: <4CBE21ED.4050706@gmail.com>
 <20101020015409.GA19663@hallyn.com>
 <4CBF66AE.5040805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CBF66AE.5040805@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Justin P. Mattock (justinmattock@gmail.com):
> o.k. finally connected the dots that I needed to create a initrd.img
> in order for this to load(im a total newbie!!)
> 
> Anyways the policy loads everything went in and am now in full
> enforcement mode.. only real issue is with lxde
> same bug here:
> https://bugzilla.redhat.com/show_bug.cgi?id=552885
> 
> seems lxde is in /usr/sbin reason probably for the wrong filelabel..

Cool, so does following the steps outlined in that bug make it
work for you?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
