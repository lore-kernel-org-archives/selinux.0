To: SELinux@tycho.nsa.gov
From: Jan-Frode Myklebust <janfrode@tanso.net>
Subject: Re: setroubleshooter/sealert on central loghost?
Date: Sun, 5 Aug 2007 22:57:35 +0200
Message-ID: <slrnfbcedv.43r.mykleb@lc4eb8045376502.ibm.com>
References: <911f42990707310750r349d11c4x9132c68d83cf8cfc@mail.gmail.com> <46B1E719.500@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2007-08-02, Daniel J Walsh <dwalsh@redhat.com> wrote:

> If you keep the logs separate you can use sealert on the log files.
>
> sealert -a logfile

This kind of works if I add a "type=AVC" to the syslogged lines, 
but sealert doesn't show the hostname of the host that sent the
AVC. Any ideas for how to get the "Host Name" field in the sealert
browser to show the hostname ? What's the format sealert expects it
on ? 

If I can find the format, I can probably have syslog-ng insert
it into the log entries.


  -jf


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
