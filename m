Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6CJS1d1027751
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2007 15:28:02 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6CJS1EW007033
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2007 19:28:01 GMT
Received: by an-out-0708.google.com with SMTP id c38so61381ana
        for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2007 12:28:00 -0700 (PDT)
Message-ID: <8b4cbe570707121228k405bd393ycd108084b942792d@mail.gmail.com>
Date: Thu, 12 Jul 2007 15:28:00 -0400
From: "B Topscher" <bryan@jennandbryan.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: RHEL 5 strict and mls login fails
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_27103_32798485.1184268480750"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_27103_32798485.1184268480750
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I installed the newest version of RHEL 5 out of the box for x86_64
platform.  I installed the selinux-policy-strict, selinux-policy-mls, and
the policycoreutils-newrole package.  I set SELINUXTYPE to mls and left
SELINUX as permissive.  I touched /.autorelabel and rebooted.  After the
relabeling I set SELINUX to enforcing.  When I go to login to the console I
get "no shell: Permission Denied".   I tried it with the strict policy and
got the same results.

I checked the AVN's and it says that locale_login_t cannot execute_no_trans
to shell_exec_t.  So I added that to the system/locallogin.te file
(specifically, allow local_login_t shell_exec_t:file execute_no trans;
allow local_login_t bin_t:file {execute execute_no_trans};
consoletype_domtrans(local_login_t)) in the refpolicy.  I did a make load
and rebooted.  I can now login but I get permission denied when I try and
run newrole.  I also get:

-bash: /bin/hostname: Permission Denied
-bash: /root/.bash_profile: Permission Denied
-bash-3.1#

With FC6 and RHEL5 beta this was never needed.  I could login in eforcing
and mls and then newrole right out of the box.  Has anyone experienced this
or have any suggestions?  Before I start making more changes to the policy I
want to make sure I am not doing something dumb.

My .bash_profile as root is set to root:root:object_r:sysadm_home_t:s0.  I
have the same issue when I try this as root or as a user.

Thank you for any suggestions.

Bryan

------=_Part_27103_32798485.1184268480750
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I installed the newest version of RHEL 5 out of the box for x86_64 platform.&nbsp; I installed the selinux-policy-strict, selinux-policy-mls, and the policycoreutils-newrole package.&nbsp; I set SELINUXTYPE to mls and left SELINUX as permissive.&nbsp; I touched /.autorelabel and rebooted.&nbsp; After the relabeling I set SELINUX to enforcing.&nbsp; When I go to login to the console I get &quot;no shell: Permission Denied&quot;.&nbsp;&nbsp; I tried it with the strict policy and got the same results.
<br><br>I checked the AVN&#39;s and it says that locale_login_t cannot execute_no_trans to shell_exec_t.&nbsp; So I added that to the system/locallogin.te file (specifically, allow local_login_t shell_exec_t:file execute_no trans;&nbsp; allow local_login_t bin_t:file {execute execute_no_trans};&nbsp; consoletype_domtrans(local_login_t)) in the refpolicy.&nbsp; I did a make load and rebooted.&nbsp; I can now login but I get permission denied when I try and run newrole.&nbsp; I also get:
<br><br>-bash: /bin/hostname: Permission Denied<br>-bash: /root/.bash_profile: Permission Denied<br>-bash-3.1# <br><br>With FC6 and RHEL5 beta this was never needed.&nbsp; I could login in eforcing and mls and then newrole right out of the box.&nbsp; Has anyone experienced this or have any suggestions?&nbsp; Before I start making more changes to the policy I want to make sure I am not doing something dumb.
<br><br>My .bash_profile as root is set to root:root:object_r:sysadm_home_t:s0.&nbsp; I have the same issue when I try this as root or as a user.&nbsp; <br><br>Thank you for any suggestions.<br><br>Bryan<br>

------=_Part_27103_32798485.1184268480750--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
