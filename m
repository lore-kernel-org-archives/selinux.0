Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA21885
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 06:13:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA17106
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 10:11:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA17096 for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 10:11:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Mark =?iso-8859-1?q?M=FCller?= <trusted@web.de>, selinux@tycho.nsa.gov
Subject: Re: Direct logins (via local and ssh) as httpd_admin_r?
Date: Thu, 29 Aug 2002 12:12:53 +0200
References: <200208290944.g7T9ikX09394@mailgate5.cinetic.de>
In-Reply-To: <200208290944.g7T9ikX09394@mailgate5.cinetic.de>
MIME-Version: 1.0
Message-Id: <20020829101253.AAF656D11@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Aug 2002 11:44, Mark Müller wrote:
> > Do you have the following in your rbac file?
> > allow system_r httpd_admin_r;
>
> Bingo! Thanks for the fast answer Direct logins are now possible, but
>
> a role change with newrole -r back to user_r does not work. Its curious:

Do you have "allow httpd_admin_r user_r;" ???

> newrole just quits with error: chsid
>
> The log says:
>
> avc:  denied  { relabelto } for  pid=785 exe=/usr/local/selinux/bin/newrole
> path=/1 dev=00:07 ino=3 scontext=webadmin:httpd_admin_r:httpd_admin_t
> tcontext=webadmin:object_r:httpd_admin_devpts_t tclass=chr_file

It appears that newrole is running as httpd_admin_t, so therefore as it's not 
running in newrole_t it can't do anything interesting.

>From newrole.te:
domain_auto_trans(userdomain, newrole_exec_t, newrole_t)

httpd_admin_t is not a "userdomain".

Also httpd_admin_r is not permitted to have domain newrole_t.

I think that httpadm.te is a bad idea, it was written long before I solved 
the problems of multiple user domains which allow this to be solved in a much 
better fashion.  I suggest replacing the contents of httpadm.te with 
something like the following:
full_user_role(httpd_admin)
allow system_r httpd_admin_r;
allow sysadm_r httpd_admin_r;
allow user_r httpd_admin_r;
Then followed by appropriate allow lines for httpd_config_t etc.
Or you could put the above in the httpd_admin_domain() macro.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
