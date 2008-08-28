Date: Fri, 29 Aug 2008 01:06:57 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, paul.moore@hp.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: add boundary support and thread context
 assignment
In-Reply-To: <48B6555D.3000206@ak.jp.nec.com>
Message-ID: <alpine.LRH.1.10.0808290106060.24081@tundra.namei.org>
References: <487C7698.60503@ak.jp.nec.com>  <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>  <487D5A3D.6090801@ak.jp.nec.com>  <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>  <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
  <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>  <4897EB5A.1040404@ak.jp.nec.com>  <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>  <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com> <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil>
 <48B2A669.7040800@ak.jp.nec.com> <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org> <48B6555D.3000206@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Aug 2008, KaiGai Kohei wrote:

> This feature requires a new policy version.
> The 24th version (POLICYDB_VERSION_BOUNDARY) enables to ship them into
> kernel space, and the following patch enables to handle it.
> 
> Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

This should appear in linux-next within 24 hrs and be tested there.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
