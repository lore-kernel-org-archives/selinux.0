Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: gdsmarshall@hushmail.com, SELinux@tycho.nsa.gov
Subject: Re: This does not look correct....
Date: Fri, 5 Jul 2002 00:15:59 -0400
References: <200207041319.g64DJ8448572@mailserver2.hushmail.com>
In-Reply-To: <200207041319.g64DJ8448572@mailserver2.hushmail.com>
MIME-Version: 1.0
Message-Id: <20020706200822.620C977A1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Jul 2002 09:19, gdsmarshall@hushmail.com wrote:
> I know I have not been trying to configure SELinux for very long, but this
> does not look correct to me.  Should ssh have a getty_t definision?  I know
> it needs one to prevent this error message, but is it correct for ssh to
> have a getty_t definision?
>
> Jul  4 08:05:33 gatekeeper kernel: avc:  denied  { use } for  pid=339
> exe=/usr/b in/ssh path=/dev/tty3 dev=03:01 ino=71770
> scontext=root:sysadm_r:sysadm_ssh_t tc ontext=system_u:system_r:getty_t
> tclass=fd

I've made considerable changes to fd inheriting in my recent policy (much of 
which is not published yet).  After I merge my policy tree with the new NSA 
release I'll release it with a solution to this and many other issues.

In the mean time I suggest just putting the following in your policy:
allow { sysadm_ssh_t user_ssh_t } getty_t:fd use;

This allows the ssh program when run by the user or the sysadm to use the 
file handles of files opened by getty_t.

> I am running debian (woody), with kernel from NSA, and packages from
> Russell's site.

In future please CC me about such issues, it'll get you a faster response and 
is more conveniant for me.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
