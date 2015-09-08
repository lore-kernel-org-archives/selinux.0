Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_got_some_problems_with_the_type?=
 =?UTF-8?Q?=5ftransition_rules?=
To: kuangjiou <kuangjiou@huawei.com>, Dominick Grift <dac.override@gmail.com>
References: <60ABE64B4BE4AC45964F1A967BA76CB201F75356@SZXEMI502-MBS.china.huawei.com>
 <20150907161449.GA12835@x250>
 <60ABE64B4BE4AC45964F1A967BA76CB201F75392@SZXEMI502-MBS.china.huawei.com>
 <20150908071443.GA4191@x250>
 <60ABE64B4BE4AC45964F1A967BA76CB201F753E5@SZXEMI502-MBS.china.huawei.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55EEF7AA.30201@tycho.nsa.gov>
Date: Tue, 8 Sep 2015 10:58:50 -0400
MIME-Version: 1.0
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB201F753E5@SZXEMI502-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/08/2015 05:06 AM, kuangjiou wrote:
> According to this webpage，
> http://selinuxproject.org/page/TypeRules
> 
> Policy versions 25 and above also support a 'name transition' rule
> 
> But the policy versions of my os is 26，I don't know why the type_trasition rule didn't work

To see what version is supported by your kernel:
cat /selinux/policyvers or
cat /sys/fs/selinux/policyvers
(depending on where you have selinuxfs mounted)

Make sure you don't have CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
set in your kernel .config.  That was a legacy option for backward
compatibility with Fedora 3 and 4, and forces the kernel to an old
policy version.  You don't want it.
