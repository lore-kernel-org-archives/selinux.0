Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA19245
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 18:31:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA20904
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 22:30:40 GMT
Received: from hawk.mail.pas.earthlink.net (hawk.mail.pas.earthlink.net [207.217.120.22])
	by jazzswing.ncsc.mil  with ESMTP id WAA20900
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 22:30:39 GMT
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: "'Russell Coker'" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: problems with fd
Date: Fri, 9 Aug 2002 17:31:27 -0500
Message-ID: <001b01c23ff4$8081b730$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020809221302.54B6F84E7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The gpg command in question is 'gpg --gen-key', being run from the
console as (in the case of system_u:system_r:local_login_t) a normal
user in user_r and (in the case of user_name:sysadm_r:newrole_t) a
sysadm that newroled into the user_r role.

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Friday, August 09, 2002 5:13 PM
To: Ryan Bergauer; selinux@tycho.nsa.gov
Subject: Re: problems with fd

On Sat, 10 Aug 2002 00:00, Ryan Bergauer wrote:
> I take that back, I did upgrade from 1.06 to 1.07 since then. That
would
> appear to have triggered this.

An upgrade of gpg does not make any difference, all versions of gpg work
in 
the same way in this regard.  Unless however you forgot to relabel the
new 
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

I've just done a quick test and I can't trigger such problems with my
policy. 
 Please tell me the exact type of gpg command and how you run it (from
xterm 
or console, etc), and which role you are using.  Then I'll try and
reproduce 
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
