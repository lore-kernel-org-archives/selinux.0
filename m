Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1CNsEPI008012
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 18:54:14 -0500
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1CNtPij016795
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 23:55:25 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1CNtOUw011716
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 18:55:24 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1CNtODF300488
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 18:55:24 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1CNtNw8021223
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 18:55:24 -0500
Subject: Deleting xfrms
From: Joy Latten <latten@austin.ibm.com>
To: jmorris@namei.org, vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Content-Type: text/plain
Date: Mon, 12 Feb 2007 17:39:57 -0600
Message-Id: <1171323597.2603.445.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was looking at a patch D.Miller posted for xfrm_audit_log()
and could not help but notice that in pfkey_spddelete() and
xfrm_get_policy() we delete policy first and then check to see if we
have permissions to.  Am I missing the original intentions or 
is this incorrect?  Shouldn't it be check the permissions first and then
call xfrm_policy_bysel_ctx()? 

pfkey_spddelete() in af_key.c:

        xp = xfrm_policy_bysel_ctx(XFRM_POLICY_TYPE_MAIN,
pol->sadb_x_policy_dir-1,
                                   &sel, tmp.security, 1);
        security_xfrm_policy_free(&tmp);

        xfrm_audit_log(audit_get_loginuid(current->audit_context), 0,
                       AUDIT_MAC_IPSEC_DELSPD, (xp) ? 1 : 0, xp, NULL);

        if (xp == NULL)
                return -ENOENT;

        err = 0;

        if ((err = security_xfrm_policy_delete(xp)))
                goto out;
        c.seq = hdr->sadb_msg_seq;
        c.pid = hdr->sadb_msg_pid;
        c.event = XFRM_MSG_DELPOLICY;
        km_policy_notify(xp, pol->sadb_x_policy_dir-1, &c);


xfrm_get_policy() in xfrm_user.c is very similar.

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
