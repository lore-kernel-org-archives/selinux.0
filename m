Subject: Re: RHEL 5 strict and mls login fails
From: Stephen Smalley <sds@tycho.nsa.gov>
To: B Topscher <bryan@jennandbryan.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <8b4cbe570707121228k405bd393ycd108084b942792d@mail.gmail.com>
References: <8b4cbe570707121228k405bd393ycd108084b942792d@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 15:43:53 -0400
Message-Id: <1184269433.3392.342.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-07-12 at 15:28 -0400, B Topscher wrote:
> I installed the newest version of RHEL 5 out of the box for x86_64
> platform.  I installed the selinux-policy-strict, selinux-policy-mls,
> and the policycoreutils-newrole package.  I set SELINUXTYPE to mls and
> left SELINUX as permissive.  I touched /.autorelabel and rebooted.
> After the relabeling I set SELINUX to enforcing.  When I go to login
> to the console I get "no shell: Permission Denied".   I tried it with
> the strict policy and got the same results. 
> 
> I checked the AVN's and it says that locale_login_t cannot
> execute_no_trans to shell_exec_t.  So I added that to the
> system/locallogin.te file (specifically, allow local_login_t
> shell_exec_t:file execute_no trans;  allow local_login_t bin_t:file
> {execute execute_no_trans};  consoletype_domtrans(local_login_t)) in
> the refpolicy.  I did a make load and rebooted.  I can now login but I
> get permission denied when I try and run newrole.  I also get: 
> 
> -bash: /bin/hostname: Permission Denied
> -bash: /root/.bash_profile: Permission Denied
> -bash-3.1# 
> 
> With FC6 and RHEL5 beta this was never needed.  I could login in
> eforcing and mls and then newrole right out of the box.  Has anyone
> experienced this or have any suggestions?  Before I start making more
> changes to the policy I want to make sure I am not doing something
> dumb. 
> 
> My .bash_profile as root is set to
> root:root:object_r:sysadm_home_t:s0.  I have the same issue when I try
> this as root or as a user.  

Is this the same issue as the "RHEL5 console login problem - pam_selinux
cannot determine new context" issue reported previously on this list Jun
21?  Bug 229542?  Fixed in pam-0.99.6.2-3.15.el5?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
