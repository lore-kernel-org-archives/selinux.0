Message-ID: <54E5E3C4.40904@tycho.nsa.gov>
Date: Thu, 19 Feb 2015 08:23:16 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
In-Reply-To: <20150219014803.GB12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/18/2015 08:48 PM, Tracy Reed wrote:
> Hello all,
> 
> I am implementing Multi-Category Security for a client to contain various
> different instances of their web application which all run on the same box.
> This sort of multi-tenant operation seems like a perfect fit for MCS.
> 
> I am using the following guide as a basis for getting started:
> 
> https://www.centos.org/docs/5/html/Deployment_Guide-en-US/sec-mcs-getstarted.html
> 
> However, I am actually running CentOS 6. I can't seem to find a CentOS 6
> version of this guide.
> 
> When I try to add the category to the user I get this error:
> 
> [mcstest:/root]# chcat -l -- +user1 user1
> libsemanage.validate_handler: MLS range s0-s0:c1 for Unix user user1 exceeds allowed range s0 for SELinux user user_u (No such file or directory).
> libsemanage.validate_handler: seuser mapping [user1 -> (user_u, s0-s0:c1)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No such file or directory).
> /usr/sbin/semanage: Could not commit semanage transaction
> 
> Here's some relevant config info:
> 
> [mcstest:/root]# chcat -L 
> s0:c1                          user1
> s0:c2                          user2
> s0:c3                          user3
> s0                             SystemLow
> s0-s0:c0.c1023                 SystemLow-SystemHigh
> s0:c0.c1023                    SystemHigh
> 
> 
> [mcstest:/root]# semanage user -l 
> 
> Labeling   MLS/       MLS/                          
> SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles
> 
> git_shell_u     user       SystemLow  SystemLow                      git_shell_r
> guest_u         user       SystemLow  SystemLow                      guest_r
> root            user       SystemLow  SystemLow-SystemHigh           staff_r sysadm_r system_r unconfined_r
> staff_u         user       SystemLow  SystemLow-SystemHigh           staff_r sysadm_r system_r unconfined_r
> sysadm_u        user       SystemLow  SystemLow-SystemHigh           sysadm_r
> system_u        user       SystemLow  SystemLow-SystemHigh           system_r unconfined_r
> unconfined_u    user       SystemLow  SystemLow-SystemHigh           system_r unconfined_r
> user_u          user       SystemLow  SystemLow                      user_r
> xguest_u        user       SystemLow  SystemLow                      xguest_r
> 
> I notice that the MCS Range for user_u is only SystemLow. In the documentation
> referenced above the output of this command shows user_u as:
> 
> user_u                  user           s0                      s0-s0:c0.c1023    system_r sysadm_r user_r
> 
> so the MCS range is s0-s0:c0.c1023. This seems to be what is missing in my
> setup. But I don't understand how to allow that MCS Range for user_u.
> 
> Any pointers are greatly appreciated. Thanks!

 semanage user -m -r s0-s0:c0.c1023 user_u
