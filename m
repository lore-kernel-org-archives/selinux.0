Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16AWFRb021757
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 05:32:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16AUsQk016082
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 10:30:54 GMT
Received: from texas.rec.uniba.sk (texas.rec.uniba.sk [158.195.34.3])
	by jazzswing.ncsc.mil  with ESMTP id i16AUrYo016073
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 10:30:53 GMT
Date: Fri, 6 Feb 2004 11:31:54 +0100
From: Tomas Hoger <thoger@pobox.sk>
To: Eric Estabrooks <eric@urbanrage.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: selinux-policy-default
Message-ID: <20040206103154.GA939@moche.atriaky.sk>
References: <40232CBB.7020607@urbanrage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40232CBB.7020607@urbanrage.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Feb 05, 2004 at 11:57:15PM -0600, Eric Estabrooks wrote:
> domains/admin.te:32:ERROR 'unknown type sysadm_locate_t' at token ';' on 
> line 5974:
> allow sysadm_locate_t { sysadm_mozilla_ro_t sysadm_mozilla_rw_t }:dir { 
> getattr
> search };

I came across similar problem yesterday evening.  I think problem is that
*_locate_t domains are not created in user_domain and admin_domain macros.
See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=231343 , there you can
find simple patch which solved problem for me.  Can anyone look at it and
tell if my solution is correct?

th.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
