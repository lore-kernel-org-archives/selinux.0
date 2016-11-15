Subject: Re: load_policy fails to load policy with ENOENT
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 09:58:10 -0500
MIME-Version: 1.0
In-Reply-To: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 07:19 AM, Dominick Grift wrote:
> I finished porting dssp-base to dssp1-base, however when i try
> testing it load_policy fails with ENOENT.
> 
> Even though load_policy returns error status the policy seems to
> be loaded, except that it is not (or so it seems). When i reboot
> the system freezes for whatever reason. Whether it is due to
> systemd refusing due to load_policy failure or anything else i am
> not sure.
> 
> I have double checked the policy.
> 
> 1. secilc has no problems with it 2. the initial sids are declared
> and ordered 3. the classes are there (and the linux classes are
> ordered)
> 
> I cannot think of anything that might cause this and i am looking
> for suggestions.
> 
> It is easy to reproduce:
> 
> 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
> dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
> /etc/selinux/targeted/policy/policy.30 
> /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
> /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
> sestatus, seinfo, ps uaxZ
> 
> I have also uploaded a demo:
> 
> https://youtu.be/8NCME9dLZd4
> 
> Suggestions and help are appreciated

Any dmesg output at the time of the failed load?
What does strace load_policy show?
