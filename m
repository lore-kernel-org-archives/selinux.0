Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5PLB90S004067
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 17:11:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5PLALss014760
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 21:10:21 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5PLAJhY014745
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 21:10:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: small passwd.te zsh fixes
Date: Thu, 26 Jun 2003 07:10:55 +1000
References: <1056569473.3752.25.camel@columbia>
In-Reply-To: <1056569473.3752.25.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306260710.55224.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 26 Jun 2003 05:31, Colin Walters wrote:
> Hi,
>
> I use zsh, and on my Debian system the setup looks like:
> monk:/home/walters# lc /bin/zsh*
> lrwxrwxrwx  root     root     system_u:object_r:shell_exec_t   /bin/zsh ->
> /etc/alternatives/zsh -rwxr-xr-x  root     root    
> system_u:object_r:shell_exec_t   /bin/zsh-4.0.4 -rwxr-xr-x  root     root  
>   system_u:object_r:shell_exec_t   /bin/zsh4 monk:/home/walters# lc
> /etc/alternatives/zsh
> lrwxrwxrwx  root     root     system_u:object_r:etc_t         
> /etc/alternatives/zsh -> /bin/zsh4

I recently changed my policy to not label such symlinks as shell_exec_t, the 
current version in Debian does this so if you have the latest policy 
installed and relabel /bin it should be fine.

I have just added a change to my policy to allow reading etc_t:lnk_file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
