Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB91Wb9b017090
	for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2009 20:32:42 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nB91VVj3018107
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 01:31:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: tun/tap and SE Linux in 2.6.32
Date: Wed, 9 Dec 2009 12:32:24 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912091232.26387.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


----------  Forwarded Message  ----------

Subject: selinux permissive blocking tun/tap device creation in v2.6.32
Date: Wed, 9 Dec 2009
From: Andrew Worsley <amworsley@gmail.com>
To: luv-main@luv.asn.au

I upgraded to the v2.6.32 kernel and I found tunctl would fail with
the  ioctl TUNSETIFF rejected with an EINVAL. A real pain when running
vpn and kvms which use these.

I don't know where to go from this - so directions as to where to post
/ look would be appreciated but at least I can now create tap
interfaces.

I am looking for suggestions where I should post this to find a fix or
other better work around than merely commenting out this code...

   Andrew

I eventually traced this via recompiling the tun module with tracing
to this code:


            printk(KERN_INFO "tun: tun_set_iff () 10\n");
                if (!capable(CAP_NET_ADMIN))
                        return -EPERM;
            printk(KERN_INFO "tun: tun_set_iff () 11\n");
#if 0
                err = security_tun_dev_create();
                if (err < 0)
                        return err;
#endif

            printk(KERN_INFO "tun: tun_set_iff () 12\n");
                /* Set dev type */
                if (ifr->ifr_flags & IFF_TUN) {
                        /* TUN device */

in drivers/net/tun.c (commenting out the above allows the tunctl
command to work!)

Tracing this back a bit I think it's this code:

int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
                 u32 requested, struct common_audit_data *auditdata)
{
        struct av_decision avd;
        int rc;

        rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
        avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
        return rc;
}

in security/selinux/avc.c which doesn't check for permissive mode or
sellinux disabled as other code in the same file appears to.

I believe this is called from:

static int selinux_tun_dev_create(void)
{
        u32 sid = current_sid();

        /* we aren't taking into account the "sockcreate" SID since the socket
         * that is being created here is not a socket in the traditional 
sense,
         * instead it is a private sock, accessible only to the kernel, and
         * representing a wide range of network traffic spanning multiple
         * connections unlike traditional sockets - check the TUN driver to
         * get a better understanding of why this socket is special */

        return avc_has_perm(sid, sid, SECCLASS_TUN_SOCKET, TUN_SOCKET__CREATE,
                            NULL);
}
 in security/selinux/hooks.c

-------------------------------------------------------

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
