Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o94HDL37019469
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2010 13:13:21 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o94HDKtA024541
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2010 17:13:20 GMT
Received: by pvg16 with SMTP id 16so1404676pvg.12
        for <selinux@tycho.nsa.gov>; Mon, 04 Oct 2010 10:13:19 -0700 (PDT)
Message-ID: <4CAA0B2F.7020204@gmail.com>
Date: Mon, 04 Oct 2010 10:13:19 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
References: <30011.193.5.216.100.1286179426.squirrel@mail.puzzle.ch>
In-Reply-To: <30011.193.5.216.100.1286179426.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/04/2010 01:03 AM, imsand@puzzle.ch wrote:
> Hello
>
> I'm working on SUSE SLES11SP1 and encounter the following problem.
> Setting the context of the User after ssh login doesn't work if the
> SELinux Username and the Linux Username aren't identical.
>
> --------------
> Here is an example (SElinux User=mat_u, Linux User=mat_u):
> Oct  4 09:41:54 testsrv.example sshd[15829]: Accepted
> keyboard-interactive/pam for mat_u from 131.102.233.125 port 54714 ssh2
> Oct  4 09:41:54 testsrv.example sshd[15829]: pam_selinux(sshd:session):
> Open Session
> Oct  4 09:41:54 testsrv.example sshd[15829]: pam_selinux(sshd:session):
> Open Session
> Oct  4 09:41:54 testsrv.example sshd[15829]: pam_selinux(sshd:session):
> Username= mat_u SELinux User = user_u Level= (null)
> Oct  4 09:41:54 testsrv.example sshd[15829]: pam_selinux(sshd:session):
> set mat_u security context to user_u:user_r:user_t
> Oct  4 09:41:54 testsrv.example sshd[15829]: pam_selinux(sshd:session):
> set mat_u key creation context to user_u:user_r:user_t
> ---
> mat_u@testsrv.example:~>  id
> uid=6575(mat_u) gid=100(users) groups=16(dialout),33(video),100(users)
> context=mat_u:staff_r:staff_t
> mat_u@testsrv.example:~>  newrole -r sysadm_r
> mat_u@testsrv.example:~>  id
> uid=6575(mat_u) gid=100(users) groups=16(dialout),33(video),100(users)
> context=mat_u:sysadm_r:sysadm_t
> --------------------
>
> So, this is okey. The user's context after login is "mat_u:staff_r:staff_t"
>
> But, if the Linux User is different from the SELinux User, the default
> user's will be chosen instead.
>
> Here is the example (SELinux User=mat_u, Linux User=mat):
> ---------------------
> Oct  4 09:46:22 testsrv.example sshd[16185]: Accepted
> keyboard-interactive/pam for mat from 131.102.233.125 port 54726 ssh2
> Oct  4 09:46:22 testsrv.example sshd[16185]: pam_selinux(sshd:session):
> Open Session
> Oct  4 09:46:22 testsrv.example sshd[16185]: pam_selinux(sshd:session):
> Open Session
> Oct  4 09:46:22 testsrv.example sshd[16185]: pam_selinux(sshd:session):
> Username= mat SELinux User = mat_u Level= (null)
> Oct  4 09:46:22 testsrv.example sshd[16185]: pam_selinux(sshd:session):
> set mat security context to mat_u:staff_r:staff_t
> Oct  4 09:46:22 testsrv.example sshd[16185]: pam_selinux(sshd:session):
> set mat key creation context to mat_u:staff_r:staff_t
> ---
> mat_u@testsrv.example:~>  id
> uid=6575(mat) gid=100(users) groups=16(dialout),33(video),100(users)
> context=user_u:user_r:user_t
>
> mat_u@testsrv.example:~>  newrole -r sysadm_r
> user_u:sysadm_r:sysadm_t is not a valid context
> ---------------------
>
> As you can see, the pam_selinux module recognizes that the new context
> should be "mat_u:staff_r:staff_t", but for some reason the real context is
> user_u:user_r:user_t. Changing the context with newrole doesn't work
> either...
>
> The user mappings should be okey:
> ------
> semanage user -l | grep mat
> mat_u           staff_r sysadm_r
> testsrv.example:~ # semanage login -l | grep mat
> mat
> -------
>
> Any idea out there? Do I miss something?
> kind regards
> Matthias
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

you can specify the context in 
/etc/selinux/policy/contexts/users/whatroleyouused
(under sshd) I normally set user_r:user_t:s0


Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
