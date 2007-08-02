Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72EFwCD022913
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 10:15:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72EFuPD022827
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:15:56 GMT
Message-ID: <46B1E719.500@redhat.com>
Date: Thu, 02 Aug 2007 10:15:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@tanso.net>
CC: selinux@tycho.nsa.gov
Subject: Re: setroubleshooter/sealert on central loghost?
References: <911f42990707310750r349d11c4x9132c68d83cf8cfc@mail.gmail.com>
In-Reply-To: <911f42990707310750r349d11c4x9132c68d83cf8cfc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jan-Frode Myklebust wrote:
> We run a centralized syslog server, and separate all syslogged avc
> into a separate log file. Is it possible to have setroubleshooter/sealert
> use this log file ?
>
> Also it would be nice if one could get the correct "Host Name" in
> the setroubleshhot browser and alerts. Guess that also will have
> to be added to the avc-log lines is some format.. I tried faking it
> with:
>
> type=AVC msg=audit(1185725759.359:2945): avc:  denied  { search } for
> pid=2077 hostname="my.hostname.com" comm="snmpd" name="fs" dev=proc
> ino=4026531869 scontext=system_u:system_r:snmpd_t:s0
> tcontext=system_u:object_r:sysctl_fs_t:s0 tclass=dir
>
> But the troubleshooter doesn't pick up the hostname. Any ideas ?
>
>
>  -jf
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>   
If you keep the logs separate you can use sealert on the log files.

sealert -a logfile



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
