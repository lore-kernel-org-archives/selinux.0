Message-ID: <435EA036.7000707@redhat.com>
Date: Tue, 25 Oct 2005 17:14:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>
Subject: Re: [PATCH] libsetrans
References: <36282A1733C57546BE392885C0618592D3A092@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592D3A092@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:
> The following proposed patch to libsetrans incorporates the following
> changes:
>
> - Make libsetrans generic by creating a setrans config file
> - Add translation config file for MLS policy
> - Fix to handle translation for same level range string without separate
> definition (e.g. SystemHigh-SystemHigh)
> - move libsetrans disable option from translation config file
> (mcs.conf/mls.conf) to setrans config file
> - Some comment updates for mcs.conf
>
> -Chad
>
>   
How about instead of adding another config file, we default the file to 
the current policy that is installed.

/etc/selinux/setrans_mls.conf and /etc/selinux/setrans_targeted.conf

libselinux already reads config file so this will require no additional 
perms, or we just put them into the policy file.

/etc/selinux/TYPE/setrans.conf

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
