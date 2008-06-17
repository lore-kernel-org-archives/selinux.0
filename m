Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HE9NJM014971
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 10:09:23 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5HE9MF0027912
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 14:09:23 GMT
Received: by fg-out-1718.google.com with SMTP id 16so3514928fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 07:09:21 -0700 (PDT)
Message-ID: <cadfc0e40806170709y76e78ee4pb29c26900a6f7bff@mail.gmail.com>
Date: Tue, 17 Jun 2008 09:09:21 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "T S" <t_mail@mail2Airport.com>
Subject: Re: Question about XACE/X-SELinux
Cc: selinux@tycho.nsa.gov
In-Reply-To: <07a701c8d078$b15798a0$046a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <07a701c8d078$b15798a0$046a010a@mail2world.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 17, 2008 at 7:50 AM, T S <t_mail@mail2airport.com> wrote:
> Hello,
>
> I just want to try functionalities X-SELinux, such as prohibiting cut and
> paste.
> Since the below changelog(URL) says X-SELinux functionalities are turned off
> by default,
> I think I need to turn on at first.
> I appreciate someone tell me how to turn on.
>> http://lwn.net/Articles/283539/
>
> I am using Fedora Core9, xorg-server-Xorg-1.4.99.902-3.20080612,
> and GNOME( meaning just after FC9 and yum update).
>
> I thought X-SELinux functionalities are turned on by default in FC9,
> so I tried the below steps.
> 1) setsebool xserver_object_manager=true
> 2) insert loadable module like below. because I was expecting
> some avc logs were generated if I tried cut and paste.
>
>> policy_module(test, 1.0.0)
>> gen_require(`
>> attribute domain;
>> class x_synthetic_event { send receive };
>>')
>>auditallow domain domain:x_synthetic_event {send receive};
>
> 3) setenforce 1
> 4) reboot GNOME( init 3 and init 5)
> 5) trying cut&paste from a window to others. No avclogs are found.
> Only found "Loading extension SELinux" in /var/log/Xorg.0.org.
>
> I appreciate someone tell me what I am missing here.
>
> Regards,
> K
>
>
> Need cash? Click to get an emergency loan, bad credit ok
>
> _______________________________________________________________
> Get the FREE email that has everyone talking at http://www.mail2world.com
> Unlimited Email Storage – POP3 – Calendar – SMS – Translator – Much More!

Add this to xorg.conf

Section "Extensions"
        Option     "SELinux" "Enable"
EndSection

Thr default enforcing state is Permissive.

Add this to set Enforcing state in X

Section "Module"
      SubSection "extmod"
                Option "SELinux Enforcing"
      EndSubSection
EndSection

Add this to have the X Enforcing mode track the system enforcing state

Section "Module"
      SubSection "extmod"
                Option "SELinux TrackSystem"
      EndSubSection
EndSection

xdpyinfo will tell you if the SELinux extension is enabled.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
