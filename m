Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6G0BqHa020916
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 20:11:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6G0BpH5010795
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 00:11:51 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6G0BlRX010792 for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2003 00:11:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Kerry Thompson" <kerry@crypt.gen.nz>, <selinux@tycho.nsa.gov>
Subject: Re: Policy for Kerberos
Date: Wed, 16 Jul 2003 10:11:37 +1000
References: <1849.202.27.185.71.1058310700.squirrel@www.crypt.gen.nz>
In-Reply-To: <1849.202.27.185.71.1058310700.squirrel@www.crypt.gen.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307161011.37633.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Jul 2003 09:11, Kerry Thompson wrote:
> Attached is my first cut at a policy for Kerberos. This is for the MIT
> Kerberos5 software but should work fine for most for most distros with
> file location tweaking.

# General rules for /etc/krb5.conf
allow user_t krb5_conf_t:file { getattr ioctl read };
allow local_login_t krb5_conf_t:file { getattr ioctl read };
allow sysadm_su_t krb5_conf_t:file { getattr ioctl read };
allow user_su_t krb5_conf_t:file { getattr ioctl read };
allow run_init_t krb5_conf_t:file { getattr read };

Maybe this file should be labeled etc_t as it seems to be read by the same 
programs that read /etc/passwd (presumably for the same reasons).

Also you should not specify user_t in policy, userdomain or unpriv_userdomain 
are more appropriate.

As for the user_su_t, that would require a modification to the su_macros.te 
file with an ifdef(`kerberos.te'.

allow krb5kdc_t tmp_t:dir { add_name remove_name search write };
allow krb5kdc_t tmp_t:file { create getattr read rename unlink write };

Should be:
tmp_domain(krb5kdc)

allow krb5kdc_t var_log_t:dir { add_name search write };
allow krb5kdc_t var_log_t:file { read append create getattr };

Should be:
log_domain(krb5kdc)

Same for kadmin_t, although maybe they should share a log type.

allow krb5kdc_t user_ssh_t:udp_socket { recvfrom };
allow user_ssh_t krb5kdc_t:udp_socket { recvfrom };

This needs to be in the ssh_macros.te file, otherwise it won't work for 
staff_t and other user domains.

Also do you think it would be a good idea to separate kerberos server and 
client policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
