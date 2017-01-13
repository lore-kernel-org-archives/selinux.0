Message-ID: <1484321870.32375.46.camel@tycho.nsa.gov>
Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 13 Jan 2017 10:37:50 -0500
In-Reply-To: <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
 <1484251293.16361.3.camel@tycho.nsa.gov>
 <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-01-12 at 20:47 +0000, Alan Jenkins wrote:
> Perhaps the root cause is actually the same.  I still prefer the
> messages from fixfiles though.  It explicitly detected conflicting
> labels on hardlinks
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1411371

On this topic, I have opened an issue for selinux,
https://github.com/SELinuxProject/selinux/issues/43
