Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9KDSTUG001801
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 09:28:29 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9KDSS9q014520
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 13:28:28 GMT
Received: by pwj1 with SMTP id 1so715237pwj.12
        for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 06:28:27 -0700 (PDT)
Message-ID: <4CBEEE97.9090609@gmail.com>
Date: Wed, 20 Oct 2010 06:28:55 -0700
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

o.k. I think I found the problem with this.. selinuxfs is not being 
mounted during boot to  /selinux (I manually had to mount and 
load_policy), even an entry i fstab is being ignored.
(probably why initrd isnt working).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
