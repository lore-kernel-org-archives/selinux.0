Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2FDeRb015141
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 10:13:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2FD0p5004228
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:13:00 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB2FCwt0004225
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:12:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@austin.rr.com
Subject: Re: What causes this??
Date: Wed, 3 Dec 2003 02:13:35 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <1070340338.12612.2.camel@hawaii> <200312021549.34383.russell@coker.com.au> <1070376464.13070.127.camel@hawaii>
In-Reply-To: <1070376464.13070.127.camel@hawaii>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312030213.35200.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Dec 2003 01:47, Nick <nagray@austin.rr.com> wrote:
> On Mon, 2003-12-01 at 22:49, Russell Coker wrote:
> > On Tue, 2 Dec 2003 15:45, Nick <nagray@bruzenak.com> wrote:
> > > I just rebuilt a system and when I try to change roles I get this
> > >
> > >
> > > [root@hawaii SELinux]# newrole -r sysadm_r
> > > cannot find your entry in the passwd file.
> > > [root@hawaii SELinux]#
> >
> > Please give us the output of the command "id".  Chances are you are not
> > running in a correct context.
>
> id -c
> system_u:system_r:sysadm_t

Looks like you don't have the pam module enabled as Dale suggests.  You should 
never get a shell in system_u identity of system_r context.  newrole checks 
the identity against the passwd file, and you have no account system_u there 
(and you shouldn't have one).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
