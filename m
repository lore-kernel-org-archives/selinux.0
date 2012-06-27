Message-ID: <1340802780.32737.15.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Denials of changing wallpaper on Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ken.masumitsu@accenture.com
Cc: SELinux@tycho.nsa.gov
Date: Wed, 27 Jun 2012 09:13:00 -0400
In-Reply-To: <1340368300.14703.35.camel@moss-pluto.epoch.ncsc.mil>
References: <4FE43B1B.1030602@accenture.com>
	 <1340368300.14703.35.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-06-22 at 08:31 -0400, Stephen Smalley wrote:
> On Fri, 2012-06-22 at 09:31 +0000, ken.masumitsu@accenture.com wrote:
> > Hi,
> > 
> > I am working SEAndroid 4.0.4 on Galaxy Nexus.
> > 
> > When I tried to change wallpaper, some denials appeared.
> > 
> > ---------------------------------------------------------------------------------------
> > <5>[ 1038.038543] type=1400 audit(1340267126.382:1469): avc:  denied  {
> > write } for  pid=380 comm=42696E646572205468726561642023
> > name="wallpaper" dev=mmcblk0p12 ino=578431 scontext=u:r:system:s0
> > tcontext=u:object_r:wallpaper_file:s0 tclass=file
> > <5>[ 1038.048278] type=1400 audit(1340267126.390:1470): avc:  denied  {
> > write } for  pid=380 comm=42696E646572205468726561642023
> > path="/data/data/com.android.settings/files/wallpaper" dev=mmcblk0p12
> > ino=578431 scontext=u:r:trusted_app:s0:c17
> > tcontext=u:object_r:wallpaper_file:s0 tclass=file
> > ---------------------------------------------------------------------------------------
> > 
> > 
> > Though I added following lines to device/maguro/sepolicy.te,
> > ---------------------------------------------------------------------------------------
> > #============= system ==============
> > # src="system" tgt="wallpaper_file" class="file", perms="write"
> > # comm="2696E64657220546872656164202" exe="" path=""
> > allow system wallpaper_file:file write;
> > 
> > #============= trusted_app ==============
> > # src="trusted_app" tgt="wallpaper_file" class="file", perms="write"
> > # comm="2696E64657220546872656164202" exe="" path=""
> > allow trusted_app wallpaper_file:file write;
> > ---------------------------------------------------------------------------------------
> > 
> > still a denial appeared.
> > ---------------------------------------------------------------------------------------
> > <5>[  508.922760] type=1400 audit(1340350990.015:190): avc:  denied  {
> > write } for  pid=565 comm=42696E646572205468726561642023
> > path="/data/data/com.android.settings/files/wallpaper" dev=mmcblk0p12
> > ino=578429 scontext=u:r:trusted_app:s0:c17
> > tcontext=u:object_r:wallpaper_file:s0 tclass=file
> > ---------------------------------------------------------------------------------------
> > 
> > Do you know that why does the denial appear? and How to resolve it?
> 
> Need to add mlstrustedobject to wallpaper_file in order for apps at any
> level to write to it.
> 
> diff --git a/file.te b/file.te
> index 4e3bd53..eb4c792 100644
> --- a/file.te
> +++ b/file.te
> @@ -54,7 +54,7 @@ type cache_file, file_type, mlstrustedobject;
>  # Default type for anything under /efs
>  type efs_file, file_type;
>  # Type for wallpaper file.
> -type wallpaper_file, file_type;
> +type wallpaper_file, file_type, mlstrustedobject;
>  
>  # All devices have bluetooth efs files. But they
>  # vary per device, so this type is used in per

I applied these changes to our policy, so you should get the updates
when you next sync your copy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
