Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o67BECHt030957
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 07:14:12 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o67BDGRd025842
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2010 11:13:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 2/3]libsepol
Date: Wed, 7 Jul 2010 21:14:06 +1000
Cc: selinux@tycho.nsa.gov
References: <1278455010-23244-1-git-send-email-justinmattock@gmail.com> <1278455010-23244-3-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1278455010-23244-3-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201007072114.07279.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Jul 2010, "Justin P. Mattock" <justinmattock@gmail.com> wrote:
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1050,7 +1049,6 @@ int hidden sepol_load_policy(void *data, size_t len)
>         /* Install the new policydb and SID table. */
>         memcpy(policydb, &newpolicydb, sizeof *policydb);
>         sepol_sidtab_set(sidtab, &newsidtab);
> -       seqno = ++latest_granting;
>  
>         /* Free the old policydb and SID table. */
>         policydb_destroy(&oldpolicydb);

Is latest_granting used for anything else?  If it's not being used then it 
should be removed too.  If it is being used then failing to increment it 
breaks something.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
