Message-ID: <1511965250.10464.5.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Date: Wed, 29 Nov 2017 09:20:50 -0500
In-Reply-To: <1511963807.10464.4.camel@tycho.nsa.gov>
References: <CAPMH7--5mGMZ4UMLM9763ukX-CBOzfUD96_wnCea57+RM8uakw@mail.gmail.com>
 <1511963807.10464.4.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Default User in Selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-11-29 at 08:56 -0500, Stephen Smalley wrote:
> On Wed, 2017-11-29 at 17:19 +0530, Aman Sharma wrote:
> > Hi All,
> > 
> > During System boot up, I am running some semanage commands to
> > change
> > the User to sysadm_u.  But in Cent OS 7.3 , Below error message is
> > coming i.e.  ValueError: Login mapping for __default__ is not
> > defined.
> > 
> > /usr/sbin/semanage login -m -S targeted -s user_u -r s0
> > __default__                
> >     ValueError: Login mapping for __default__ is not defined
> > 
> > But the same command is working fine in Cent OS 6.8. 
> > 
> > Please let me know why this error message is coming for Cent OS 7.
> 
> That suggests something is very wrong with your seusers
> configuration,
> or maybe you have too many underscores before or after default
> (should
> be two _ before and after).

BTW, the command above works fine for me on CentOS 7.4 (don't have 7.3
handy).

> 
> You can delete all local customizations to your seusers configuration
> via semanage login -D.  This will revert to the stock configuration
> in
> your policy package.  Likewise for semanage user -D.
