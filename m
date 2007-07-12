Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6CL8wAQ002478
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2007 17:08:58 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6CL8vEW023239
	for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2007 21:08:58 GMT
Received: by an-out-0708.google.com with SMTP id c38so69405ana
        for <selinux@tycho.nsa.gov>; Thu, 12 Jul 2007 14:08:57 -0700 (PDT)
Message-ID: <8b4cbe570707121408p5baf95f5ud2bcdf1d19208d14@mail.gmail.com>
Date: Thu, 12 Jul 2007 17:08:57 -0400
From: "B Topscher" <bryan@jennandbryan.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: RHEL 5 strict and mls login fails
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <1184269433.3392.342.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_28472_31202262.1184274537573"
References: <8b4cbe570707121228k405bd393ycd108084b942792d@mail.gmail.com>
	 <1184269433.3392.342.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_28472_31202262.1184274537573
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Actually, that is the Issue.  Thank you.  I did not realize that they were
related.

Thank you
Bryan

On 7/12/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Thu, 2007-07-12 at 15:28 -0400, B Topscher wrote:
> > I installed the newest version of RHEL 5 out of the box for x86_64
> > platform.  I installed the selinux-policy-strict, selinux-policy-mls,
> > and the policycoreutils-newrole package.  I set SELINUXTYPE to mls and
> > left SELINUX as permissive.  I touched /.autorelabel and rebooted.
> > After the relabeling I set SELINUX to enforcing.  When I go to login
> > to the console I get "no shell: Permission Denied".   I tried it with
> > the strict policy and got the same results.
> >
> > I checked the AVN's and it says that locale_login_t cannot
> > execute_no_trans to shell_exec_t.  So I added that to the
> > system/locallogin.te file (specifically, allow local_login_t
> > shell_exec_t:file execute_no trans;  allow local_login_t bin_t:file
> > {execute execute_no_trans};  consoletype_domtrans(local_login_t)) in
> > the refpolicy.  I did a make load and rebooted.  I can now login but I
> > get permission denied when I try and run newrole.  I also get:
> >
> > -bash: /bin/hostname: Permission Denied
> > -bash: /root/.bash_profile: Permission Denied
> > -bash-3.1#
> >
> > With FC6 and RHEL5 beta this was never needed.  I could login in
> > eforcing and mls and then newrole right out of the box.  Has anyone
> > experienced this or have any suggestions?  Before I start making more
> > changes to the policy I want to make sure I am not doing something
> > dumb.
> >
> > My .bash_profile as root is set to
> > root:root:object_r:sysadm_home_t:s0.  I have the same issue when I try
> > this as root or as a user.
>
> Is this the same issue as the "RHEL5 console login problem - pam_selinux
> cannot determine new context" issue reported previously on this list Jun
> 21?  Bug 229542?  Fixed in pam-0.99.6.2-3.15.el5?
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_28472_31202262.1184274537573
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Actually, that is the Issue.&nbsp; Thank you.&nbsp; I did not realize that they were related.<br><br>Thank you<br>Bryan<br><br><div><span class="gmail_quote">On 7/12/07, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a href="mailto:sds@tycho.nsa.gov">
sds@tycho.nsa.gov</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On Thu, 2007-07-12 at 15:28 -0400, B Topscher wrote:<br>
&gt; I installed the newest version of RHEL 5 out of the box for x86_64<br>&gt; platform.&nbsp;&nbsp;I installed the selinux-policy-strict, selinux-policy-mls,<br>&gt; and the policycoreutils-newrole package.&nbsp;&nbsp;I set SELINUXTYPE to mls and
<br>&gt; left SELINUX as permissive.&nbsp;&nbsp;I touched /.autorelabel and rebooted.<br>&gt; After the relabeling I set SELINUX to enforcing.&nbsp;&nbsp;When I go to login<br>&gt; to the console I get &quot;no shell: Permission Denied&quot;.&nbsp;&nbsp; I tried it with
<br>&gt; the strict policy and got the same results.<br>&gt;<br>&gt; I checked the AVN&#39;s and it says that locale_login_t cannot<br>&gt; execute_no_trans to shell_exec_t.&nbsp;&nbsp;So I added that to the<br>&gt; system/locallogin.te file (specifically, allow local_login_t
<br>&gt; shell_exec_t:file execute_no trans;&nbsp;&nbsp;allow local_login_t bin_t:file<br>&gt; {execute execute_no_trans};&nbsp;&nbsp;consoletype_domtrans(local_login_t)) in<br>&gt; the refpolicy.&nbsp;&nbsp;I did a make load and rebooted.&nbsp;&nbsp;I can now login but I
<br>&gt; get permission denied when I try and run newrole.&nbsp;&nbsp;I also get:<br>&gt;<br>&gt; -bash: /bin/hostname: Permission Denied<br>&gt; -bash: /root/.bash_profile: Permission Denied<br>&gt; -bash-3.1#<br>&gt;<br>&gt; With FC6 and RHEL5 beta this was never needed.&nbsp;&nbsp;I could login in
<br>&gt; eforcing and mls and then newrole right out of the box.&nbsp;&nbsp;Has anyone<br>&gt; experienced this or have any suggestions?&nbsp;&nbsp;Before I start making more<br>&gt; changes to the policy I want to make sure I am not doing something
<br>&gt; dumb.<br>&gt;<br>&gt; My .bash_profile as root is set to<br>&gt; root:root:object_r:sysadm_home_t:s0.&nbsp;&nbsp;I have the same issue when I try<br>&gt; this as root or as a user.<br><br>Is this the same issue as the &quot;RHEL5 console login problem - pam_selinux
<br>cannot determine new context&quot; issue reported previously on this list Jun<br>21?&nbsp;&nbsp;Bug 229542?&nbsp;&nbsp;Fixed in pam-0.99.6.2-3.15.el5?<br><br>--<br>Stephen Smalley<br>National Security Agency<br><br></blockquote></div><br>

------=_Part_28472_31202262.1184274537573--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
