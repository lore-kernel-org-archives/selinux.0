Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5R8EY0S012397
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 04:14:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5R8Dkss014160
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 08:13:46 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5R8DihY014157
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 08:13:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: various policy fixes: suexec and user content, apache2 reload, mount and locales
Date: Fri, 27 Jun 2003 18:14:21 +1000
References: <1056693151.11057.47.camel@columbia>
In-Reply-To: <1056693151.11057.47.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306271814.21264.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Jun 2003 15:52, Colin Walters wrote:
> First, I have a setup that looks like this:
>
> (root):walters:sysadm_r:sysadm_t@monk> lc /var/www/verbum.org/autonet/
> drwxr-xr-x  walters  walters  walters:object_r:httpd_user_script_ro_t .
> drwxr-xr-x  walters  walters  walters:object_r:httpd_user_content_t ..
> drwxr-xr-x  walters  walters  walters:object_r:httpd_user_script_rw_t data
> -rwxr-xr-x  walters  walters  walters:object_r:httpd_user_script_exec_t
> moin.cgi -rw-r--r--  walters  walters 
> walters:object_r:httpd_user_script_ro_t moin_config.py -rw-r--r--  walters 
> walters  walters:object_r:httpd_user_script_ro_t moin_config.pyc

Seems reasonable.

> moin.cgi is exec'ed by suexec, which in this case needs to be able to
> { search getattr } httpd_user_script_ro_t in order to access it.  A
> patch to macros/program/apache_macros.te is attached.

I've put an equivalent change into my tree.

> Second, "/etc/init.d/apache2 reload" apparently talks to apache2 over HTTP,
> so I added the ability for httpd_t to connect to httpd_t.  A patch to
> domains/program/apache.te is attached.

OK.

> Thirdly, I have LANG=en_US.UTF-8 (as I do on all my machines), and I
> noticed mount was accessing stuff in locale_t.  But since mount isn't
> i18n-ized, I just added some dontaudit rules for the locale bits.  Patch
> to domains/program/mount.te is attached.

I think it's best to permit those.  If an administrator wants to see mount 
messages in a foreign language then we should support it.  So I have put in 
allow rules in the macro file.

NB  It will probably be quite some time before my Apache policy gets accepted 
by the NSA.  I've made a lot of changes, some of which make upgrades 
difficult.  I think it's the right thing to do however, and it seems that you 
are happy with the result too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
