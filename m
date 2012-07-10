Message-ID: <1341935990.16964.52.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SEAndroid: Labels of files in /data/data/APPDIR/lib directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal =?UTF-8?Q?Ma=C5=A1ek?= <michal.masek@circletech.net>
Cc: selinux@tycho.nsa.gov, "Craig, Robert P." <rpcraig@tycho.ncsc.mil>
Date: Tue, 10 Jul 2012 11:59:50 -0400
In-Reply-To: <4FFC4ED0.8040509@circletech.net>
References: <4FFC34C1.7000803@circletech.net>
	 <1341929590.16964.22.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFC4ED0.8040509@circletech.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 17:48 +0200, Michal Mašek wrote:
> On 07/10/2012 04:13 PM, Stephen Smalley wrote:
> > The /data/data/APPDIR directory should be labeled with the
> > app_data_file
> > type (not system_data_file as in your avc denials above) and the same
> > category assigned to the app process (i.e. :c38 in the above denial).
> 
> The /data/data/APPDIR is labeled with the app_data_file
> type as you say it should be:
> # ls -lZ /data/data/
> ...
> drwxr-x--x app_38 app_38 u:object_r:app_data_file:s0:c38 net.circletech.cc
> 
> However the /data/data/APPDIR/lib and everything in it is labeled with
> type system_data_file:
> # ls -lZ /data/data/net.circletech.cc/
> drwxr-xr-x system system u:object_r:system_data_file:s0 lib
> 
> 
> > The fact that it is instead system_data_file suggests that you
> > installed
> > the app when not running SE Android and did not erase and reflash your
> > data partition.
> 
> I have built the SEAndroid from sources as full_maguro-eng and I am
> running it on Galaxy Nexus. I cleared the cache and userdata before
> flashing the system. Getenforce says that the SELinux is running in
> permissive mode.
> 
> I checked the /data/data directory before installation and the directory
> of our application is not there. Than I installed the application via
> "adb install" and the directory was created with the above mentioned
> labels. I also tried to download the apk file through the android web
> browser and installed it from Downloads app but it had the same effect.
> 
> 
> Btw. i randomly checked directories of some of the system apps and the
> lib subdirectory is always labeled with the system_data_file type, eg.:
> # ls -lZ /data/data/com.android.providers.contacts/
> drwxrwx--x app_0    app_0  u:object_r:app_data_file:s0:c0 databases
> drwxrwx--x app_0    app_0  u:object_r:app_data_file:s0:c0 files
> drwxr-xr-x system   system u:object_r:system_data_file:s0 lib
> drwxrwx--x app_0    app_0  u:object_r:app_data_file:s0:c0 shared_prefs
> 
> 
> Isn't it possible that during installation the lib directory is created
> somewhere else, somewhere where it would be labeled with
> system_data_file type and than moved to /data/data/APPDIR with its label
> intact? Or maybe there is something else I am missing?

Sorry, my mistake.  We label the lib subdirectories with
system_data_file because Android assigns the system UID to them rather
than the app UID to them.  So the label is correct, and you just need to
adjust your policy.  If you look at app.te, you'll see an app_ndk
boolean that is supposed to allow third party apps to execute shared
objects from their data directories.  But it appears that the rule is
incorrectly written in terms of app_data_file rather than
system_data_file.  So switch the type in that rule and then enable that
policy boolean via SEManager and you should be good to go.  You could
also be more selective by putting your app in a more specific domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
