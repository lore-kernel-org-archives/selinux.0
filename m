Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3N6GJI4000153
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 02:16:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3N6GJ7R001015
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 06:16:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3N6G8KP001000 for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 06:16:13 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 1FD5CBF3D
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:15:57 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 30195-09
 for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:15:55 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id AEBE3BF11
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:15:55 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3B95E924A3
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:15:55 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0197079AD
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:15:55 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: Re: A different view of the Theo de Raadt funding question
Date: Wed, 23 Apr 2003 16:15:55 +1000
References: <sea5bbd3.074@atlas.snu.edu>
In-Reply-To: <sea5bbd3.074@atlas.snu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304231615.55047.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Apr 2003 03:43, Matthew S. Hamrick wrote:
> Mi amigo Larry Cohen has posted a story at cryptonomicon.net with
> speculation that the real reason OpenBSD's funding got cut was because
> of competition from TrustedBSD and SELinux. While it's not a technical
> issue, I thought it might be interesting to readers of this list.

That could be part of it.  However I think that there are good reasons for 
funding all three projects.

Note that OpenSSH is widely used on SE Linux and FreeBSD and there is no 
viable alternative to it.  Other software that is developed on or for OpenBSD 
is also widely used on Linux and FreeBSD systems.

I have not reviewed the details of the research that DARPA was funding on 
OpenBSD, but I would be very surprised if it could not either be ported to SE 
Linux and TrustedBSD systems or used as a point of comparison with those 
systems.

It is well known that various agencies of the US government have all currently 
available OSs in use in production environments.  I am sure that it can be 
demonstrated that improving the security of any OS benefits some parts of the 
US government.

On Wed, 23 Apr 2003 13:01, Joshua Brindle wrote:
> especially since there wasn't even that much left. IMO Theo is an idiot for
> talking about the government and DoD while recieving a grant from them,
> talk about biting the hand that feeds you. I appreciate the government for
> acting the way they did toward someone who obviously wasn't grateful.

One thing that people should keep in mind is that he wasn't really hurting the 
US government (more important people criticise it in more public ways and get 
more press).  He was hurting the people inside DARPA who advocated him.

Someone inside DARPA is probably regretting that they stood up at a committee 
meeting and said that OpenBSD was worthy of receiving a grant.  This may 
affect their actions when there are funding discussions related to other open 
source projects, and this can't be good for any of us.  Hopefully they will 
realise that most Linux and FreeBSD people are not like Theo and learn to 
recognise the small minority who are.

If Theo had a serious issue with receiving money from the US government then 
he could have abstained from requesting it.  From what I know of such things 
DARPA doesn't surprise people with gifts of money, they have to go to some 
effort to request it.  Theo could have avoided such effort and requested that 
other contributers to OpenBSD do the same.

In case someone was thinking of the "freedom of speech issue", when someone 
offers you money you are free to say "no thanks".


PS  Please note that I made no mention of my own political opinions in this 
message as this list is entirely the wrong place to discuss such things.  
Anyone who is interested in discussing such things can contact me privately.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
