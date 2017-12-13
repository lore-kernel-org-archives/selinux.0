Message-ID: <1513192514.25026.5.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Wed, 13 Dec 2017 14:15:14 -0500
In-Reply-To: <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
 <1513178677.19161.10.camel@tycho.nsa.gov>
 <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-12-13 at 21:40 +0530, Aman Sharma wrote:
> Hi Stephen,
> 
> Yes , I am using open env_params for it. But for this, my sftp is not
> working and getting the below error message :
> 
> Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session):
> Unable to get valid context for sftpuser
> Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session
> opened for user sftpuser by (uid=0)
> 
> Please let me know if you have any idea on this.

Do you have any semanage login mapping for sftpuser or is it just using
the __default__ entry? (what does semanage login -l show)  How was
sftpuser created?

You could add the debug option on the pam_selinux.so line to try to get
more information.

You could run selinuxdefcon to query what context would be used for
that user, e.g.
selinuxdefcon sftpuser system_u:system_r:sshd_t:s0-s0.c0123

> 
> On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:
> > > Hi All,
> > >
> > > just wanted to know the meaning of line session    required   
> > >  pam_selinux.so open env_params added in /etc/pam.d/sshd file.
> > > Actually I am facing one issue related to this. When I changed
> > this
> > > env_params to restore then my Sftp is not working. 
> > >
> > > Can anybody Please guide me on this.
> > 
> > man pam_selinux describes the options and what they mean.
> > Why did you change it to restore?  Per the man page, restore is to
> > temporarily restore the contexts and would be a separate entry in
> > the
> > PAM stack before the module that needs the original contexts,
> > followed
> > by a pam_selinux.so open env_params after that module to set them
> > up
> > again.  But don't use restore unless you actually need it for some
> > reason.
> > 
> > 
> > 
> > 
> 
> 
> 
> -- 
> 
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
