From: <ken.masumitsu@accenture.com>
To: <SELinux@tycho.nsa.gov>
Subject: Denials of changing wallpaper on Galaxy Nexus
Date: Fri, 22 Jun 2012 09:31:13 +0000
Message-ID: <4FE43B1B.1030602@accenture.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am working SEAndroid 4.0.4 on Galaxy Nexus.

When I tried to change wallpaper, some denials appeared.

---------------------------------------------------------------------------------------
<5>[ 1038.038543] type=1400 audit(1340267126.382:1469): avc:  denied  {
write } for  pid=380 comm=42696E646572205468726561642023
name="wallpaper" dev=mmcblk0p12 ino=578431 scontext=u:r:system:s0
tcontext=u:object_r:wallpaper_file:s0 tclass=file
<5>[ 1038.048278] type=1400 audit(1340267126.390:1470): avc:  denied  {
write } for  pid=380 comm=42696E646572205468726561642023
path="/data/data/com.android.settings/files/wallpaper" dev=mmcblk0p12
ino=578431 scontext=u:r:trusted_app:s0:c17
tcontext=u:object_r:wallpaper_file:s0 tclass=file
---------------------------------------------------------------------------------------


Though I added following lines to device/maguro/sepolicy.te,
---------------------------------------------------------------------------------------
#============= system ==============
# src="system" tgt="wallpaper_file" class="file", perms="write"
# comm="2696E64657220546872656164202" exe="" path=""
allow system wallpaper_file:file write;

#============= trusted_app ==============
# src="trusted_app" tgt="wallpaper_file" class="file", perms="write"
# comm="2696E64657220546872656164202" exe="" path=""
allow trusted_app wallpaper_file:file write;
---------------------------------------------------------------------------------------

still a denial appeared.
---------------------------------------------------------------------------------------
<5>[  508.922760] type=1400 audit(1340350990.015:190): avc:  denied  {
write } for  pid=565 comm=42696E646572205468726561642023
path="/data/data/com.android.settings/files/wallpaper" dev=mmcblk0p12
ino=578429 scontext=u:r:trusted_app:s0:c17
tcontext=u:object_r:wallpaper_file:s0 tclass=file
---------------------------------------------------------------------------------------

Do you know that why does the denial appear? and How to resolve it?

--
Ken Masumitsu


________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
