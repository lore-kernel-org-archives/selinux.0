Message-ID: <1513178677.19161.10.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>, SELinux <selinux@tycho.nsa.gov>,
 "centos@centos.org" <centos@centos.org>
Date: Wed, 13 Dec 2017 10:24:37 -0500
In-Reply-To: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:
> Hi All,
> 
> just wanted to know the meaning of line session    required   
>  pam_selinux.so open env_params added in /etc/pam.d/sshd file.
> Actually I am facing one issue related to this. When I changed this
> env_params to restore then my Sftp is not working. 
> 
> Can anybody Please guide me on this.

man pam_selinux describes the options and what they mean.
Why did you change it to restore?  Per the man page, restore is to
temporarily restore the contexts and would be a separate entry in the
PAM stack before the module that needs the original contexts, followed
by a pam_selinux.so open env_params after that module to set them up
again.  But don't use restore unless you actually need it for some
reason.
