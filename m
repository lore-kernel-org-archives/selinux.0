Message-Id: <200503311915.j2VJFV8R022740@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Cc: <selinux-dev@tresys.com>
Subject: RE: Question about customizing apache policy.
Date: Thu, 31 Mar 2005 14:15:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <424C1B73.6020508@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Daniel J Walsh
> Sent: Thursday, March 31, 2005 10:47 AM
> To: SELinux
> Subject: Question about customizing apache policy.
> 
> There was a question yesterday in one of the fedora list, from a person
> who would like to run a special httpd script that would manage his
> passwd file, now whether or not this is a good idea, it caused me to try
> an experiment.
> Currently we have a  macro apache_domain.  I thought it would be cool if
> I could start writing policy for this passwd app by adding a file to
> domains/misc/apachepasswd.te.  Then having one line
> apache_domain(passwd)
> 
> Which in theory would create httpd_passwd_script_exec_t,
> httpd_passwd_script_t, httpd_passwd_script_rw_t.  I could then go ahead
> and label my cgi httpd_passwd_script_exec_t and start adding the
> additional allow rules to allow this to happen.  Needless to say, we
> have added a lot of cruft to the apache_domain() macro.  So I did some
> cleanup of apache.te and apache_macro.te, see attach.
> Could people review these to make sure there is no mistakes.
> But this exercise also brought up the idea that this would be an
> excellent example of how we would want to use loadable modules. I think
> that this might be a fairly common problem.  People want to run a
> specialized apache cgi script that slightly extends httpd_sys_script_t.
> 
> It would be cool if they could do this without having to have policy
> installed, but a simple boiler plate for adding a new type of httpd
> script type.
> 
> Ideas?
> 

No ideas - just a confirmation of the need, which I was talking about a while
ago during the EXTENDS discussion. We are really talking about moving some
specialized form of macros into the language for those cases when runtime
expansion during module loading is necessary. You provide one example and the
other example that I always use is the types generated for roles/user domains,
e.g., staff_ssh_t.

Just one note, is that this means that this would make it harder for a module
author to understand the actual access that his policy allowed. This problem
already exists in the loadable modules because of attribute expansion (which
happens at module load time), but this could make it worse.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> Dan
> 
> --
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
