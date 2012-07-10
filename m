Message-ID: <1341929590.16964.22.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SEAndroid: Labels of files in /data/data/APPDIR/lib directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal =?UTF-8?Q?Ma=C5=A1ek?= <michal.masek@circletech.net>
Cc: selinux@tycho.nsa.gov, "Craig, Robert P." <rpcraig@tycho.ncsc.mil>
Date: Tue, 10 Jul 2012 10:13:10 -0400
In-Reply-To: <4FFC34C1.7000803@circletech.net>
References: <4FFC34C1.7000803@circletech.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 15:57 +0200, Michal Mašek wrote:
> Hi,
> 
> I am trying to make our application operational under
> SEAndroid. Currently the application produces "open" and "execute"
> denials when it is loading its dynamic libraries from
> /data/data/APPDIR/lib directory:
> 
> <5>[ 3913.711395] type=1400 audit(1341923463.083:9): avc:  denied  {
> open } for  pid=1832 comm="t.circletech.cc" name="libsdl-1.2.so"
> dev=mmcblk0p12 ino=578446 scontext=u:r:untrusted_app:s0:c38
> tcontext=u:object_r:system_data_file:s0 tclass=file
> 
> <5>[ 3913.711730] type=1400 audit(1341923463.083:10): avc:  denied  {
> execute } for  pid=1832 comm="t.circletech.cc"
> path="/data/data/net.circletech.cc/lib/libsdl-1.2.so" dev=mmcblk0p12
> ino=578446 scontext=u:r:untrusted_app:s0:c38
> tcontext=u:object_r:system_data_file:s0 tclass=file
> 
> 
> My guess is that these libraries should have a different label. Such
> that the application is allowed to load them. But which one? And how to
> change it? I tried to change the policy (file_contexts), but it had no
> effect (it seems that files in the lib directory are relabeled during
> installation).

The /data/data/APPDIR directory should be labeled with the app_data_file
type (not system_data_file as in your avc denials above) and the same
category assigned to the app process (i.e. :c38 in the above denial).
The fact that it is instead system_data_file suggests that you installed
the app when not running SE Android and did not erase and reflash your
data partition.  Or maybe you installed the app from the recovery
console?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
