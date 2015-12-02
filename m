Date: Wed, 2 Dec 2015 22:42:29 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151202214228.GF1028@x250>
References: <20151202101801.GA1028@x250> <565F366E.3030403@tycho.nsa.gov>
 <20151202194715.GC1028@x250> <565F6167.5090507@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <565F6167.5090507@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Dec 02, 2015 at 04:23:51PM -0500, Stephen Smalley wrote:
> 
> So there the systemd access controls wouldn't come into play.
> 
> For confined user roles, systemd-run --user <command> failed on Fedora 22
> with:
> 
> Failed to start transient service unit: Access denied
> 
> and journalctl showed:
> 
> systemd[15007]: Can't send to audit system: USER_AVC avc:  denied  { start }
> for auid=N uid=N gid=N path="/run/user/N/systemd/user/run-PID.service"
> cmdline="systemd-run --user id"
> scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:user_tmp_t:s0 tclass=service
> 
> So removing the systemd --user controls is a regression in the protection
> being provided in Fedora, IIUC, although I'll let the Fedora SELinux
> maintainers speak to that.

Yes and my use case as well becuase like i suggested:

any process that needs to be able to start any system-wide systemd user
unit will be be able to start all of them

currently this might not sound applicable to much but in the future
there will be potentially many of those units and processes will then
start using systemctl --user to control these units. So then this will
be come an issue.

Also keep in mind that users can maintain user units in ~/.config/systemd

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWX2XAAAoJENAR6kfG5xmcrB0MAL8Lwgtm8qrSPpvsiqA/WF4T
J36dx9HFaiu6DSu4/F69TDynvJluiTGPLLZwUUUrJWxl65LxFDhKIXl4fO3MQogv
g5TlBI8dDxiMk0XYO8w32l6ucpGaMmc63ViP/QIfKv8jSXu1ZNZ7ozF1wPr/lahu
aW7bziyHD9FJMKGGHwnj7mnHkKBTqI/m6EI8pyHTzo2rDZXuyzc2jaEGfgKzkuUp
M6GPUGcPIewrMPw+/GduMORezZnmeWYVxl5cpEywf07Z11IYibVmLLPBPMkrt00Q
GgaOrJ3iyYsD9ecbejCqOrlKtna7MRioY/lX8XeMwYMdkZ2Hl4e6lpaC90SI0rMM
zzCGNhK/mXxfptpOhTQ7WqcF3HIDG4ipEQdvGXMrd1MYq3DzXkfbvrJOBsHybvJN
jRJEpjRRgKiweaWcWYa6wv5Eax/VOn64snD0us2nurGiBzr8O87ff6Egk+MitX/d
j3guYA/CfOyp1ZgP6LIHqJbU0eIQSbMSHqf/L5KCjQ==
=Y4Ct
-----END PGP SIGNATURE-----
