Message-ID: <40B394AF.2000801@redhat.com>
Date: Tue, 25 May 2004 14:47:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: New design for policy on disk allowing multiple policy rpms to be
 simultaniously installed.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As I have been trying to build a new policy we kept on coming up with 
problems in replacing the current policy file with either strict or 
targeted policy.  In the next version of Fedora Core we will be shipping 
a targeted policy on the iso images.  We will continue to make the 
strict policy available separately.  The problem comes in that these 
policy files conflict and we continued to work on how we could allow 
them both to be installed and have the user  fairly easily switch 
between policies.  With this new design, I could envision other policies 
being added in the future and test machines able to switch between the 
policies.

1. We are breaking the policy file out into two separate policy packages

   selinux-policy-strict  (-source also)
        - Containing pretty much the current policy
   selinux-policy-targeted (-source also)
        - Containing a policy where most processed run in unconfined_t 
and only specific services run under a different security context.

2. Both packages obsolete the current policy rpm.

3. We want both policy files  to be installable and not conflict with 
each other.

4. Policy files will  be installed in the /etc/selinux/(strict|targeted) 
directory.
Under this tree there will be at least three additional directiories

policy/
    Containing the compiled policy file

contexts/
    Containing all the contexts files
    file_contexts, default_contexts, default_type
    users/
             Containing user specific default context files.  root in 
particular.

src/
    Containing the policy src directory.

5. Tools and libraries (fixfiles, libselinux, init, and setools) will be 
modified to use the /etc/sysconfig/selinux file to determine which 
policy to currently use on the system and where the policy files are 
located.

6. If during the install /etc/sysconfig/selinux does not exist or does 
not contain an entry for the type of policy,  the first one installed 
will set the context to itself.

cat /etc/sysconfig/selinux
#
# Change the following line to enforcing, permissive or disabled.
# On the next boot the machine will come up in one the selected mode
#
SELINUX=enforcing
#
# Select the type of policy that you are running current values are
#  strict and targeted
#
SELINUXTYPE=strict


So if nothing is in the /etc/sysconfig/selinux file and you install 
strict, strict will be added
to config file. If there is an entry then it will be left there.
This will allow the installation of both the Strict and Targeted policy 
and the user can change the choice via this file and can then relabel

7. We will not use symbolic links.  Use of symbolic links complicates 
policy and requires a user to modify them if he wanted to change the 
security context that he wants to run as.  Also you end up with 
conflicts in the post install scripts which need to replace the old 
symbolic link with a new one.

Comments?

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
