Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2IbeRb017123
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 13:37:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2IbdqY010836
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 18:37:39 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB2Ibb0o010828 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 18:37:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris Vanden Berghe <vbc@zurich.ibm.com>
Subject: Re: selinux-policy-default
Date: Wed, 3 Dec 2003 05:37:34 +1100
Cc: selinux@tycho.nsa.gov
References: <3FCC831A.1070002@zurich.ibm.com> <200312030159.41676.russell@coker.com.au> <3FCCAEA2.2040703@zurich.ibm.com>
In-Reply-To: <3FCCAEA2.2040703@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312030537.34475.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Dec 2003 02:24, Chris Vanden Berghe <vbc@zurich.ibm.com> wrote:
> Hi,
>
> >/etc/selinux is a sym-link to /usr/share/selinux/policy/current/ and is
> >created on installation of the selinux-policy-default package.
>
> I don't have '/usr/share/selinux/policy/current/' either, but I do have
> '/usr/share/selinux/policy/default/'.  Should I link /etc/selinux to
> this '.../default/' dir?

No.  Copy what you want from the default directory to the current directory 
then make a symlink.  Having the symlink point to the default directory won't 
do any good.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
