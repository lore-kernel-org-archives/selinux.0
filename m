Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2TISvli017287
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 14:28:57 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2TITe45002994
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 18:29:40 GMT
Received: by vws10 with SMTP id 10so1480222vws.12
        for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 11:28:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4B91403D.6010402@redhat.com>
References: <4B91403D.6010402@redhat.com>
Date: Mon, 29 Mar 2010 14:28:55 -0400
Message-ID: <a0e63a5b1003291128h298fc294pcef00dd38d1cd2ff@mail.gmail.com>
Subject: Re: MLS Now working in Fedora 12/RHEL6 in Full Desktop mode.
From: Tyler Durvik <phangbyte@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is great news.  Is there any installation docs on this or is it
as simple as:

installing the policy
updating SELinux config file
touch /.autorelabel
reboot

Thank you



On Fri, Mar 5, 2010 at 1:32 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> selinux-policy-3.6.32-99.fc12 on Fedora 12
>
> I did remove setroubleshoot and abrt, since these are really not appropriate
> with an MLS machine.
> Everything else is a straight install.
>
> My account logs in as user_t.
>
> Only AVC I am seeing now is
>
>
> allow user_t xserver_t:x_screen { saver_hide saver_setattr saver_show };
>
>
> I think this is caused by the screen saver kicking in.
>
> and
>
> #============= pulseaudio_t ==============
> #!!!! This avc is a constraint violation.  You will need to add an attribute
> to either the source or target type to make it work.
>
> allow pulseaudio_t device_t:dir read;
>
>
> Which is caused because the /dev/snd directory gets created as SystemHigh.
> I have no idea why.  I need to investigate who is creating the directory.
>
> Matchpathcon says it is supposed to be SystemLow.  It must be a SystemHigh
> process that creates it.
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
