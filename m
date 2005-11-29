Message-ID: <438C8A3C.5070904@redhat.com>
Date: Tue, 29 Nov 2005 12:05:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: SELinux@tycho.nsa.gov, Jason Vas Dias <jvdias@redhat.com>
Subject: Re: Bug (?) in cvs selinux policy
References: <1132968448.701.1.camel@wintermute.xmldesign.de>
In-Reply-To: <1132968448.701.1.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Erich Schubert wrote:
> Hi,
> while merging the current policy CVS in my local policy, I noticed this:
> ---
> tail -1 domains/program/unused/dhcpc.te
> allow dhcpc_t locale_t:file write;
> ---
>
> Why? If this is some locale caching or so, it probably should be
> use_locale(dhcpc_t) or something like that. But this single write here
> is really odd...
>
> best regards,
> Erich Schubert
>   
I think this allows it to cp the locale file into the chroot environment.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
