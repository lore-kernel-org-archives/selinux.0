Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00350
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 14:42:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0LJgNI28581
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 19:42:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0LJgLf28577 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 19:42:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
        tom@lemuria.org
Subject: Re: Apache/mysql policy status ?
Date: Tue, 21 Jan 2003 20:42:11 +0100
References: <200301211848.NAA02352@moss-shockers.ncsc.mil>
In-Reply-To: <200301211848.NAA02352@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301212042.11953.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jan 2003 19:48, Stephen D. Smalley wrote:
> > I'm a bit confused about the current state of the two policies I've
> > worked on. Are they merged with
> > a) the CVS tree
> > b) the Debian default policy?
> >
> > I'm asking because I just noticed that the woody default policy doesn't
> > seem to use them. Was it only merged with sid?
>
> As I recall, we were still waiting final forms of patches for merging
> from you.  Your last message about the mysql policy appears to have
> been http://marc.theaimsgroup.com/?l=selinux&m=103598879429279&w=2,
> where you posted full files for comments and said that you would
> followup with a patch after further testing.  I don't recall seeing
> any comments or a followup patch.  Since it was a major rewrite of
> Russell's original domain, I was also looking for an ACK from him.

The policy as last shown to me did not entirely work in a fashion that I 
liked.

mysqld was permitted to write to var_log_t files and initrc_t was permitted to 
write to mysqld_log_t files.

>From memory I think I got some ideas for policy improvements from the policy 
Tom posted, but didn't have the time to completely go through it.  Also I now 
have a mysql server running fine with the policy I've got and haven't had a 
great incentive to change it.

Tom, I would be happy to look into this again if you send me an updated 
policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
