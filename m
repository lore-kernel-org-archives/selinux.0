Message-ID: <53710099.9020607@redhat.com>
Date: Mon, 12 May 2014 13:10:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ANN] SELinux userspace release
References: <5369229C.3010707@tycho.nsa.gov> <20140510120315.GB6338@siphos.be>
In-Reply-To: <20140510120315.GB6338@siphos.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 05/10/2014 08:03 AM, Sven Vermeulen wrote:
> On Tue, May 06, 2014 at 01:57:48PM -0400, Stephen Smalley wrote:
>> A new release of the SELinux userspace has been posted to:
>> http://userspace.selinuxproject.org/trac/wiki/Releases
>>
>> For git users, a new tag has been pushed for this release, 20140506
> Thanks; I've provided it for Gentoo users already.
>
> Yesterday I got notified about a vulnerability in libcap-ng & seunshare:
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-3215
>
> I found quite a lot of chatter on RedHat's bugzilla and several potential
> solutions; can we expect that the "proper" solution will be pushed to
> policycoreutils soon as well?
>
> The seunshare.c file hasn't been touched in a while so I assume it isn't in
> yet.
>
> Wkr,
> 	Sven Vermeulen
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
I will send the patches for seunshare, although the fix was actually in
libcap-ng, which caused seunshare to break.
