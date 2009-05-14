Subject: Re: the problem about  install refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hechao55429 <hechao55429@126.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <27009633.1151091242307171349.JavaMail.coremail@bj126app104.126.com>
References: 
	 <27009633.1151091242307171349.JavaMail.coremail@bj126app104.126.com>
Content-Type: text/plain
Date: Thu, 14 May 2009 09:52:16 -0400
Message-Id: <1242309136.21772.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-05-14 at 21:19 +0800, hechao55429 wrote:
> 
> hello everyone :
>   In the  fedora 10,the selinux policy is  targeted .

Fedora 10 has a merged targeted/strict policy - you can get most of the
behavior of strict policy just by mapping users to confined roles using
semanage or system-config-selinux, and you can completely migrate to
strict policy by removing the unconfined policy module (but that
requires a reboot, and needs to be done in permissive mode).

> But I want to switch it to refpolicy,so I install the refpolicy
> policy ,according to the approach as follows:
> 
> 1.# tar -jxvf refpolicy-20071214.tar.bz2 -C /tmp

The Fedora policy is actually already based on refpolicy, just with a
set of patches and specific configuration settings. You can customize
the Fedora policy to provide strict-like behavior without needing to
perform a complete switch to upstream refpolicy.  Do you really need to
switch to upstream refpolicy for some reason?  If so, at least use a
more recent version than 20071214!  Starting from the
selinux-policy .src.rpm will improve your compatibility with the Fedora
policy,
http://danwalsh.livejournal.com/26428.html

> # cd /tmp/refpolicy
> # make install-src
> 2. 
> 
> Edit the policy build.conf file
> (/etc/selinux/refpolicy/src/policy/buildconf). Near the top of the
> file, the policy has a few build options. The DISTRO option needs to
> be uncommented and set to redhat, and DIRECT_INITRC should be set to
> y. 
> 
> 3.# make install
> 4. Modify the /etc/selinux/config file, and set SELINUXTYPE to
> refpolicy.
>
> 5.# touch /.autorelabel
> # shutdown -r now
> The approach comes from
> http://oss.tresys.com/projects/refpolicy/wiki/UseRefpolicy
> 
> But when I restart the computer,the problem comes forth as follows :
> 
>   Reading all physical volunmes,this may take a while...
> 
> Found volume group "VolGroup00" using Metadata type lvm2
> 
> 2 logical volume(s) in volune group "VolGroup00" now active
> 
> init: rcS main process(515) terminated with status 1
> 
> init: rcS post-stop process(518) terminated with status 1
> 
> it stopped in here and can't restart. can anybody tell me why?

It is likely that the file security contexts on disk left from the
Fedora policy are not valid under the refpolicy that you have built, and
thus are being mapped to unlabeled_t and causing permission denials.

When performing a complete policy switch, you should generally reboot
single-user in permissive mode (enforcing=0 single) and forcibly relabel
your filesystems (fixfiles -F relabel), and then reboot.  Even then
certain mount point directories may need manual relabeling.

But I'm not really sure why you are switching policies here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
