Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h71DWlHa008677
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 09:32:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h71DVZFB008606
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 13:31:35 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h71DVYGD008603
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 13:31:34 GMT
Subject: Re: Query about LSM and RSBAC
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Hemal Namdev Rathod <g0201743@nus.edu.sg>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <566434CAC4E2F9429329880BEA2266C45D95D4@MBXSRV23.stu.nus.edu.sg>
References: <566434CAC4E2F9429329880BEA2266C45D95D4@MBXSRV23.stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1059744761.1052.356.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Aug 2003 09:32:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-01 at 03:12, Hemal Namdev Rathod wrote:
> I am relatively a new user of the SELinux system. I have been reading
> papers on both SELinux and Linux Security Module (LSM). Could anybody
> tell me what are the advantages of using LSM over RSBAC( Rule set based
> access control) if any. Also is RSBAC Turing complete? If it is then
> doesn't it make a stronger system than LSM? Also could anyone tell me
> what are the disadvantages of RSBAC that makes it not so popular as
> compared to LSM and Selinux.

LSM seeks to provide a lightweight, general framework for access control
that can be used by the various Linux security projects (e.g. SELinux,
RSBAC, DTE, etc) to implement their specific security architectures and
models as kernel modules.  LSM isn't tied to a specific security
architecture, such as the Flask architecture used by SELinux or the GFAC
architecture used by RSBAC.  LSM provides the necessary infrastructure
to support these security projects, while avoiding tying the kernel to a
specific security model.  It was created in response to guidance from
Linus as to what he would be willing to accept into the mainline Linux
kernel, and most of the LSM patch was merged into 2.5 and will be
available in 2.6.

SELinux was originally implemented as its own kernel patch, like RSBAC.
SELinux provides a flexible mandatory access control architecture
(Flask) and some specific security models (RBAC, TE, MLS).  However,
when the LSM project began, the SELinux project contributed to the
development of the LSM kernel patch and reworked SELinux to be a
security module that uses the LSM framework, because our goal has been
to gain support in the mainline Linux kernel for flexible MAC
functionality.  Since LSM is now integrated into the mainline kernel,
SELinux will be supported by mainline 2.6 kernels without any invasive
patching.

As far as I know, RSBAC is still implemented as its own kernel patch
rather than using LSM.  I think that the author of RSBAC did post a few
messages regarding RSBAC's requirements when LSM was being designed, but
that he was unable to actively participate in the LSM development due to
time limitations.  If I recall correctly, he expressed an intent to port
RSBAC to LSM once it stabilized and was accepted into the mainline Linux
kernel, so he may plan on doing that if/when he ports RSBAC to Linux
2.6.

Comparing RSBAC and LSM doesn't make much sense, as LSM just provides
the security infrastructure to support security modules, and you should
be able to implement RSBAC as a module that uses LSM.  It is possible
that LSM doesn't include every security hook needed for RSBAC at present
since the RSBAC project wasn't actively involved in the development of
LSM, but any such hooks can likely be added as long as they can be
justified (i.e. they provide real benefit and are not redundant with
already existing hooks) and fall within the scope of LSM (i.e. access
control functionality).

You can compare the security architecture and functionality of RSBAC
with SELinux.  There was a thread on this list comparing SELinux and
RSBAC a long time ago - see the mailing list archives, an unofficial
archive at http://marc.theaimsgroup.com/?l=selinux is probably the
easiest to search.  That discussion was based on a comparison of the
original SELinux kernel patch and the RSBAC kernel patch, so it doesn't
include any discussion of LSM and is somewhat dated, but it does provide
some insights into how SELinux and RSBAC differ.  The author of RSBAC
was involved in that discussion, so both sides were represented.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
