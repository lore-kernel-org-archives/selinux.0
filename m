Subject: Re: refpolicy HEAD, Debian, restorecon from udev startup script
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: SELinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20071122153201.GA6768@bobek.pm.i.cz>
References: <20071122153201.GA6768@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 26 Nov 2007 15:20:19 -0500
Message-Id: <1196108419.20918.43.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-22 at 16:32 +0100, Václav Ovsík wrote:
> Hi,
> I'm trying refpolicy r2530, policycoreutils 2.0.27 on Debian Etch.
> 
> There is restorecon called in /etc/init.d/udev script during startup
> to relabel /dev tmpfs filesystem. /dev/console has context
> system_u:object_r:tmpfs_t at this time, so the following message appears:
> 
> audit(1195734177.391:3): avc:  denied  { read write } for  pid=778 comm="restorecon" name="console" dev=tmpfs ino=702 scontext=system_u:system_r:setfiles_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=chr_file
> 
> With attached patch message disappears.
> Can be this merged into HEAD? (Maybe only for Redhat & Debian)

I added this for distro_debian.

> Are next two macros for Redhat needed?
> 
>         fs_relabel_tmpfs_blk_file(setfiles_t)
> 	fs_relabel_tmpfs_chr_file(setfiles_t)
> 
> Doesn't this covered by dev_relabel_all_dev_nodes(setfiles_t) already?

files_relabel_all_files() gives relabelfrom.  So the above two lines
effectively add relabelto.  However I don't think this is needed, so
they are probably unneeded.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
