Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22367
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 14:50:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA06059
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:48:12 GMT
Received: from unicorn.lemuria.org (b067018.adsl.hansenet.de [62.109.67.18])
	by jazzswing.ncsc.mil  with ESMTP id TAA06055
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:48:11 GMT
Date: Tue, 29 Oct 2002 20:49:14 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021029204914.B16084@lemuria.org>
References: <20021028161207.B8537@lemuria.org> <Pine.GSO.4.33.0210291407460.29605-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210291407460.29605-100000@raven>; from sds@tislabs.com on Tue, Oct 29, 2002 at 02:16:52PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 29, 2002 at 02:16:52PM -0500, Stephen Smalley wrote:
> >+allow initrc_t mysqld_db_t:dir { write };
> 
> I'm not clear as to the purpose of this rule in isolation.  Without other
> directory permissions (e.g. add_name, remove_name), directory write
> permission is useless.  What exactly is the rc script doing to this
> directory?

If I remember correctly, it's tee'ing any errors during startup to an
error log file that is located there. I'm working on this anyway, so if
you don't feel happy with it, just wait until I have a more refined
policy to offer. For some reason, though, adding this rule makes it
work on my system.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
