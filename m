Message-ID: <40B5D706.2050902@redhat.com>
Date: Thu, 27 May 2004 07:54:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: Security contexts for the contexts directory?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the new design of the policy tree, we have moved the "contexts" 
files into
/etc/selinux/*/contexts/

These files include default_contexts, file_contexts, default_type, 
failsafe_contexts ...
as well as contexts for individual users like users/root.  Currently the 
security contexts for these files is etc_t.   Should we change them so 
something else? default_contexts_t?  Should file_contexts be marked 
differently then the others?

Also since policy is determined by /etc/sysconfig/selinux, should we set 
a special security context on it?  If we do should we move it to a 
directory where it would be easier to maintain the security context?  
Maybe rename it to /etc/selinux/config?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
