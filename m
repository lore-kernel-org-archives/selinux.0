Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9NNLti6015686
	for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2009 19:21:55 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9NNNgmw021479
	for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2009 23:23:42 GMT
Date: Sat, 24 Oct 2009 10:21:51 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Raul da Silva {Sp4wn} <sp4wn.root@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: SELinux : Project (opinions and suggestions)
In-Reply-To: <d629bb30910221611i4d2c29co4cdc077049d754f2@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.0910241018460.13877@tundra.namei.org>
References: <d629bb30910221611i4d2c29co4cdc077049d754f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Oct 2009, Raul da Silva {Sp4wn} wrote:

> Are you think SELinux need the something specific to help administration
> like a tool ? Or SELinux needs the other things ?
> Ex: AppArmor

Several projects of this kind already exist.

I think that you could do someting challenging and interesting with some 
kind of facility which notices an updated app config (vsftpd, httpd etc.) 
and updates policy to match, within reasonable bounds.

i.e. make it so the admin can modify httpd.conf and SELinux adapts to the 
config file.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
