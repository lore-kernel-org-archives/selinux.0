Subject: Re: Need Help with security: ebitmap: map size 0 does not match my
 size  64 (high bit was 4)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: waqar afridi <afridi.waqar@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <AANLkTinBSFB6IQCU2BEbYIu1NY_fGSVDwD0BNLZJXC7x@mail.gmail.com>
References: <AANLkTinBSFB6IQCU2BEbYIu1NY_fGSVDwD0BNLZJXC7x@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 May 2010 15:58:49 -0400
Message-ID: <1274212729.8879.171.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-17 at 12:24 +0500, waqar afridi wrote:
> Hello All
> 
> I am trying to port trisys reference policy on my Openmoko Software
> Stack, When ever I try to load it I get the Following error
> 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> root@om-gta02 ~/refpolicy $ make load
> Loading configured modules.
> /usr/sbin/semodule -s refpolicy
> -b /usr/share/selinux/refpolicy/base.pp
<snip>
> security: ebitmap: map size 0 does not match my size 64 (high bit was
> 4)
> libsepol.sepol_module_package_read: invalid module in module package
> (at section 0)
> libsemanage.semanage_load_module: Error while reading from module
> file /etc/selinux/refpolicy/modules/tmp/modules/unconfined.pp.
> /usr/sbin/semodule:  Failed!
>  
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Reference Policy Version: 2008 04 02
> 
> semodule from: policycoreutils-2.0.55
> 
> Any Suggestion what could be the Problem???

I haven't seen that error previously.  It implies that the unconfined.pp
module was incorrectly compiled or somehow corrupted.

Is it reproducible with a more modern selinux userspace and refpolicy?
http://userspace.selinuxproject.org/trac/wiki/Releases
http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
