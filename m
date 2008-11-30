Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAUIsqaq028665
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 13:54:52 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAUIspt6027671
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 18:54:52 GMT
Received: by wa-out-1112.google.com with SMTP id j5so1046764wah.18
        for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 10:54:51 -0800 (PST)
Subject: Re: PAM _pam_load_conf_file: unable to open /etc/pam.d/system-auth
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40811300858se04e43drc13cc96b0812e810@mail.gmail.com>
References: <1228008307.4582.10.camel@unix>
	 <cadfc0e40811300858se04e43drc13cc96b0812e810@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 30 Nov 2008 10:54:47 -0800
Message-Id: <1228071287.3418.7.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2008-11-30 at 10:58 -0600, Xavier Toth wrote:
> On Sat, Nov 29, 2008 at 7:25 PM, Justin P. Mattock
> <justinmattock@gmail.com> wrote:
> > Hello;
> > after loading the latest policycoreutils
> > I'm experiencing a bit of difficulties trying
> > to understand how to set:
> > /etc/selinux/newrole_pam.conf
> > (what do I put in there?)
> > I have: /usr/bin/aterm /etc/pam.d/test
> > in there, and in
> > /etc/pam.d/test I have:
> > auth required /lib/security/pam_unix.so
> >
> > but, unfortunantly receive a no password error
> > when wanting to change roles.
> >
> > after looking at auth.log I see a:
> > newrole: PAM _pam_load_conf_file: unable to open /etc/pam.d/system-auth
> >
> > If I make: /etc/pam.d/system-auth
> > newrole will work perfectly until
> > I go and write the allow rules,
> > and put the policy into enforcing mode.
> >
> > What or were do I find the info on what
> > to put in /etc/selinux/newrole_pam.conf
> > and so forth to have this new way
> > for newrole work?
> >
> > regards;
> >
> > --
> > Justin P. Mattock <justinmattock@gmail.com>
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> man newrole
> 
> newrole_pam.conf contains mappings of applications to pam
> configuration files to be used. Each line contains the executable file
> name followed by the name of a pam config file that exists in
> /etc/pam.d.

"shit", right under my nose!!
newrole -r user_r -- -c /usr/bin/aterm /etc/pam.d/*
works. 

-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
