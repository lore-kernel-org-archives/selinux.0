MIME-Version: 1.0
In-Reply-To: <1489754664.29454.2.camel@tycho.nsa.gov>
References: <CAJ2a_DchNhEpB9KWkWFSa6ejSHsuQtUdhCDtF_jDi8etBs4AJA@mail.gmail.com>
 <1489754664.29454.2.camel@tycho.nsa.gov>
From: cgzones <cgzones@googlemail.com>
Date: Fri, 17 Mar 2017 14:51:54 +0100
Message-ID: <CAJ2a_Dc8oao=JG16A__dq_eGrVCDTWcuA-DVRC+qMKqsV9wF5Q@mail.gmail.com>
Subject: Re: newrole as su'ed root
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> Hmmm...Fedora policy doesn't allow use of su from staff_t; you have to
> newrole first and then su.
>
> Regardless, newrole uses the login uid if available, falling back to
> the real uid if not, for the identity used to re-authenticate and to
> set up the environment.  If you want the environment preserved, use -p.
>
Thanks, both ways are working.
