Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52BCOrT003317
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:12:24 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i53BC8eD028220
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 07:12:08 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 2 Jun 2004 11:12:22 -0000
Date: Wed, 2 Jun 2004 11:09:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Richard Sharpe <rsharpe@richardsharpe.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: XP as a base for NetTop
Message-ID: <20040602110948.GC2960@lkcl.net>
References: <BCDBA110.10B6A%edm@tycho.ncsc.mil> <40B67F41.6020309@snu.edu> <1086111584.13325.111.camel@moss-spartans.epoch.ncsc.mil> <20040601201928.GQ5690@lkcl.net> <Pine.LNX.4.58.0406012325541.6983@durable>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0406012325541.6983@durable>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 11:27:11PM -0700, Richard Sharpe wrote:
> On Tue, 1 Jun 2004, Luke Kenneth Casson Leighton wrote:
> 
> >  NT security descriptors contain four ACLS:
> >
> >  - a system mandatory acl
> >  - a system discretionary acl
> >  - a [user?] mandatory acl
> >  - a [user?] discretionary acl
> 
> This does not appear to be correct. From rpc_secdesc.h in source/include
> 
> typedef struct security_descriptor_info
> {
>         uint16 revision; /* 0x0001 */
>         uint16 type;     /* SEC_DESC_xxxx flags */
> 
>         uint32 off_owner_sid; /* offset to owner sid */
>         uint32 off_grp_sid  ; /* offset to group sid */
>         uint32 off_sacl     ; /* offset to system list of permissions */
>         uint32 off_dacl     ; /* offset to list of permissions */
> 
>         SEC_ACL *dacl; /* user ACL */
>         SEC_ACL *sacl; /* system ACL */
>         DOM_SID *owner_sid;
>         DOM_SID *grp_sid;
> 
> } SEC_DESC;

 hey, i wrote that - five years ago! :)

 thanks for the reminder, and the correction, richard.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
