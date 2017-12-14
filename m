Message-ID: <1513259397.18008.3.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 14 Dec 2017 08:49:57 -0500
In-Reply-To: <CAPMH7-9F4H_e-VmHqOzdpCq0JkN-y71-ye152yBixZrHHmOd5g@mail.gmail.com>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
 <1513178677.19161.10.camel@tycho.nsa.gov>
 <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
 <1513192514.25026.5.camel@tycho.nsa.gov>
 <CAPMH7-9F4H_e-VmHqOzdpCq0JkN-y71-ye152yBixZrHHmOd5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-12-14 at 12:48 +0530, Aman Sharma wrote:
> Hi All,
> 
> Below is the output of semanage USer command output for sftpuser:
> 
> specialuser_u   user       s0         s0                           
>  sysadm_r system_r
> 
> and for command semanage login -l , output is :
> 
> sftpuser             specialuser_u        s0                   *
> 
> and also, after adding the debugging option, its showing the below
> error message as 
> 
> Dec 13 15:46:10 cucmSUB authpriv 3 sshd: pam_selinux(sshd:session):
> Unable to get valid context for sftpuser
> Dec 13 15:46:10 cucmSUB authpriv 5 sshd: pam_selinux(sshd:session):
> Open Session
> Dec 13 15:46:11 cucmSUB authpriv 7 sshd: pam_selinux(sshd:session):
> Username= sftpuser SELinux User= specialuser_u Level= s0
> Dec 13 15:46:11 cucmSUB authpriv 3 sshd: pam_selinux(sshd:session):
> Unable to get valid context for sftpuser
> 
> also Selinuxdefcon command is showing error while running for
> sftpuser i.e. 
> sudo /usr/sbin/selinuxdefcon sftpuser system_u:system_r:sshd_t:s0
> /usr/sbin/selinuxdefcon: Invalid argument
> 
> Please let me know your comments on this.

Is there a reason why you've added your own unique SELinux user and
login entries for sftpuser rather than either just mapping to one of
the existing users if you want it to be confined or leaving it
unspecified and just using the __default__ entry if you want it to be
unconfined?

The entries above say that sftpuser is to be mapped to specialuser_u,
and that specialuser_u can only use the sysadm_r or system_r roles.  To
make that work, you would also need to enable the ssh_sysadm_login
boolean and cp /etc/selinux/targeted/contexts/users/sysadm_u
/etc/selinux/targeted/contexts/users/specialuser_u.  But that seems
pointless since you could just leave it unmapped or map it to sysadm_u
in the first place if that was really what you wanted.

If you want sftpuser to be unrestricted, just remove the mappings, i.e.
$ sudo semanage login -d sftpuser
$ sudo semanage user -d specialuser_u
$ selinuxdefcon sftpuser system_u:system_r:sshd_t:s0-s0:c0.c1023
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
