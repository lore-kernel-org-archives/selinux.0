Subject: Re: Troubles with loading modular reference policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tymur Korkishko <timasyk@gmail.com>
Cc: SELinux mailing list <SELinux@tycho.nsa.gov>
In-Reply-To: <a5e2b64d0812091845r2ab1340cob275b1be5980d9ec@mail.gmail.com>
References: <a5e2b64d0812091845r2ab1340cob275b1be5980d9ec@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 08:37:04 -0500
Message-Id: <1228916224.23307.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-12-10 at 11:45 +0900, Tymur Korkishko wrote:
> Hello!
> 
> I'm trying to compile modular reference policy.
> After successful compilation (make policy) and installation (make
> install) I'm trying to load the policy by "make load".
> However, result is as following:
> 
> # make load
> Loading configured modules.
> /usr/sbin/semodule -s refpolicy_modular -b
> /usr/share/selinux/refpolicy_modular/base.pp -i
> /usr/share/selinux/refpolicy_modular/acct.pp ... [skipped all modules
> list]
> Traceback (most recent call last):
>   File "/usr/sbin/genhomedircon", line 29, in <module>
>     import selinux
>   File "/usr/lib/python2.5/site-packages/selinux/__init__.py", line 7,
> in <module>
>     import _selinux
> ImportError: /usr/lib/python2.5/site-packages/selinux/_selinux.so:
> undefined symbol: avc_get_initial_sid
> libsemanage.semanage_install_sandbox: genhomedircon returned error code 1.
> 
> 
> Any ideas how to fix that?

What versions of the selinux packages are you using?
What options did you build them with?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
