Message-ID: <43F73CCF.2020400@cornell.edu>
Date: Sat, 18 Feb 2006 10:27:11 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Genhomedircon - C or Python?
References: <43F56179.3080008@cornell.edu> <43F73BE4.7090206@cornell.edu>
In-Reply-To: <43F73BE4.7090206@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> The function expand_symbol should take arguments:
>
> - a symbol to expand (this will be the regexp, or the context (if 
> there is one))
> - a context (some data structure of unknown type, possibly 
> polymorphic, containing the expansion data)
> - a function  ( (context, name) -> expanded_name)
This looks confused, on the first line I mean a security context (i.e. 
ROLE_something_t).

On the second and third line (and below) I mean an environment/context 
in which things are expanded - i.e. in the context of user root (so name 
= root, selinux_name = root, homedir = /root, and role = sysadm_r), or 
in the context of the /home directory (so home_root = /home).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
