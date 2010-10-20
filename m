Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9KM0oJg006657
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 18:00:50 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9KM0m20016802
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 22:00:49 GMT
Received: by pwj1 with SMTP id 1so926834pwj.12
        for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 15:00:48 -0700 (PDT)
Message-ID: <4CBF66AE.5040805@gmail.com>
Date: Wed, 20 Oct 2010 15:01:18 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: Re: load_policy() with upstart on mint 9 fluxbox
References: <4CBE21ED.4050706@gmail.com> <20101020015409.GA19663@hallyn.com>
In-Reply-To: <20101020015409.GA19663@hallyn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

o.k. finally connected the dots that I needed to create a initrd.img
in order for this to load(im a total newbie!!)

Anyways the policy loads everything went in and am now in full
enforcement mode.. only real issue is with lxde
same bug here:
https://bugzilla.redhat.com/show_bug.cgi?id=552885

seems lxde is in /usr/sbin reason probably for the wrong filelabel..

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
