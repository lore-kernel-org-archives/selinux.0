Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4BF05mp029770
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 11:00:05 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4BF03uh016188
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 15:00:03 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4BExxLq014818
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 11:00:02 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4BExwtU032690
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 10:59:58 -0400
Received: from [10.11.14.56] (vpn-14-56.rdu.redhat.com [10.11.14.56])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4BExvPA017591
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 10:59:57 -0400
Subject: Re: [PATCH] Make sepol_iter_get_data return void
From: Karl MacMillan <kmacmill@redhat.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <1d04713e6b39fcf695ed.1178819012@localhost.localdomain>
References: <1d04713e6b39fcf695ed.1178819012@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 May 2007 10:59:58 -0400
Message-Id: <1178895598.11064.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 13:43 -0400, Karl MacMillan wrote:
> Make sepol_ter_get_data return void and always succeed. This
> is doable because implementors can push all errors into
> sepol_iter_next. Forcing this to always succeed simplifies
> many error paths.
> 
> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"

Merged into policyrep.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
