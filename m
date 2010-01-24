Date: Mon, 25 Jan 2010 09:24:04 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Jacques Thomas <jthomas@cs.purdue.edu>,
        SE Linux <selinux@tycho.nsa.gov>, method@manicmethod.com
Subject: Re: [PATCH 1/2] selinux: remove dead code in
 type_attribute_bounds_av()
In-Reply-To: <4B57ED6F.6040803@ak.jp.nec.com>
Message-ID: <alpine.LRH.2.00.1001250923530.25365@tundra.namei.org>
References: <4AF71B05.8030707@cs.purdue.edu>  <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>  <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>  <4B14934F.9050401@cs.purdue.edu>  <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
  <4B54339F.8070501@ak.jp.nec.com>  <4B5685D5.7040307@ak.jp.nec.com> <1263994416.24133.4.camel@moss-pluto.epoch.ncsc.mil> <4B57ED6F.6040803@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Jan 2010, KaiGai Kohei wrote:

> (2010/01/20 22:33), Stephen Smalley wrote:
> > $ make C=2 security/selinux/ss/services.o
> > security/selinux/ss/services.c: In function ?type_attribute_bounds_av?:
> > security/selinux/ss/services.c:524: warning: unused variable ?target?
> > security/selinux/ss/services.c:520: warning: unused variable ?lo_tcontext?
> 
> Sorry, it was fixed.
> 
> --------
> This patch removes dead code in type_attribute_bounds_av().


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
