To: Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
References: <36517f76-3d9b-63e3-a259-90ebfd0271e3@ieee.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7f95f7a5-4d25-7a2f-39fa-f34fac50d81e@tycho.nsa.gov>
Date: Mon, 5 Mar 2018 09:03:10 -0500
MIME-Version: 1.0
In-Reply-To: <36517f76-3d9b-63e3-a259-90ebfd0271e3@ieee.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: libsepol policycap names
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/02/2018 01:49 PM, Chris PeBenito wrote:
> I've been able to make SETools dynamically link to libsepol.  However,
> one challenge is with policycap names.  They're static libsepol, with
> nothing that exports them.  Can we either:
> 
> * export the sepol_polcap_getname() function, or
> * move the polcap_names[] in polcaps.c into <sepol/policydb/polcaps.h> ?
> 
> Then I can avoid having to manually keep a polcap name list inside SETools.

Let's do the former (and also export sepol_polcap_getnum for
consistency).  Did you want to spin up a patch or were you asking us to
do so?
