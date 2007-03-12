Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2C1hAwh016496
	for <selinux@tycho.nsa.gov>; Sun, 11 Mar 2007 21:43:10 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2C1h91S024191
	for <selinux@tycho.nsa.gov>; Mon, 12 Mar 2007 01:43:09 GMT
Subject: Re: Problems with login from serial port.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0703102125r205f725bs89242fdf00480662@mail.gmail.com>
References: <e739902b0703102125r205f725bs89242fdf00480662@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 01:43:35 +0000
Message-Id: <1173663815.29664.31.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-03-10 at 21:25 -0800, Ryan Bradetich wrote:
> I have been making good progress on my customized policy, but I ran
> into a problem that I do not understand.
[cut]
> Here are the avc message I get when I login in permissive mode:
> 
> audit(1173587017.702:3): avc:  denied  { relabelfrom } for  pid=199
> comm="login" name="ttyS0" dev=hda1 ino=31387
> scontext=system_u:system_r:system_t
> tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file
> 
> audit(1173587017.702:3): avc:  denied  { relabelto } for  pid=199
> comm="login" name="ttyS0" dev=hda1 ino=31387
> scontext=system_u:system_r:system_t
> tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file
[cut]
> I have the following rule in my policy file (I thought this rule will
> have addressed the avc  message):
> 
> allow system_t sysadm_tty_device_t:chr_file { read write ioctl getattr
> setattr relabelto relabelfrom };

Notice that the scontext is "system_u::" and the tcontext is "root::".
You are hitting the constraint which requires that the SELinux user of
the domain doing the relabeling to match the SELinux user of the object:

constrain dir_file_class_set { create relabelto relabelfrom } 
(
	u1 == u2

	or t1 == can_change_object_identity
);

So you want domain_obj_id_change_exemption(system_t) to pass this
constraint.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
