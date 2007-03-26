Subject: Re: additional change to ipsec policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, paul.moore@hp.com,
        sds@tycho.nsa.gov
In-Reply-To: <200703092207.l29M77Bn023464@faith.austin.ibm.com>
References: <200703092207.l29M77Bn023464@faith.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 11:21:47 -0400
Message-Id: <1174922507.28830.25.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-09 at 18:07 -0400, Joy Latten wrote:
> 
> One more ipsec policy change.
> I don't think setkey, a trusted and sysadm utility should read it's
> config files from regular user's home directories.

Agreed; though this rule is not in upstream refpolicy.

> diff -urpN serefpolicy-2.4.6.orig/policy/modules/system/ipsec.te
> serefpolicy-2.4.6/policy/modules/system/ipsec.te
> --- serefpolicy-2.4.6.orig/policy/modules/system/ipsec.te
> 2007-03-09 16:14:30.000000000 -0600
> +++ serefpolicy-2.4.6/policy/modules/system/ipsec.te    2007-03-09
> 16:15:26.000000000 -0600
> @@ -309,7 +309,6 @@ domain_setcontext(setkey_t)
> 
>  # allow setkey to read a config files in any directory.
>  userdom_read_sysadm_home_content_files(setkey_t)
> -userdom_read_all_users_home_content_files(setkey_t)
> 
>  # setkey will be run by sysadm, thus setkey needs access to sysadm
> ttys.
>  userdom_use_sysadm_ttys(setkey_t)
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
