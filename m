Message-ID: <1493838844.15269.16.camel@tycho.nsa.gov>
Subject: Re: semanage: is __default__ login map required?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Arnold, Paul C CTR USARMY PEO STRI (US)" <paul.c.arnold4.ctr@mail.mil>,
 selinux@tycho.nsa.gov
Date: Wed, 03 May 2017 15:14:04 -0400
In-Reply-To: <fe3cac69-be05-984f-7a71-28989b3ef93b@mail.mil>
References: <fe3cac69-be05-984f-7a71-28989b3ef93b@mail.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-03 at 13:36 -0400, Arnold, Paul C CTR USARMY PEO STRI
(US) wrote:
> I have been having problems mapping logins since removing
> __default__ 
> from the policy.  Is the __default__ login map required in order for 
> semanage to set a new mapping?
> 
> The error, specifically:
> 
> $ sudo semanage login -a -s existing_u existing_login
> libsemanage.dbase_llist_query: could not query record value
> semanage: Could not query user for existing_login
> 
> 
> Policy is based upon refpolicy, but all utils are RHEL6 dist.

Not sure what is in RHEL6, but upstream it looks like the code tries to
look up the old login/user information before making the change so that
 it can audit the old and new values.  Probably ought to be handling an
exception there and recovering cleanly.

https://github.com/SELinuxProject/selinux/blob/master/python/semanage/seobject.py#L537

https://github.com/SELinuxProject/selinux/commit/a0e538c208e5af07fecb8c045e6341397d0df44a
