Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JDsP2k005167
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 09:54:25 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JDsMk7013441
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 13:54:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: Is SELinux appropriate for my use?
Date: Fri, 19 May 2006 23:54:27 +1000
Cc: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>,
        selinux@tycho.nsa.gov
References: <446A0CE9.6020708@gmail.com> <446CD37D.1020500@gmail.com> <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
In-Reply-To: <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605192354.31161.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 19 May 2006 17:08, Valdis.Kletnieks@vt.edu wrote:
> (Aside for the list - anybody know why ftp.te in the 2.2.40 strict policy
> has:
>
> corecmd_exec_bin(ftpd_t)
> corecmd_exec_sbin(ftpd_t)
> # Execute /bin/ls (can comment this out for proftpd)
> # also may need rules to allow tar etc...
> corecmd_exec_ls(ftpd_t)
>
> I know why ftpd's traditionally need /bin/ls - what are exec_bin and
> exec_sbin there for?)

Traditionally ftp servers (IE the wuftpd) has supported "get file.gz" and
"get directory.tar.gz" and the FTP server would have to execute programs 
from /bin and /usr/bin accordingly.  This means that for the full ftpd 
functionality corecmd_exec_bin is required.

As for sbin, I'm not sure about that.

Incidentally I still don't think that we need separation of sbin_t and bin_t.  
The choice of which programs go in which directories is rather arbitrary and 
is not based on security criteria.  We have no expectation that sbin_t and 
bin_t will have different integrity (the system integrity entirely depends on 
the integrity of both those types) and we also expect that there is no secret 
data labeled with either of those types.  So it seems to me that making 
sbin_t and ls_exec_t both aliases for bin_t would be the correct thing to do.


PS  Valdis, if you want to send email to me directly then you need to send it 
through a mail server on a fixed IP address.  My mail server will reject 
connections from any machine that is in a dialup range.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
