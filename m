Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DM6YiK017861
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 18:06:34 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DM5r0h011027
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 22:05:53 GMT
In-Reply-To: <20061013213819.37747.qmail@web36601.mail.mud.yahoo.com>
References: <20061013213819.37747.qmail@web36601.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D817779A-2E7B-4EEC-A906-89FE94E9C0BC@nall.com>
Cc: selinux@tycho.nsa.gov
From: Joe Nall <joe@nall.com>
Subject: Re: context_sensitivity_{get|set}
Date: Fri, 13 Oct 2006 17:06:10 -0500
To: casey@schaufler-ca.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 13, 2006, at 4:38 PM, Casey Schaufler wrote:


>
> In the Unix MLS world everyone calls the
> hierarchical part the level and the whole
> thing the label. It is entirely possible
> that such usage is incorrect.

That has been my conversational experience, however the HP  
(Secureware) header has this fugly construction (C++ didn't like this  
any more than the similar issue in avc.h I reported earlier). The cat  
array was dynamically sized with post struct padding.

typedef struct mand_ir {
         class_ir_t      class;
         mask_t          cat[1];
}  mand_ir_t;


joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
