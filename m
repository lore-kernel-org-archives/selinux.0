Message-ID: <42710736.2020001@redhat.com>
Date: Thu, 28 Apr 2005 11:54:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Davide Bolcioni <dbolcioni@3di.it>
CC: fedora-selinux-list@redhat.com, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Is there a SELinux tutorial for ISVs ?
References: <426F8B45.8070509@3di.it> <pan.2005.04.27.23.10.29.993659@navi.cx> <42709B74.4000508@3di.it>
In-Reply-To: <42709B74.4000508@3di.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This string of messages brings up something I wanted to get a 
conversation going on how to handle non OS Provided policy.

We all know we need a better mechanism for handling "binary" policy in 
the future.  ( I think the future is now.)
I see three people providing policy.

1. OS Provider with base policy.  (It would also be nice if the base 
policy got broken into several policies and only the policy
of the running service would be loaded.  If we got to this state we 
would need a new mechanism for restoring file context since
file_context might not meet the currently loaded policy. 

2. Third Party application developers.  As the use of targeted policy 
has begun to take off, Third Party ISV have started to question
how they can play in this world.

I see Tresys Stuff solving the problems of both of the above.

3 Local User customization and minor policies.  Currently we have people 
using audit2allow creating files in domains/misc and then
reloading policy.   We need a mechanism for users to be able to do this 
without recompiling policy.    Also more significantly how
do we handle the small diffed apache_domain stuff.  A couple of months 
ago I redesigned apache policy to have a macro called
apache_domain.  A user could create a new apache_XYZ.te file with

apache_domain(XYZ)
Followed by a few allow rules and be able to get their cgi scripts 
working without turning off apache protection or running their script in
httpd_unconfined_script_t.

The problem is the only way to do this is to install policy sources and 
muck around.    I think we to have some shared library mechanism
where a few well known macros could be defined and users could easily 
build their own custom policy.


Anyways I think we need more discussion on handling third party and user 
customization of policy outside of the current make tree stuff.

Dan

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
