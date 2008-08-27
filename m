Subject: Re: [LTP][PATCH 1/2] Replacement of deprecated interfaces
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@namei.org>, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <48B50A97.8050404@ak.jp.nec.com>
References: <487C7698.60503@ak.jp.nec.com>
	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>
	 <487D5A3D.6090801@ak.jp.nec.com>
	 <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil>
	 <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com>
	 <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com>
	 <4897EB5A.1040404@ak.jp.nec.com>
	 <1217940793.2994.52.camel@moss-spartans.epoch.ncsc.mil>
	 <48997937.8050105@ak.jp.nec.com>  <48A3E0E8.4000902@ak.jp.nec.com>
	 <1218824000.29535.315.camel@moss-spartans.epoch.ncsc.mil>
	 <48B2A669.7040800@ak.jp.nec.com>
	 <alpine.LRH.1.10.0808262015360.6838@tundra.namei.org>
	 <alpine.LRH.1.10.0808262046000.6838@tundra.namei.org>
	 <48B50A97.8050404@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 08:14:16 -0400
Message-Id: <1219839256.5708.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-08-27 at 17:04 +0900, KaiGai Kohei wrote:
> James Morris wrote:
> > Could you also please add tests for this (at least one which should fail 
> > and one which should succeed) to the Linux Test Project?
> > 
> > 
> > - James
> 
> Policies stored in ltp/testcases/kernel/security/selinux-testsuite/refpolicy/
> invokes massive deprecated interfaces on selinux-policy-3.5.4.
> 
> This patch fixes them according to the warning messages which encourage to
> replace older ones.
> 
> BTW, I'm not happy with the test_policy.pp does not allow to invoke test
> scripts from unconfined_t domain. Is it to be fixed?

I don't quite follow.  Did you follow the instructions in the
selinux-testsuite README?  I can run the test scripts either using the
test_selinux.sh script or by manually loading the policy and then
individually running them as described in the README.  Watch out that
your patch doesn't disturb the existing misc/sbin_deprecated.patch that
gets applied by test_selinux.sh.  Keep in mind that this testsuite gets
run on everything from RHEL4 to F9.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
