Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n877tL8S028856
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 03:55:21 -0400
Received: from mail-yx0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n877ueuA020805
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 07:56:40 GMT
Received: by yxe4 with SMTP id 4so1138541yxe.32
        for <selinux@tycho.nsa.gov>; Mon, 07 Sep 2009 00:55:20 -0700 (PDT)
Message-ID: <4AA4BC6D.9090304@gmail.com>
Date: Mon, 07 Sep 2009 00:55:25 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: waqar afridi <afridi.waqar@gmail.com>
CC: zheyeung@gmail.com, selinux@tycho.nsa.gov
Subject: Re: Problem install Reference Policy
References: <200909071010066097796@gmail.com> <4AA48895.8030400@gmail.com> <78aaeffc0909062353p428dac47q614eb6b71a2f8ed7@mail.gmail.com>
In-Reply-To: <78aaeffc0909062353p428dac47q614eb6b71a2f8ed7@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

waqar afridi wrote:
> *Thanx zheyeung*, But If I do leave the original *Build.conf* I get
> the following error
>
> /usr/bin/checkpolicy policy.conf -o
> /etc/selinux/refpolicy/policy/policy.23
> /usr/bin/checkpolicy: loading policy configuration from policy.conf
> make: *** [/etc/selinux/refpolicy/policy/policy.23] Killed
>
> Is it due to less memory or some thing else, I also turned off some
> unwanted modules from *modules.conf*, but didnt help, What should I do?
>
>
Not sure, I was receiving an error
from checkpolicy, but I think I'm missing
a dependency.(keep in mind this is a custom clfs
system).
In your case if your using a distro
checkpolicy should be functioning properly.

have you tried a fresh git pull of the refpolicy
and compiled it with vary little changes to the policy?

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
