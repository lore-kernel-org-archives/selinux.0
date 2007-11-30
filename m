Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUDnbwQ025250
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 08:49:37 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUDnZdh013057
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 13:49:35 GMT
Date: Fri, 30 Nov 2007 14:49:33 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Martin Orr <martin@martinorr.name>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
Message-ID: <20071130134933.GA11780@bobek.pm.i.cz>
References: <20071126144547.GA334@bobek.pm.i.cz> <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <474F1BD4.2010908@martinorr.name>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 29, 2007 at 08:06:44PM +0000, Martin Orr wrote:
> On 27/11/07 18:49, Christopher J. PeBenito wrote:
> > On Mon, 2007-11-26 at 15:45 +0100, Václav Ovsík wrote:
> >> Hi,
> >> Debian Etch, refpolicy HEAD, udev produces during startup (udevsettle)
> >> wile creating symlinks into /dev/disk/by-uuid/...
> >> following:
> >>
> >> audit(1195744042.060:3): avc:  denied  { relabelfrom } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> >> audit(1195744042.060:4): avc:  denied  { relabelto } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
> >>
> >> Attached patch solves this.
> >> Can be merged into refpolicy please?
> > 
> > This is interesting, it isn't seen on other distros.  Perhaps it has to
> > do with the way debian sets up tmpfs /dev before udev starts?
> 
> I get similar messages: note that the contexts being relabelled from and to
> are the same.
> 
> I had a look, and the symlinks are created by udev running in the initramfs,
> then the tmpfs /dev is mount --moved into the main root.  No labelling is
> done yet because no policy has been loaded.  Then when the main udev starts
> up it replays the coldplug events.  When it comes to create the symlink
> again, it notices that it is already there and calls lsetfilecon.

Hmm, you hit the nail on its head :)

> Should udev or libselinux be checking whether it will be relabelling files
> to their existing label?  And indeed, it's not clear to me why udev should
> be calling lsetfilecon on existing symlinks at all.
> 
> -- 
> Martin Orr

I tried to execute udevd with --verbose in startup script and this is
the result:

    [840] udev_db_get_device: no db file to read /dev/.udev/db/\x2fdevices\x2fxen\x2fvbd-2049: No such file or directory
    [840] run_program: 'vol_id --export /dev/.tmp-8-1'
...
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_USAGE=filesystem'
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_TYPE=ext3'
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_VERSION=1.0'
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_UUID=0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_UUID_ENC=0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_LABEL='
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_LABEL_ENC='
    [840] run_program: '/lib/udev/vol_id' (stdout) 'ID_FS_LABEL_SAFE='
    [840] run_program: '/lib/udev/vol_id' returned with status 0
    [840] udev_rules_get_name: add symlink 'disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] udev_rules_get_name: no node name set, will use kernel name ''
    [840] udev_device_event: device '/block/sda1' already in database, cleanup
    [840] name_index: removing index: '/dev/.udev/names/sda1/\x2fblock\x2fsda1'
    [840] name_index: removing index: '/dev/.udev/names/disk\x2fby-uuid\x2f0fb8bc6a-db49-4a7e-a030-268373a933d9/\x2fblock\x2fsda1'
    [840] udev_node_add: creating device node '/dev/sda1', major=8, minor=1, mode=0660, uid=0, gid=6
    [840] udev_node_mknod: preserve file '/dev/sda1', because it has correct dev_t
    [840] name_index: creating index: '/dev/.udev/names/disk\x2fby-uuid\x2f0fb8bc6a-db49-4a7e-a030-268373a933d9/\x2fblock\x2fsda1'
    [840] name_index: creating index: '/dev/.udev/names/sda1/\x2fblock\x2fsda1'
    [840] udev_node_update_symlinks: update symlink 'disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9' of '/block/sda1'
    [840] udev_db_get_devices_by_name: found index directory '/dev/.udev/names/disk\x2fby-uuid\x2f0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] update_link: found 1 devices with name 'disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] update_link: found '/block/sda1' for 'disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] update_link: compare (our own) priority of '/block/sda1' 0 >= 0
    [840] update_link: 'disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9' with target 'sda1' has the highest priority 0, create it
    [840] node_symlink: found existing symlink '/dev/disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9'
    [840] node_symlink: preserve already existing symlink '/dev/disk/by-uuid/0fb8bc6a-db49-4a7e-a030-268373a933d9' to '../../sda1'
    audit(1196406913.936:3): avc:  denied  { relabelfrom } for  pid=840 comm="udevd" name="0fb8bc6a-db49-4a7e-a030-268373a933d9" dev=tmpfs ino=2009 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=syst
    em_u:object_r:device_t:s0 tclass=lnk_file
    ^Maudit(1196406913.936:4): avc:  denied  { relabelto } for  pid=840 comm="udevd" name="0fb8bc6a-db49-4a7e-a030-268373a933d9" dev=tmpfs ino=2009 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=syst
    em_u:object_r:device_t:s0 tclass=lnk_file
    ^M[840] pass_env_to_socket: passed -1 bytes to socket '/org/kernel/udev/monitor', 
    [840] udev_event_run: seq 355 finished with 0
...

Corresponding code is in udev_node.c, function node_symlink().

...
    if (strcmp(target, buf) == 0) {
	    info("preserve already existing symlink '%s' to '%s'", slink, target);
	    selinux_setfilecon(slink, NULL, S_IFLNK);
	    goto exit;
    }
...

Regards
-- 
Zito


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
