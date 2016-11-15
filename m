Message-ID: <1479223847.11104.12.camel@btinternet.com>
Subject: Re: load_policy fails to load policy with ENOENT
From: Richard Haines <richard_c_haines@btinternet.com>
To: Dominick Grift <dac.override@gmail.com>, Stephen Smalley
 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Tue, 15 Nov 2016 15:30:47 +0000
In-Reply-To: <3f6232af-bcf5-661c-2531-28ba6c54fa8f@gmail.com>
References: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
 <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
 <3f6232af-bcf5-661c-2531-28ba6c54fa8f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2016-11-15 at 16:02 +0100, Dominick Grift wrote:
> On 11/15/2016 03:58 PM, Stephen Smalley wrote:
> > 
> > On 11/15/2016 07:19 AM, Dominick Grift wrote:
> > > 
> > > I finished porting dssp-base to dssp1-base, however when i try
> > > testing it load_policy fails with ENOENT.
> > > 
> > > Even though load_policy returns error status the policy seems to
> > > be loaded, except that it is not (or so it seems). When i reboot
> > > the system freezes for whatever reason. Whether it is due to
> > > systemd refusing due to load_policy failure or anything else i am
> > > not sure.
> > > 
> > > I have double checked the policy.
> > > 
> > > 1. secilc has no problems with it 2. the initial sids are
> > > declared
> > > and ordered 3. the classes are there (and the linux classes are
> > > ordered)
> > > 
> > > I cannot think of anything that might cause this and i am looking
> > > for suggestions.
> > > 
> > > It is easy to reproduce:
> > > 
> > > 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
> > > dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
> > > /etc/selinux/targeted/policy/policy.30 
> > > /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
> > > /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
> > > sestatus, seinfo, ps uaxZ
> > > 
> > > I have also uploaded a demo:
> > > 
> > > https://youtu.be/8NCME9dLZd4
> > > 
> > > Suggestions and help are appreciated
> > 
> > Any dmesg output at the time of the failed load?
> > What does strace load_policy show?
> > 
> 
> write(4, "\214\377|\371\10\0\0\0SE
> Linux\36\0\0\0\1\0\0\0\10\0\0\0\7\0\0\0"..., 296645) = -1 ENOENT (No
> such file or directory)
> 
> dmesg shows exactly what it would show on a successful policy load
> AFAICT
> 
> From dmesg there is no indication that anything went wrong (all the
> expected output is there (the stats the unmapped/invalidated
> contexts.
> also sestatus shows that the policy is loaded). It *seems* that only
> load policy throws this error. However as i said the system freezes
> on
> boot and i cannot tell whether that is due to systemd, the policy or
> load_policy.
> 
> following the steps to reproduce will take less than five minutes:
> 
> > 
> > > 
> > > 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
> > > dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
> > > /etc/selinux/targeted/policy/policy.30
> > > /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
> > > /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
> > > sestatus, seinfo, ps uaxZ
> 

I found that the booleans are causing the problem. If you move the
(boolean ...) statements to global space your policy loads (the
booleanif statements are okay where they are). Not sure why yet but
kernel boolean check could get confused with sys.load_kernel_module 

BTW you are missing the netlink_socket class. I have not tried to boot
with the policy but I guess you would also need to update the config
files with the new contexts to boot system !!!
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
