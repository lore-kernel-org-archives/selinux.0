Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0KKVYRb027166
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 15:31:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0KKUMxr003175
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 20:30:22 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0KKTsYc003054
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 20:30:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: Capabilities in SELinux
Date: Wed, 21 Jan 2004 07:29:38 +1100
References: <400D6C11.8030003@ipen.br>
In-Reply-To: <400D6C11.8030003@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401210729.38164.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jan 2004 04:57, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> I have a doubt about the use of the capabilities in the SELinux.
>
> Why to use capabilities (setuid, setgid, etc) in the SELinux, if the
> identity of the user is irrelevant ?

The UID of the user is not relevant to SE Linux access controls.  SE Linux 
maintains it's own concept of user "Identity" which is used as part of it's 
process of determining when to grant access.

The UID is important for DAC (Unix permissions).  When running SE Linux you 
will often want to have two users with different Unix UIDs in the same SE 
Linux role, but not grant them full access to each other's files.  
Restricting setuid and setgid is useful for this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
