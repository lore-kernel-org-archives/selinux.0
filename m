Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1JHds04022627
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 12:39:54 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1JHfAHC029814
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 17:41:10 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joy Latten'" <latten@austin.ibm.com>
Cc: <selinux@tycho.nsa.gov>, <redhat-lspp@redhat.com>, <jmorris@namei.org>
Subject: RE: Deleting xfrms
Date: Mon, 19 Feb 2007 11:37:40 -0600
Message-ID: <000c01c7544c$a87906a0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1171323597.2603.445.camel@faith.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I see this bug crept in here:

http://marc.theaimsgroup.com/?l=linux-netdev&m=114956850915839&w=2

Are you planning to fix this or did you want me to?

> -----Original Message-----
> From: Joy Latten [mailto:latten@austin.ibm.com]
> Sent: Monday, February 12, 2007 5:40 PM
> To: jmorris@namei.org; vyekkirala@TrustedCS.com
> Cc: selinux@tycho.nsa.gov; redhat-lspp@redhat.com
> Subject: Deleting xfrms
> 
> 
> I was looking at a patch D.Miller posted for xfrm_audit_log()
> and could not help but notice that in pfkey_spddelete() and
> xfrm_get_policy() we delete policy first and then check to see if we
> have permissions to.  Am I missing the original intentions or 
> is this incorrect?  Shouldn't it be check the permissions 
> first and then
> call xfrm_policy_bysel_ctx()? 
> 
> pfkey_spddelete() in af_key.c:
> 
>         xp = xfrm_policy_bysel_ctx(XFRM_POLICY_TYPE_MAIN,
> pol->sadb_x_policy_dir-1,
>                                    &sel, tmp.security, 1);
>         security_xfrm_policy_free(&tmp);
> 
>         xfrm_audit_log(audit_get_loginuid(current->audit_context), 0,
>                        AUDIT_MAC_IPSEC_DELSPD, (xp) ? 1 : 0, 
> xp, NULL);
> 
>         if (xp == NULL)
>                 return -ENOENT;
> 
>         err = 0;
> 
>         if ((err = security_xfrm_policy_delete(xp)))
>                 goto out;
>         c.seq = hdr->sadb_msg_seq;
>         c.pid = hdr->sadb_msg_pid;
>         c.event = XFRM_MSG_DELPOLICY;
>         km_policy_notify(xp, pol->sadb_x_policy_dir-1, &c);
> 
> 
> xfrm_get_policy() in xfrm_user.c is very similar.
> 
> Regards,
> Joy
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
