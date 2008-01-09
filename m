Subject: Re: pam.d
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
        Manoj Srivastava <manoj.srivastava@stdc.com>
In-Reply-To: <dd18b0c30801081342s6a9f12f0n324763d5a25e578c@mail.gmail.com>
References: <dd18b0c30801081342s6a9f12f0n324763d5a25e578c@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 08:17:57 -0500
Message-Id: <1199884677.9393.218.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-01-08 at 13:42 -0800, Justin Mattock wrote:
> Hello; does anybody know how I can fix this problem,
> under /etc/pam.d/login I have: seesion required pam_selinux.so
> multiple. During bootup
> pam.d sets the default context at system_r:sysadm_t then asks if I
> want to change with four optional roles. 
> How can I change the default context to sysadm_r:sysadm_t ? I've tried
> to put session required pam_seinux.so open verbose debug
> in /etc/pam.d/login and still have the default
> context set to system_r:sysadm_t. Under sestatus -vv Init context is =
> system_u:system_r:init_t 
> regards;

What's in /etc/selinux/$SELINUXTYPE/contexts/default_contexts
and /etc/selinux/$SELINUXTYPE/contexts/users/<username>?

In what context is the login process itself running (to see, enter a
username at the login prompt, then in another already logged-in shell,
run ps -eZ | grep login)?
 
Usually though you want to login initially as staff_r:staff_t, then
newrole to sysadm_r when performing admin actions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
