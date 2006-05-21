Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4L7xgnc014622
	for <selinux@tycho.nsa.gov>; Sun, 21 May 2006 03:59:43 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4L7xb7l018112
	for <selinux@tycho.nsa.gov>; Sun, 21 May 2006 07:59:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: Is SELinux appropriate for my use?
Date: Sun, 21 May 2006 17:59:40 +1000
Cc: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>,
        selinux@tycho.nsa.gov
References: <446A0CE9.6020708@gmail.com> <200605192354.31161.russell@coker.com.au> <200605210347.k4L3lwl9012271@turing-police.cc.vt.edu>
In-Reply-To: <200605210347.k4L3lwl9012271@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605211759.45312.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 21 May 2006 13:47, Valdis.Kletnieks@vt.edu wrote:
> > > I know why ftpd's traditionally need /bin/ls - what are exec_bin and
> > > exec_sbin there for?)
> >
> > Traditionally ftp servers (IE the wuftpd) has supported "get file.gz" and
> > "get directory.tar.gz" and the FTP server would have to execute programs
> > from /bin and /usr/bin accordingly.  This means that for the full ftpd
> > functionality corecmd_exec_bin is required.
>
> OK.. so exec_bin is there because nobody has done the work to tag tar/zcat
> similar to the existing tagging of /bin/ls.

I don't think that we want to go down that path.  Having separate rules for 
every program that wants to call tar or gzip will be painful and cause 
pointless increases in policy size.

> > Incidentally I still don't think that we need separation of sbin_t and
> > bin_t. The choice of which programs go in which directories is rather
> > arbitrary and is not based on security criteria.  We have no expectation
> > that sbin_t and bin_t will have different integrity (the system integrity
> > entirely depends on the integrity of both those types) and we also expect
> > that there is no secret data labeled with either of those types.  So it
> > seems to me that making sbin_t and ls_exec_t both aliases for bin_t would
> > be the correct thing to do.
>
> I agree that sbin_t and bin_t should be merged - the original bin vs sbin
> distinction was that "user stuff in bin, stuff used by admins in sbin". But
> then stuff like 'ping' ended up in sbin and blurred things.

Ping is in /bin on my system, ping would not blur things in the case of SE 
Linux because it has it's own type for other (and better) reasons.

> I'm not sure if ls_exec_t should go - the alternative is to also tag 'tar'
> and 'zcat' and whatever else is needed by FTP servers that support the
> automagic .tar.gz stuff.

If bin_t and sbin_t should be merged (as I believe they should) then ls_exec_t 
should definitely go!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
