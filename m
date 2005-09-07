Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j87DLXOb028249
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 09:21:33 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j87DJJEV008459
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 13:19:26 GMT
Subject: Re: ntp policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <431EDA31.9030502@redhat.com>
References: <1125929266.16388.85.camel@sgc>  <431EDA31.9030502@redhat.com>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 09:21:40 -0400
Message-Id: <1126099300.13223.5.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-07 at 08:16 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> 
> >While converting the ntpd policy over to a reference policy module, I
> >came across a few lines which bring up questions.
[cut]
> >	ifdef(`winbind.te', `
> >	allow ntpd_t winbind_var_run_t:dir r_dir_perms;
> >	allow ntpd_t winbind_var_run_t:sock_file rw_file_perms;
> >	')
> >
> >Generally when using a sock_file, a domain is connecting/sending to
> >another domain over a unix domain socket; however, after doing a few
> >rule searches in apol, I find no evidence that ntpd_t connects/sends to
> >winbind_t.  Is there some other purpose for these rules, or am I missing
> >something?
> >
> Must be from nscd.

I don't understand.  If that is the case, wouldn't it be nscd_var_run_t
instead of winbind_var_run_t?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
