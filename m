Message-ID: <1347543187.15047.23.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Allow domain access to /dev/ion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <w.roberts@sta.samsung.com>
Cc: William Roberts <bill.c.roberts@gmail.com>,
        "selinux@tycho.nsa.gov"
	 <selinux@tycho.nsa.gov>
Date: Thu, 13 Sep 2012 09:33:07 -0400
In-Reply-To: <E24EB765E1998A40A0C06DE52672C482017B68C84984@staex7mb1.telecom.sna.samsung.com>
References: <1347486228-12390-1-git-send-email-w.roberts@sta.samsung.com>
	 <E24EB765E1998A40A0C06DE52672C482017B68C84984@staex7mb1.telecom.sna.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-09-12 at 16:48 -0500, William Roberts wrote:
> Just wanted to get some feedback before submitting this to AOSP. I think everyone is going to need access to this, it seems to be cropping up more and more. I wrestled with r or rw perms on this, but it looks like rw is the way to go IMO.
> 
> If this gets a blessing Ill submit upstream....

Have you looked at the ion driver to see if any of its operations are
security-sensitive?

> 
> -----Original Message-----
> From: William Roberts [mailto:bill.c.roberts@gmail.com] 
> Sent: Wednesday, September 12, 2012 2:44 PM
> To: selinux@tycho.nsa.gov
> Cc: sds@tycho.nsa.gov; William Roberts
> Subject: [PATCH] Allow domain access to /dev/ion
> 
> Change-Id: I87f81a632ed61f284f2fe09726f5c4529d36f252
> ---
>  domain.te      |    3 +++
>  mediaserver.te |    1 -
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/domain.te b/domain.te
> index 6be7ddd..47ad05a 100644
> --- a/domain.te
> +++ b/domain.te
> @@ -83,6 +83,9 @@ allow domain cache_file:lnk_file read;  allow domain cgroup:dir { search write };  allow domain cgroup:file w_file_perms;
>  
> +#Allow access to ion memory allocation device allow domain 
> +ion_device:chr_file rw_file_perms;
> +
>  # For /sys/qemu_trace files in the emulator.
>  bool in_qemu false;
>  if (in_qemu) {
> diff --git a/mediaserver.te b/mediaserver.te index e124db0..4b299a0 100644
> --- a/mediaserver.te
> +++ b/mediaserver.te
> @@ -25,7 +25,6 @@ allow mediaserver qemu_device:chr_file rw_file_perms;  allow mediaserver sysfs:file rw_file_perms;  # XXX Why?
>  allow mediaserver apk_data_file:file { read getattr }; -allow mediaserver ion_device:chr_file rw_file_perms;
>  
>  # To use remote processor
>  allow mediaserver rpmsg_device:chr_file rw_file_perms;
> --
> 1.7.0.4
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
