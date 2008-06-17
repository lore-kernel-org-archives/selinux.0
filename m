Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HFtSa8010897
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 11:55:28 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5HFtRF0006322
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 15:55:28 GMT
Received: by fg-out-1718.google.com with SMTP id 16so3540464fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 08:55:26 -0700 (PDT)
Message-ID: <cadfc0e40806170855hf95edf4vdefe9b9710cadfb6@mail.gmail.com>
Date: Tue, 17 Jun 2008 10:55:26 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: gnome-screensav AVCs
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>
In-Reply-To: <1213717150.11146.88.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>
	 <1213717150.11146.88.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 17, 2008 at 10:39 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Tue, 2008-06-17 at 09:46 -0500, Xavier Toth wrote:
>> I'm seeing AVCs related to netlink_audit_socket when the screen saver
>> dialog is run. gnome-screensaver-dialog opens a pam session which uses
>> pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
>> gnome-screensaver-dialog is going to need some policy including
>> possibly authlogin_common_auth_domain_template.
>
> I'm not 100% clear, is the auditing happening from unix_chkpwd or the
> screensaver proper?
>

I'm sure that it is unix_chkpwd that is auditing and not
gnome-screensaver-dialog.

>> Would it be best to add policy for this to gnome or should it have
>> it's own module?
>
> The gnome module is for policies for core gnome components.
> Unfortunately "core component" isn't really well defined at the moment.
> But I've been thinking about it since Dan has a gnome clock applet
> policy since it can set the clock.  If we had a better idea what pieces
> needed their own domain, it'd be easier to make a decision.  Something
> like dbus doesn't fit since its useful outside of gnome.

Yes there may be other gnome apps that need policy but I don't know
which at this point.

>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
