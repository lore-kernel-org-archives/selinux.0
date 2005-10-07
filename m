Message-ID: <4346D351.3070202@redhat.com>
Date: Fri, 07 Oct 2005 15:58:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, Jeremy Katz <katzj@redhat.com>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Loadable Modules and RPM
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeremy and I were talking yesterday about how we could/should package 
the new loadable policy.  
He restated again that policy should be with the RPM package.  So apache 
should contain it's own policy.  

Two problems have always existed with this:
First it eliminates the possibility of having different policies for 
different policy types.  IE it makes it harder to have a apache_targeted 
policy or apache_mls policy.  In practice this is not such a big thing 
since the "Targeted" or server based
policies are mostly common across the currently defined policies.  We 
have one apache policy for Targeted, Strict and MLS with minor tweaks.  
The new policy language has the ability to divine optional sections to 
take care of these differences.

The Second problem involves file context.  Basically the kernel has to 
know the file_context before rpm lays the files down on disk.  Because 
it verifies that system_u:object_r:httpd_exec_t exists.  So applications 
need to install/reload policy before the files get put on disk.  What 
would happen if we changed the kernel to allow certain privileged 
applications to write security context onto disk, which the kernel does 
not understand.  The kernel could just treat these files as 
unlabeled_t.  Then the RPM package could contain the file_context to 
place on disk, install the files with the correct context.  In the post 
install script it could add its policy  and load it into the kernel.  At 
which point the kernel would understand the file context.  

Having policy with the package would then allow us to just update 
individual packages rather then the entire policy package.

Thoughts?

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
