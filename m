Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA25939
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 01:52:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA06770
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 06:50:10 GMT
Received: from unicorn.lemuria.org (b067018.adsl.hansenet.de [62.109.67.18])
        by jazzband.ncsc.mil  with ESMTP id GAA06766 for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 06:50:09 GMT
Date: Wed, 30 Oct 2002 07:51:15 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021030075114.D16265@lemuria.org>
References: <20021029204914.B16084@lemuria.org> <Pine.GSO.4.33.0210291500350.29605-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210291500350.29605-100000@raven>; from sds@tislabs.com on Tue, Oct 29, 2002 at 03:07:08PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 29, 2002 at 03:07:08PM -0500, Stephen Smalley wrote:
> mysqld_db_t is assigned to /var/lib/mysql.  mysqld_log_t is assigned to
> /var/log/mysql.*.   So I'm not clear as to why a log file would be
> created in /var/lib/mysql.  

Neither am I. As I said: For some reason it works for me with this
line, and it doesn't without. I will be checking this in more detail
over the next days and submit a better patch.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
