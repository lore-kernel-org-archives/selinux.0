Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7SJiiCU028811
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 15:44:44 -0400
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7SJiDEu018466
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 19:44:13 GMT
Received: by rv-out-0708.google.com with SMTP id f25so550274rvb.54
        for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 12:44:41 -0700 (PDT)
Message-ID: <f00ed96d0808281244x34aa8999y7add418d78687e7@mail.gmail.com>
Date: Thu, 28 Aug 2008 15:44:41 -0400
From: Hong <kindloaf@gmail.com>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Subject: About SELinux in Ubuntu
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7745_30315754.1219952681203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_7745_30315754.1219952681203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to use SELinux in Ubuntu 8.04.  Looks like refpolicy is the only
supported policy in the repository.
I downloaded policy.22 (refpolicy).  The size of the binary policy is about
360K(accurate size is 360296), much smaller than targeted policy in Fedora8.
(about 3.5M).

Then I use dispol tool in checkpolicy to display the policy, seems there are
no many useful domains in the policy.  There is no htttpd domain, no ftpd
domain...
And the access vector really confuses me. For example, I think the domain
insmod_t should be entered through insmod, rmmod, ...
But from the policy,  domain insmod_t has the entrypoint privilege over a
lot of types: hplip_etc_t, lpd_tmp_t, proc_afs_t, pam_tmp_t, ... (there are
more than 300 of them).

Did I do anything wrong?  And if I am getting the correct binary policy, why
the entrypoint privilege is configure this way?

Thanks.

------=_Part_7745_30315754.1219952681203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">I am trying to use SELinux in Ubuntu 8.04.&nbsp; Looks like refpolicy is the only supported policy in the repository.<br>I downloaded policy.22 (refpolicy).&nbsp; The size of the binary policy is about 360K(accurate size is 360296), much smaller than targeted policy in Fedora8. (about 3.5M).<br>
<br>Then I use dispol tool in checkpolicy to display the policy, seems there are no many useful domains in the policy.&nbsp; There is no htttpd domain, no ftpd domain...<br>And the access vector really confuses me. For example, I think the domain insmod_t should be entered through insmod, rmmod, ... <br>
But from the policy,&nbsp; domain insmod_t has the entrypoint privilege over a lot of types: hplip_etc_t, lpd_tmp_t, proc_afs_t, pam_tmp_t, ... (there are more than 300 of them).<br><br>Did I do anything wrong?&nbsp; And if I am getting the correct binary policy, why the entrypoint privilege is configure this way?<br>
<br>Thanks.<br></div>

------=_Part_7745_30315754.1219952681203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
