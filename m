Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA19157
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 18:13:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA20335
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 22:12:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA20331
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 22:12:17 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: problems with fd
Date: Sat, 10 Aug 2002 00:13:01 +0200
References: <001601c23ff0$2d51ed40$0300a8c0@donkey>
In-Reply-To: <001601c23ff0$2d51ed40$0300a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020809221302.54B6F84E7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 10 Aug 2002 00:00, Ryan Bergauer wrote:
> I take that back, I did upgrade from 1.06 to 1.07 since then. That would
> appear to have triggered this.

An upgrade of gpg does not make any difference, all versions of gpg work in 
the same way in this regard.  Unless however you forgot to relabel the new 
gpg after the upgrade and as a result have the gpg process running in a 
different domain.

> The scontext is always the program's context, as in
> user_name:user_r:user_gpg_t.
> The tcontext is how I got my current role, as in
> user_name:sysadm_r:newrole_t or system_u:system_r:local_login_t.
> It's denying the use of fd.
>
> This just popped up - I know I've used GPG before, but never had this
> error. Any suggestions?

Please tell me exactly what you are doing with gpg?

I've just done a quick test and I can't trigger such problems with my policy. 
 Please tell me the exact type of gpg command and how you run it (from xterm 
or console, etc), and which role you are using.  Then I'll try and reproduce 
the problem.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
