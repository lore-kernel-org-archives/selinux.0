Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l63BFtu4005113
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 07:15:55 -0400
Received: from server.engineering.idb (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l63BFqgQ010997
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 11:15:53 GMT
Message-ID: <468A2FE2.5000903@aus-city.com>
Date: Tue, 03 Jul 2007 21:15:46 +1000
From: David Cottle <webmaster@aus-city.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Can someone please assist me with selinux issue
References: <20070521095414.832619201@tresys.com>	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>	 <1180137749.10334.18.camel@localhost.localdomain>	 <4677F1BC.2000201@tresys.com>	 <1182443353.11527.50.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>	 <1182449086.11527.80.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>	 <1182449898.11527.83.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>	 <1182450900.11527.88.camel@localhost.localdomain>	 <467AE59E.2050501@tycho.nsa.gov>	 <1182525734.3014.20.camel@localhost.localdomain>	 <467BFF99.9000404@tycho.nsa.gov>	 <1182540624.6599.5.camel@localhost.localdomain>	 <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com>	 <1183386217.16330.0.camel@localhost.locald! omain>	 <46896D88.7060504@tresys.com> <1183425133.32465.16.camel@code.and.org>
In-Reply-To: <1183425133.32465.16.camel@code.and.org>
Content-Type: multipart/mixed;
 boundary="------------050307030307040608070301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050307030307040608070301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I got a ftp session from a IP camera sending images every 1 minute.

I keep getting these AVC messages in /var/logs/messages:

Jul  1 04:43:40 server kernel: audit(1183229020.232:8256): avc:
denied  { link } for  pid=2043 comm="in.proftpd"
scontext=system_u:system_r:ftpd_t:s0
tcontext=system_u:system_r:ftpd_t:s0 tclass=key
Jul  1 04:44:40 server kernel: audit(1183229080.245:8257): avc:
denied  { link } for  pid=2061 comm="in.proftpd"
scontext=system_u:system_r:ftpd_t:s0
tcontext=system_u:system_r:ftpd_t:s0 tclass=key
Jul  1 04:45:40 server kernel: audit(1183229140.367:8258): avc:
denied  { link } for  pid=2259 comm="in.proftpd"
scontext=system_u:system_r:ftpd_t:s0
tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=key
Jul  1 04:46:40 server kernel: audit(1183229200.238:8259): avc:
denied  { link } for  pid=2267 comm="in.proftpd"
scontext=system_u:system_r:ftpd_t:s0
tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=key

Every time there is a transfer.  So at 1 minute intervals there are
too many.  Also I want to add more webcams so no doubt its going to
get worse.

However I read and created a policy:

grep proftpd /var/log/messages | audit2allow -M proftpd
selinux -i proftpd.pp


However the above I STILL get the annoying AVC denied messages.

Can someone please explain and tell me how can I update and get rid of
the denied messages?

This is the proftpd.te rule it made:

module proftpd 1.0;

require {
    type ftpd_t;
    type crond_t;
    type httpd_suexec_t;
    class capability dac_override;
    class key { write search };
}

#============= ftpd_t ==============
allow ftpd_t crond_t:key search;
allow ftpd_t httpd_suexec_t:key search;
allow ftpd_t self:capability dac_override;
allow ftpd_t self:key { write search };


But I see crond, httpd and ftpd all there but this rule does nothing :(

I also

Thanks!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGii/ii1lOcz5YUMgRAn/rAKCnY3qmgNoYKd6t77OTHc834Yx6NQCgsAAF
lwnIP6dBcXqqKfyoYg90yoI=
=x4nB
-----END PGP SIGNATURE-----


--------------050307030307040608070301
Content-Type: text/x-vcard; charset=utf-8;
 name="webmaster.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="webmaster.vcf"

begin:vcard
fn:David Cottle
n:Cottle;David
email;internet:webmaster@aus-city.com
title:Webmaster
version:2.1
end:vcard


--------------050307030307040608070301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
