Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAUGwnda022926
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 11:58:49 -0500
Received: from rv-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAUGujpp018850
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 16:56:46 GMT
Received: by rv-out-0506.google.com with SMTP id g9so2463317rvb.0
        for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 08:58:48 -0800 (PST)
Message-ID: <cadfc0e40811300858se04e43drc13cc96b0812e810@mail.gmail.com>
Date: Sun, 30 Nov 2008 10:58:48 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: PAM _pam_load_conf_file: unable to open /etc/pam.d/system-auth
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1228008307.4582.10.camel@unix>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1228008307.4582.10.camel@unix>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Nov 29, 2008 at 7:25 PM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> Hello;
> after loading the latest policycoreutils
> I'm experiencing a bit of difficulties trying
> to understand how to set:
> /etc/selinux/newrole_pam.conf
> (what do I put in there?)
> I have: /usr/bin/aterm /etc/pam.d/test
> in there, and in
> /etc/pam.d/test I have:
> auth required /lib/security/pam_unix.so
>
> but, unfortunantly receive a no password error
> when wanting to change roles.
>
> after looking at auth.log I see a:
> newrole: PAM _pam_load_conf_file: unable to open /etc/pam.d/system-auth
>
> If I make: /etc/pam.d/system-auth
> newrole will work perfectly until
> I go and write the allow rules,
> and put the policy into enforcing mode.
>
> What or were do I find the info on what
> to put in /etc/selinux/newrole_pam.conf
> and so forth to have this new way
> for newrole work?
>
> regards;
>
> --
> Justin P. Mattock <justinmattock@gmail.com>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

man newrole

newrole_pam.conf contains mappings of applications to pam
configuration files to be used. Each line contains the executable file
name followed by the name of a pam config file that exists in
/etc/pam.d.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
