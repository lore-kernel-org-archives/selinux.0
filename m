Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i526CJrT001919
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 02:12:20 -0400 (EDT)
Received: from smtp808.mail.sc5.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52E6obn011826
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 10:06:51 -0400 (EDT)
Date: Tue, 1 Jun 2004 23:27:11 -0700 (PDT)
From: Richard Sharpe <rsharpe@richardsharpe.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: XP as a base for NetTop
In-Reply-To: <20040601201928.GQ5690@lkcl.net>
Message-ID: <Pine.LNX.4.58.0406012325541.6983@durable>
References: <BCDBA110.10B6A%edm@tycho.ncsc.mil> <40B67F41.6020309@snu.edu>
 <1086111584.13325.111.camel@moss-spartans.epoch.ncsc.mil> <20040601201928.GQ5690@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Jun 2004, Luke Kenneth Casson Leighton wrote:

>  NT security descriptors contain four ACLS:
>
>  - a system mandatory acl
>  - a system discretionary acl
>  - a [user?] mandatory acl
>  - a [user?] discretionary acl

This does not appear to be correct. From rpc_secdesc.h in source/include

typedef struct security_descriptor_info
{
        uint16 revision; /* 0x0001 */
        uint16 type;     /* SEC_DESC_xxxx flags */

        uint32 off_owner_sid; /* offset to owner sid */
        uint32 off_grp_sid  ; /* offset to group sid */
        uint32 off_sacl     ; /* offset to system list of permissions */
        uint32 off_dacl     ; /* offset to list of permissions */

        SEC_ACL *dacl; /* user ACL */
        SEC_ACL *sacl; /* system ACL */
        DOM_SID *owner_sid;
        DOM_SID *grp_sid;

} SEC_DESC;

Regards
-----
Richard Sharpe, rsharpe[at]richardsharpe.com, rsharpe[at]samba.org,
sharpe[at]ethereal.com, http://www.richardsharpe.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
