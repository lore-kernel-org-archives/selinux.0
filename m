Message-ID: <1495035491.32535.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH v5 1/2] selinux: add brief info to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastien Buisson <sbuisson.ddn@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, serge@hallyn.com, james.l.morris@oracle.com, Eric
 Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>, Sebastien
 Buisson <sbuisson@ddn.com>
Date: Wed, 17 May 2017 11:38:11 -0400
In-Reply-To: <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
References: <1494928281-11128-1-git-send-email-sbuisson@ddn.com>
 <1494967240.21557.18.camel@tycho.nsa.gov>
 <CAPkE-bWykonYBssXGphktM7jANY_nbtQi7EVc4uLwjm-fdM8Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-17 at 16:59 +0200, Sebastien Buisson wrote:
> 2017-05-16 22:40 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov>:
> > > +     strcpy(*brief, policydb.policybrief);
> > > +     /* *len is the length of the output string */
> > > +     *len = policybrief_len - 1;
> > 
> > Is there a particular reason to not just return policybrief_len
> > here as
> > well, for consistency in the interface?  How do you intend to use
> > this
> > value in the caller?
> 
> As called in the other patch to expose policy brief via selinuxfs
> (sel_read_policybrief), the intent is to provide the caller with the
> length of the string returned.
> Or should I set *len to policy brief_len here, and just make the
> caller aware that the returned length is in fact the length of the
> buffer (i.e. including terminating NUL byte)?

Looking at the caller usage in the other patch, I guess it makes sense
in its current form.
