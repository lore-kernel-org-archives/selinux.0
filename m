Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k84IKEGX009956
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 14:20:14 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k84IJq79016644
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 18:19:52 GMT
Subject: Re: refpolicy updates from debian
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157161065.9799.28.camel@wintermute.xmldesign.de>
References: <1157161065.9799.28.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 14:21:49 -0400
Message-Id: <1157394109.3199.234.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-09-02 at 03:37 +0200, Erich Schubert wrote:
> Attached is a diff with the changes in my modified policy for Debian.
> You probably won't like some of it (netuser), or prefer a different
> approach, but there are also some fixes in there that should go into the
> main branch.
> some are no brainers (e.g. slapd location in debian; you might want to
> do an ifdef around that one however) The /dev/.static/dev/ stuff is a
> bit ugly, I know. But it'll hose udev otherwise.

- changed fsadm_var_log_t to fsadm_log_t
- dropped netuser
- rearranged several additions
- dropped dev/.static/dev/ stuff.  please put in distro_debian
- please make a more descriptive name for usbmodules_var_lib_t.  maybe
usbmodules_ids_t?
- why does crond_t transition to amavis? why not system_crond_t?
- why does system_crond_t connect to mysql?

The remainder should be merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
