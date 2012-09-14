Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8EFfURX020368
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 11:41:30 -0400
Message-ID: <5053502B.6010706@manicmethod.com>
Date: Fri, 14 Sep 2012 11:41:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Cesar Maiorino <cesar.maiorino@gmail.com>
CC: William Roberts <bill.c.roberts@gmail.com>,
        Joman Chu <jcchu@tycho.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: Problem with SEManager app on Seandroid 4.0.4
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com> <CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com> <CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com> <CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com> <5050AC29.30400@tycho.ncsc.mil> <CAN93RkLPPD=kULgYAN0y9_sVOHrQT9PUmQHrcarwMVV9PND2bQ@mail.gmail.com> <CAFftDdoi3XTxNREPzYhVH-FJ=id+2m0EYHV-b97Pk7HxiUOcvw@mail.gmail.com> <CAN93RkLAgyVR=7EzgxA5vOCQNMpyoud1P9XhLK67nQsEa=B8kQ@mail.gmail.com>
In-Reply-To: <CAN93RkLAgyVR=7EzgxA5vOCQNMpyoud1P9XhLK67nQsEa=B8kQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Cesar Maiorino wrote:
<snip>
> (2) If I don't add the "shell allow" rules, how do I deal with those
> denials?
>

During development I add a permissive rule for shell so that I can do 
whatever I need to do while in enforcing, just add this to your shell.te 
at the bottom and remember to remove it before production :) :

permissive shell;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
