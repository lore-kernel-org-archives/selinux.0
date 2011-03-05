Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p25NWUmm020010
	for <selinux@tycho.nsa.gov>; Sat, 5 Mar 2011 18:32:31 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p25NWRAi008659
	for <selinux@tycho.nsa.gov>; Sat, 5 Mar 2011 23:32:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: [SELinux] Wildcard for object classes?
Date: Sun, 6 Mar 2011 10:32:20 +1100
Cc: debian-security@lists.debian.org, Simon Brandmair <sbrandmair@gmx.net>
References: <ii11vf$vns$02$1@news.t-online.com>
In-Reply-To: <ii11vf$vns$02$1@news.t-online.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201103061032.21143.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 29 Jan 2011, Simon Brandmair <sbrandmair@gmx.net> wrote:
> I just started looking into SELinux. I am wondering if there is a way to
> have wildcards in avc rules like:
> auditallow source_t target_t : * * ;
> which audits all access from source_t to target_t.
> 
> Or do I have to add all classes objects to the rule like:
> auditallow source_t target_t : {appletalk_socket, association,
> blk_file ... } * ;

No, there isn't such a wildcard at this time (AFAIK).  It might be worth 
adding one so I've moved this discussion to the SE Linux upstream mailing list 
(please don't CC debian-security on future replies).

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
