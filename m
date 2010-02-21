Date: Mon, 22 Feb 2010 09:09:09 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, method@manicmethod.com,
        Jacques Thomas <jthomas@cs.purdue.edu>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libsepol: remove dead code in
 check_avtab_hierarchy_callback()
In-Reply-To: <4B7B2F15.5020909@ak.jp.nec.com>
Message-ID: <alpine.LRH.2.00.1002220908560.17293@tundra.namei.org>
References: <4AF71B05.8030707@cs.purdue.edu>  <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>  <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>  <4B14934F.9050401@cs.purdue.edu>  <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
  <4B54339F.8070501@ak.jp.nec.com> <4B5685EC.1000500@ak.jp.nec.com>  <4B6BAFD0.2050607@ak.jp.nec.com>  <1265381454.18100.50.camel@moss-pluto.epoch.ncsc.mil>  <4B7104C9.30903@ak.jp.nec.com>  <4B7A04C6.9020808@ak.jp.nec.com> <1266333947.5252.51.camel@moss-pluto.epoch.ncsc.mil>
 <4B7B2F15.5020909@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Feb 2010, KaiGai Kohei wrote:

> > I'd say we revert the changeset and restore the prior behavior.
> > I don't think we should impose the latter convention on policy writers.
> 
> OK, fair enough for me.
> 
> This patch revert the commit of 7d52a155e38d5a165759dbbee656455861bf7801
> which removed a part of type_attribute_bounds_av as a dead code.
> However, at that time, we didn't find out the target side boundary allows
> to handle some of pseudo /proc/<pid>/* entries with its process's security
> context well.
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
