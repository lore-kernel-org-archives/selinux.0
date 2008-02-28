Message-ID: <47C728D1.7010205@redhat.com>
Date: Thu, 28 Feb 2008 16:34:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com> <47C701E8.1030603@tycho.nsa.gov> <1204224665.31790.179.camel@moss-spartans.epoch.ncsc.mil> <200802281617.17223.sgrubb@redhat.com>
In-Reply-To: <200802281617.17223.sgrubb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steve Grubb wrote:
> On Thursday 28 February 2008 13:51:05 Stephen Smalley wrote:
>> On Thu, 2008-02-28 at 13:48 -0500, Eamon Walsh wrote:
>>> Stephen Smalley wrote:
>>>> On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
>>>>> Eamon Walsh wrote:
>>>>>> The X object manager logs all avc's and status messages (including
>>>>>> the AVC netlink stuff) through the audit system using libaudit calls
>>>>>> (audit_log_user_avc_message, etc.)
> 
> Please tell me they have different record types. Also do you have any samples 
> that we can look over to make sure they conform?
> 
> 
>>>> Can you verify that the X server was able to create the audit socket
>>>> successfully?
>>> Yes, because when I actually install the audit package, things started
>>> appearing in /var/log/audit/audit.log.  I did not have the audit package
>>> installed.  Why isn't it redirecting to /var/log/messages in this case?
> 
> It should be if you have audit enabled. Perhaps you didn't boot with audit=1?
> 
> -Steve

type=USER_AVC msg=audit(1204228505.703:107): user pid=3744 uid=0
auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
msg='avc:  denied  { read } for request=X11:QueryPointer comm=mono
xdevice="Virtual core pointer"
scontext=unconfined_u:unconfined_r:mono_t:s0
tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device
: exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfHKNAACgkQrlYvE4MpobPgrgCcDbVf45Tk9I7QrzbQD5OPeVqP
CE4AnA4DP3V68X7WV01AQVE1VseYKfV8
=YrCL
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
