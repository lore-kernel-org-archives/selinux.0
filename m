Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KF9PGU027945
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 11:09:25 -0400
Date: Mon, 20 Jun 2016 15:06:14 +0000 (UTC)
From: Jason Long <hack3rcon@yahoo.com>
Reply-To: Jason Long <hack3rcon@yahoo.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1273112690.1326939.1466435174668.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <84f4eb19-85ee-17db-a7c6-64dd2ec1a021@tycho.nsa.gov>
References: <785947670.864078.1466342123305.JavaMail.yahoo.ref@mail.yahoo.com>
 <785947670.864078.1466342123305.JavaMail.yahoo@mail.yahoo.com>
 <84f4eb19-85ee-17db-a7c6-64dd2ec1a021@tycho.nsa.gov>
Subject: Re: Protect Xen Virtualization via SElinux.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Can you show me some examples for both ?



On Monday, June 20, 2016 5:13 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
On 06/19/2016 09:15 AM, Jason Long wrote:

> Hello.
> How can I protect my Xen VM via SElinux? Can you show me some useful examples?

I'm not entirely sure what you are asking, but possible answers:

1. If you want to apply SELinux-like controls over Xen virtual machines
(domains), then you can use Xen Security Modules and the Flask security
module (commonly abbreviated XSM/Flask) to define and enforce a policy
over the hypervisor objects and operations.

2. If you want to use SELinux to harden the Xen domain-0 or specific
domUs, you can just enable it in those domains and configure your policy
accordingly.

If you want a worked example of applying both XSM/Flask and SELinux,
have a look at OpenXT,
http://openxt.org/
