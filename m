Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hARJmVRb024989
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 14:48:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hARJmUqY017392
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 19:48:30 GMT
Received: from toe.terreactive.ch (gate.terreactive.ch [212.90.202.121])
        by jazzband.ncsc.mil  with SMTP id hARJmS0o017384 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 19:48:29 GMT
Message-ID: <3FC6546D.6020908@tac.ch>
Date: Thu, 27 Nov 2003 20:45:49 +0100
From: Roberto Nibali <ratz@tac.ch>
MIME-Version: 1.0
To: Diyab <diyab@diyab.net>
CC: ratz@drugphish.ch, jonny@drugphish.ch,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: BSD Secure levels for linux
References: <3FC54560.5050303@diyab.net>
In-Reply-To: <3FC54560.5050303@diyab.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Diyab wrote:
> Has anyone else run across the kernel patch that implements something 
> similar to the BSD secure levels?  Has anyone tried to use this with 
> selinux?  I'm also curious what the general thought of the idea is. Good 
> idea? Bad idea?  What do you think?

A fellow member (jonny) of drugphish.ch has done such an implementation, which 
he called private[1]. It's based on LSM, has a user space control tool and a 
pretty straightforward configuration file. You might want to have a look at it, 
although it's far from being finished.

> Timothy,
> 
> PS. You can find a short note from the author and the actual patch here:
> http://lwn.net/Articles/60096/  There is also a short article about it 
> in the current weekly edition of LWN if you are a subscriber.

Hmm, interesting. We'll look into merging the remaining CAP_* functionalities 
into the 'private' LSM module. Thanks for the pointer.

[1] http://www.drugphish.ch/~jonny/private.html

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
